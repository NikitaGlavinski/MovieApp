//
//  DetailMovieView.swift
//  MovieApp
//
//  Created by Mikita Glavinski on 12/16/21.
//

import SwiftUI

struct DetailMovieView: View {
    
    var movieId: Int
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject var viewModel = DetailMovieViewModel()
    
    @State private var isVideoPresented = false
    
    init(movieId: Int) {
        self.movieId = movieId
    }
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    ZStack {
                        MoviePosterView(model: viewModel.detailModel)
                        VStack(spacing: 5) {
                            Button {
                                isVideoPresented.toggle()
                            } label: {
                                Image(systemName: "play.circle")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .foregroundColor(.yellow)
                                    .frame(width: 70, height: 70)
                            }
                            .sheet(isPresented: $isVideoPresented) {
                                VideoView(movieId: movieId)
                            }
                            Text(viewModel.detailModel.title)
                                .font(.system(size: 24, weight: .medium, design: .default))
                                .foregroundColor(.white)
                        }
                    }
                    Text("OVERVIEW")
                        .font(.system(size: 15, weight: .semibold, design: .default))
                        .foregroundColor(.gray)
                        .frame(width: UIScreen.main.bounds.width, alignment: .leading)
                        .padding(EdgeInsets(top: 50, leading: 20, bottom: 0, trailing: 0))
                    Text(viewModel.detailModel.overview ?? "")
                        .lineLimit(2)
                        .frame(width: UIScreen.main.bounds.width - 20, alignment: .leading)
                        .font(.system(size: 13, weight: .regular, design: .default))
                        .foregroundColor(.gray)
                        .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                        .offset(y: 5)
                    HStack {
                        VStack(alignment: .leading ,spacing: 3) {
                            Text("RELEASE DATE")
                                .font(.system(size: 15, weight: .semibold, design: .default))
                                .foregroundColor(.gray)
                            Text(viewModel.detailModel.releaseDate)
                                .font(.system(size: 13, weight: .semibold, design: .default))
                                .foregroundColor(.orange)
                        }
                        Spacer()
                        VStack(alignment: .leading ,spacing: 3) {
                            Text("RUN TIME")
                                .font(.system(size: 15, weight: .semibold, design: .default))
                                .foregroundColor(.gray)
                            Text(String(viewModel.detailModel.runTime ?? 0) + " min")
                                .font(.system(size: 13, weight: .semibold, design: .default))
                                .foregroundColor(.orange)
                        }
                        Spacer()
                        VStack(alignment: .leading ,spacing: 3) {
                            Text("BUDGET")
                                .font(.system(size: 15, weight: .semibold, design: .default))
                                .foregroundColor(.gray)
                            Text(String(viewModel.detailModel.budget) + " $")
                                .font(.system(size: 13, weight: .semibold, design: .default))
                                .foregroundColor(.orange)
                        }
                    }
                    .padding(EdgeInsets(top: 20, leading: 20, bottom: 0, trailing: 20))
                    Text("SCREENSHOTS")
                        .font(.system(size: 15, weight: .semibold, design: .default))
                        .foregroundColor(.gray)
                        .frame(width: UIScreen.main.bounds.width, alignment: .leading)
                        .padding(EdgeInsets(top: 2, leading: 20, bottom: 0, trailing: 0))
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 15) {
                            ForEach(viewModel.movieImages, id: \.filePath) { image in
                                ScreenshotView(model: image)
                            }
                        }
                        .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                        .onAppear {
                            self.viewModel.getMovieImages(id: self.movieId)
                        }
                    }
                    Text("CASTS")
                        .font(.system(size: 15, weight: .semibold, design: .default))
                        .foregroundColor(.gray)
                        .frame(width: UIScreen.main.bounds.width, alignment: .leading)
                        .padding(EdgeInsets(top: 2, leading: 20, bottom: 0, trailing: 0))
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 15) {
                            ForEach(viewModel.popularActors, id: \.id) { person in
                                ActorImageView(path: person.photoPath ?? "")
                            }
                        }
                        .padding(EdgeInsets(top: 0, leading: 20, bottom: 40, trailing: 20))
                    }
                }
            }
            .onAppear(perform: {
                self.viewModel.getPopularActors()
                self.viewModel.getDetailMovie(id: self.movieId)
            })
            .navigationBarHidden(true)
            .edgesIgnoringSafeArea(.all)
            Button {
                self.presentationMode.wrappedValue.dismiss()
            } label: {
                Image(systemName: "chevron.left")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30, height: 30)
                    .foregroundColor(.white)
            }
            .padding(EdgeInsets(top: 15, leading: 20, bottom: 0, trailing: 0))
        }
        .alert(isPresented: $viewModel.error.isShown) {
            Alert(title: Text("Error"), message: Text(viewModel.error.message), dismissButton: .default(Text("Ok")))
        }
    }
}

struct DetailMovieView_Previews: PreviewProvider {
    static var previews: some View {
        DetailMovieView(movieId: 0)
    }
}
