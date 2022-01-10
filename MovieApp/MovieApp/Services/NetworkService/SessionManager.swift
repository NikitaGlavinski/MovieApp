//
//  SessionManager.swift
//  MovieApp
//
//  Created by Mikita Glavinski on 12/15/21.
//

import Foundation
import Alamofire

protocol SessionManagerProtocol {
    associatedtype EndPoint: NetworkApi
    func makeRequest(endPoint: EndPoint, completion: @escaping (_ data: Data?, _ error: Error?) -> ())
}

class SessionManager<EndPoint: NetworkApi>: SessionManagerProtocol {
    
    private var baseUrl: String
    private var queue = DispatchQueue(label: "NetworkResponseQueue", qos: .background)
    
    init(baseUrl: String) {
        self.baseUrl = baseUrl
    }
    
    func makeRequest(endPoint: EndPoint, completion: @escaping (_ data: Data?, _ error: Error?) -> ()) {
        guard let url = try? makeURL(url: baseUrl + endPoint.path, parameters: endPoint.urlParameters) else { return }
        AF.request(
            url,
            method: endPoint.httpMethod,
            parameters: endPoint.bodyParameters,
            encoding: JSONEncoding.default,
            headers: endPoint.headers
        )
            .cURLDescription(calling: { curl in
                print(curl)
            })
            .response(queue: queue) { response in
                if let error = response.error {
                    completion(nil, error)
                    return
                }
                
                guard
                    let data = response.data,
                    let statusCode = response.response?.statusCode,
                    (200..<301).contains(statusCode)
                else {
                    completion(nil, NetworkError.noData)
                    return
                }
                completion(data, nil)
            }
    }
    
    private func makeURL(url: String, parameters: [String: Any]?) throws -> URL {
        guard let url = URL(string: url) else { throw NetworkError.encodingError }
        if let parameters = parameters {
            if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) {
                urlComponents.queryItems = [URLQueryItem]()
                
                for (key, value) in parameters {
                    let queryItem = URLQueryItem(name: key, value: "\(value)".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed))
                    urlComponents.queryItems?.append(queryItem)
                }
                guard let finalURL = urlComponents.url else { throw NetworkError.encodingError }
                return finalURL
            }
        }
        return url
    }
}
