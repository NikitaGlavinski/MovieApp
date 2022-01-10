//
//  ContentView.swift
//  MovieApp
//
//  Created by Mikita Glavinski on 12/14/21.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel = ContentViewModel()
    @State var selectedGenreId: Int = 28
    
    private var isAlredyShowed = false
    
    func getZoomValue(localMidX: CGFloat, mainWidth: CGFloat) -> CGFloat {
        let first = max(1 - abs(((localMidX - mainWidth + UIScreen.main.bounds.width / 2) / 2) / 300), 0.7)
        let second = min(first, 1.0)
        return second
    }
    
    var body: some View {
        NavigationView {
            GeometryReader { mainReader in
                ScrollView(.vertical, showsIndicators: false) {
                    VStack {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: -25) {
                                ForEach(viewModel.filteredPopularMovie, id: \.id) { movie in
                                    NavigationLink(destination: NavigationLazyView(DetailMovieView(movieId: movie.id))) {
                                        GeometryReader { geo in
                                            PopularMovieView(path: movie.backdropPath ?? "", title: movie.title ?? "")
                                                .scaleEffect(getZoomValue(localMidX: geo.frame(in: .global).midX, mainWidth: mainReader.size.width))
                                        }
                                        .frame(width: UIScreen.main.bounds.width - 100, height: 200)
                                    }
                                }
                                Button {
                                    self.viewModel.getPopularMovies()
                                } label: {
                                    Text("Show more")
                                        .frame(width: 120, height: 30)
                                        .background(Color.black)
                                        .foregroundColor(.white)
                                        .clipShape(Capsule())
                                }
                                .padding(.leading, 35)
                            }
                            .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 30))
                        }
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 5) {
                                ForEach(viewModel.movieGenres, id: \.id) { genre in
                                    GenreButton(selectedId: $selectedGenreId, viewModel: self.viewModel, genreModel: genre)
                                }
                            }
                            .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 30))
                        }
                        Text("NEW PLAYING")
                            .font(.system(size: 11, weight: .regular, design: .default))
                            .foregroundColor(.gray)
                            .frame(width: UIScreen.main.bounds.width, alignment: .leading)
                            .padding(EdgeInsets(top: 15, leading: 20, bottom: 0, trailing: 0))
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 10) {
                                ForEach(viewModel.newMovies, id: \.id) { movie in
                                    NavigationLink(destination: NavigationLazyView(DetailMovieView(movieId: movie.id))) {
                                        NewPlayingView(model: movie)
                                            .frame(width: UIScreen.main.bounds.width / 2)
                                    }
                                }
                                Button {
                                    self.viewModel.getNewMovies()
                                } label: {
                                    Text("Show more")
                                        .frame(width: 120, height: 30)
                                        .background(Color.black)
                                        .foregroundColor(.white)
                                        .clipShape(Capsule())
                                }
                            }
                            .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 30))
                        }
                        Text("TRENDING PERSONS ON THIS WEEK")
                            .font(.system(size: 11, weight: .regular, design: .default))
                            .foregroundColor(.gray)
                            .frame(width: UIScreen.main.bounds.width, alignment: .leading)
                            .padding(EdgeInsets(top: 15, leading: 20, bottom: 0, trailing: 0))
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 15) {
                                ForEach(viewModel.popularActors, id: \.id) { person in
                                    ActorImageView(path: person.photoPath ?? "")
                                }
                            }
                            .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 30))
                        }
                        .onAppear {
                            if !viewModel.isAlreadyShowed {
                                loadMovies()
                            }
                        }
                        Spacer()
                    }
                }
            }
            .navigationBarTitle(Text("MOVIES"), displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        //
                    } label: {
                        Image(systemName: "list.bullet")
                            .frame(width: 50.0, height: 50.0)
                            .foregroundColor(Color.black)
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        //
                    } label: {
                        Image("profile")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 40.0, height: 40.0)
                            .clipShape(Circle())
                    }
                }
            }
        }
        .alert(isPresented: $viewModel.error.isShown) {
            Alert(title: Text("Error"), message: Text(viewModel.error.message), dismissButton: .default(Text("Ok")))
        }
    }
    
    private func loadMovies() {
        self.viewModel.getPopularMovies()
        self.viewModel.getPopularActors()
        self.viewModel.getNewMovies()
        self.viewModel.getGenres()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPhone 12")
    }
}
