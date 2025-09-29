//
//  sheet.swift
//  MediaReview
//
//  Created by Alexa Nohemi Lara Carvajal on 28/09/25.
//

import SwiftUI
import SwiftData
import PhotosUI

struct StarRatingView: View {
    @Binding var rating: Double
    private let maxRating: Int = 5
    private let offColor = Color.gray
    private let onColor = Color.yellow
    
    var body: some View {
        HStack {
            ForEach(1...maxRating, id: \.self) { number in
                Image(systemName: "star.fill")
                    .foregroundStyle(number > Int(rating) ? offColor : onColor)
                    .onTapGesture {
                        rating = Double(number)
                    }
            }
        }
    }
}

struct Sheet: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) var context
    
    var song : Song?
    
    private var NavTitle : String {
        song == nil ? "Add New Song" : "Edit Song"
    }
    
    @State private var name : String = ""
    @State private var genre : String = ""
    @State private var rating : Double = 0.0
    
    init(song : Song? = nil) {
        self.song = song
        if let song {
            _name = State(initialValue: song.name)
            _genre = State(initialValue: song.genre)
            _rating = State(initialValue: song.rating)
        }
    }
    
    var body: some View {
           NavigationStack {
               Form {
                   TextField("Title", text: $name)
                   TextField("Genre", text: $genre)
                   HStack {
                       Text("Rating")
                       Spacer()
                       StarRatingView(rating: $rating)
                   }
               }
               .navigationTitle("Song")
               .navigationBarTitleDisplayMode(.large)
               .toolbar {
                   ToolbarItemGroup(placement: .topBarLeading) {
                       Button("Cancel") {
                           dismiss()
                       }
                   }
                   
                   ToolbarItemGroup(placement: .topBarTrailing) {
                       Button(song == nil ? "Save" : "Update") {
                           if let song {
                               song.name = name
                               song.genre = genre
                               song.rating = rating
                           } else {
                               guard Song.isValidName(name) else {return}
                               guard Song.isValidgenre(genre) else {return}
                               guard Song.notEmptyRating(rating) else {return}
                               let newSong = Song(name: name, genre: genre, rating: rating)
                               context.insert(newSong)
                           }
                           
                           try? context.save()
                           dismiss()
                       }
                       .disabled(name.isEmpty)
                       .disabled(genre.isEmpty)
                       .disabled(rating.isZero)
                   }
               }
           }
       }
   }

#Preview {
    Sheet()
        .modelContainer(for: [Song.self], inMemory: true)
}
