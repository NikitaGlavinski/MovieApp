//
//  ImageLoader.swift
//  MovieApp
//
//  Created by Mikita Glavinski on 12/14/21.
//

import SwiftUI
import Combine

class ImageLoader: ObservableObject {
    
    var didChange = PassthroughSubject<Data, Never>()
    var data = Data() {
        didSet {
            didChange.send(data)
        }
    }
    
    let baseUrl = "https://image.tmdb.org/t/p/w500"
    
    init(url: String) {
        guard let url = URL(string: url) else { return }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let data = data,
                error == nil
            else { return }
            DispatchQueue.main.async {
                self.data = data
            }
        }
        task.resume()
    }
    
    func getTest() -> AnyPublisher<UIImage, Error> {
        return Result.Publisher(UIImage(named: "profile")!).eraseToAnyPublisher()
    }
}
