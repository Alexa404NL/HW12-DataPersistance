//
//  Movie.swift
//  MovieReview
//
//  Created by Alexa Nohemi Lara Carvajal on 28/09/25.
//

import Foundation
import SwiftData

@Model
class Song {
    var id = UUID()
    var name : String
    var genre : String
    var image : String
    var rating : Double
    
    init(name: String, genre: String, image: String, rating: Double) {
        self.id = UUID()
        self.name = name
        self.genre = genre
        self.image = image
        self.rating = rating
    }
}
