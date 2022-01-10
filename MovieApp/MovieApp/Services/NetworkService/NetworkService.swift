//
//  NetworkService.swift
//  MovieApp
//
//  Created by Mikita Glavinski on 12/15/21.
//

import Foundation

enum NetworkError: String, Error {
    case noData = "There is no data."
    case encodingError = "Encoding error."
    case decodingError = "Decoding error."
    case unrecognized = "UNRECOGNIZED"
}

protocol NetworkServiceProtocol {
    func getPopularMovies(language: String, page: Int, completion: @escaping (Result<MovieListResponse, Error>) -> ())
    func getMovieGenres(completion: @escaping (Result<MovieGenreResponse, Error>) -> ())
    func getNewMovies(page: Int, completion: @escaping (Result<MovieListResponse, Error>) -> ())
    func getPopularActors(page: Int, completion: @escaping (Result<ActorListResponse, Error>) -> ())
    func getDetailMovie(id: Int, completion: @escaping (Result<DetailMovieModel, Error>) -> ())
    func getMovieImages(movieId: Int, completion: @escaping (Result<MovieImagesResponse, Error>) -> ())
    func getMovieVideos(movieId: Int, completion: @escaping (Result<VideoResponse, Error>) -> ())
}

class NetworkService: NetworkServiceProtocol {
    
    static let shared: NetworkServiceProtocol = NetworkService()
    private init() {}
    
    private let sessionManager = SessionManager<NetworkMovieApi>(baseUrl: "https://api.themoviedb.org/3")
    
    private func sessionRequest<T: Decodable>(endPoint: NetworkMovieApi, decodeType: T.Type, completion: @escaping (Result<T, Error>) -> ()) {
        sessionManager.makeRequest(endPoint: endPoint) { data, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            do {
                let responseModel = try JSONDecoder().decode(decodeType, from: data)
                completion(.success(responseModel))
            } catch let error {
                completion(.failure(error))
            }
        }
    }
    
    func getPopularMovies(language: String, page: Int, completion: @escaping (Result<MovieListResponse, Error>) -> ()) {
        sessionRequest(endPoint: .popularMovies(language: language, page: page), decodeType: MovieListResponse.self, completion: completion)
    }
    
    func getMovieGenres(completion: @escaping (Result<MovieGenreResponse, Error>) -> ()) {
        sessionRequest(endPoint: .movieGenres, decodeType: MovieGenreResponse.self, completion: completion)
    }
    
    func getNewMovies(page: Int, completion: @escaping (Result<MovieListResponse, Error>) -> ()) {
        sessionRequest(endPoint: .newMovies(page: page), decodeType: MovieListResponse.self, completion: completion)
    }
    
    func getPopularActors(page: Int, completion: @escaping (Result<ActorListResponse, Error>) -> ()) {
        sessionRequest(endPoint: .getPopularActors(page: page), decodeType: ActorListResponse.self, completion: completion)
    }
    
    func getDetailMovie(id: Int, completion: @escaping (Result<DetailMovieModel, Error>) -> ()) {
        sessionRequest(endPoint: .getDetailMovie(id: id), decodeType: DetailMovieModel.self, completion: completion)
    }
    
    func getMovieImages(movieId: Int, completion: @escaping (Result<MovieImagesResponse, Error>) -> ()) {
        sessionRequest(endPoint: .getMovieImages(movieId: movieId), decodeType: MovieImagesResponse.self, completion: completion)
    }
    
    func getMovieVideos(movieId: Int, completion: @escaping (Result<VideoResponse, Error>) -> ()) {
        sessionRequest(endPoint: .getMovieVideos(movieId: movieId), decodeType: VideoResponse.self, completion: completion)
    }
}
