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
    //var image : Data?
    var rating : Double
    
    init(name: String, genre: String, rating: Double) {
        self.id = UUID()
        self.name = name
        self.genre = genre
        //self.image = image
        self.rating = rating
    }
    
    static func isValidName (_ name : String ) -> Bool {
        !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    static func isValidgenre (_ genre : String ) -> Bool {
        !genre.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    static func notEmptyRating (_ rating : Double ) -> Bool {
        return rating > 0.0
    }
}
