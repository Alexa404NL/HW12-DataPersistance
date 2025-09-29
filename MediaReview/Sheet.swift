//
//  sheet.swift
//  MediaReview
//
//  Created by Alexa Nohemi Lara Carvajal on 28/09/25.
//

import SwiftUI
import SwiftData

struct Sheet: View {
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) var context
    
    var song : Song?
    
    private var NavTitle : String {
        song == nil ? "Add New Song" : "Edit Song"
    }
    
    @State private var name : String = ""
    @State private var genre : String = ""
    @State private var image : String = ""
    @State private var rating : Double = 0.0
    
    init(song : Song? = nil) {
        self.song = song
        if let song {
            _name = State(initialValue: song.name)
            _genre = State(initialValue: song.genre)
            _image = State(initialValue: song.image)
            _rating = State(initialValue: song.rating)
        }
    }
    
    var body: some View {
        NavigationStack{
            Form{
                TextField("Title", text: $name)
                TextField("Genre", text: $genre)
                TextField("Image URL or SF Symbol Name", text: $image)
                
                HStack {
                    Text("Rating")
                    Spacer()
                    StarRatingView(rating: $rating)
                }
            }
            .navigationTitle(NavTitle)
            .navigationBarTitleDisplayMode(.large)
            .toolbar{
                ToolbarItemGroup(placement: .topBarLeading){
                    Button("Cancel"){
                        dismiss()
                    }
                }
                ToolbarItemGroup(placement: .topBarTrailing){
                    Button(song == nil ? "Save" : "Update"){
                        if let song {
                            song.name = name
                            song.genre = genre
                            song.image = image
                            song.rating = rating
                        } else{
                            let newSong = Song(name: name, genre: genre, image: image, rating: rating)
                            context.insert(newSong)
                        }
                        
                        try? context.save()
                        dismiss()
                    }
                    .disabled(name.isEmpty)
                }
            }
        }
    }
}


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

#Preview {
    Sheet()
        .modelContainer(for: [Song.self], inMemory: true)
}
