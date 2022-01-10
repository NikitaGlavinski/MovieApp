//
//  ContentVieModel.swift
//  MovieApp
//
//  Created by Mikita Glavinski on 12/14/21.
//

import SwiftUI

class ContentViewModel: ObservableObject {
    
    var popularMovies = [MovieModel]()
    @Published var filteredPopularMovie = [MovieModel]()
    @Published var movieGenres = [MovieGenre]()
    @Published var newMovies = [MovieModel]()
    @Published var popularActors = [ActorModel]()
    @Published var isAlreadyShowed = false
    @Published var error = ErrorView(isShown: false, message: "")
    private var currentPopularPage = 0
    private var currentNewPage = 0
    private var selectedGenreId = 28
    
    func getPopularMovies() {
        isAlreadyShowed = true
        NetworkService.shared.getPopularMovies(language: "en-US", page: currentPopularPage + 1) { result in
            switch result {
            case .success(let response):
                self.currentPopularPage = response.page
                self.popularMovies += response.results
                DispatchQueue.main.async {
                    self.filterByGenre(genreId: self.selectedGenreId)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.error = ErrorView(isShown: true, message: error.localizedDescription)
                }
            }
        }
    }
    
    func getGenres() {
        NetworkService.shared.getMovieGenres { result in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self.movieGenres = response.genres
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.error = ErrorView(isShown: true, message: error.localizedDescription)
                }
            }
        }
    }
    
    func filterByGenre(genreId: Int) {
        selectedGenreId = genreId
        filteredPopularMovie = popularMovies.filter({$0.genreIds.contains(genreId)})
    }
    
    func getNewMovies() {
        NetworkService.shared.getNewMovies(page: currentNewPage + 1) { result in
            switch result {
            case .success(let response):
                self.currentNewPage = response.page
                DispatchQueue.main.async {
                    self.newMovies += response.results
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.error = ErrorView(isShown: true, message: error.localizedDescription)
                }
            }
        }
    }
    
    func getPopularActors() {
        NetworkService.shared.getPopularActors(page: 1) { result in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self.popularActors += response.results
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.error = ErrorView(isShown: true, message: error.localizedDescription)
                }
            }
        }
    }
}
