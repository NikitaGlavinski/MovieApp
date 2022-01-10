//
//  PopularMovieView.swift
//  MovieApp
//
//  Created by Mikita Glavinski on 12/14/21.
//

import SwiftUI

struct PopularMovieView: View {
    
    var path: String
    var title: String
    
    init(path: String, title: String) {
        self.path = path
        self.title = title
    }
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            PopularMovieImage(path: self.path)
            Text(self.title)
                .font(.system(size: 21, weight: .medium, design: .monospaced))
                .lineLimit(2)
                .foregroundColor(Color(red: 250/255, green: 250/255, blue: 250/255, opacity: 1))
                .frame(width: UIScreen.main.bounds.width - 130, alignment: .leading)
                .offset(x: 15, y: -15)
        }
    }
}

struct PopularMovieView_Previews: PreviewProvider {
    static var previews: some View {
        PopularMovieView(path: "/ndlQ2Cuc3cjTL7lTynw6I4boP4S.jpg", title: "Title")
    }
}
