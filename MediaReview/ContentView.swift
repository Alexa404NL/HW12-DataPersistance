//
//  ContentView.swift
//  MovieReview
//
//  Created by Alexa Nohemi Lara Carvajal on 28/09/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) private var dismiss
    @Query(sort: \Song.rating,  order: .reverse) var songs : [Song]

    @State private var isShowingItemSheet = false
    @State private var ToEdit: Song?
    @State private var error: Error?
    @State private var isShowingErrorAlert = false
    
    var body: some View {
        NavigationStack{
            List{
                ForEach(songs) { item in
                    Text(item.name)
                        .onTapGesture {
                            ToEdit = item
                        }
                }
                .onDelete { indexSet in
                    for index in indexSet {
                        context.delete(songs[index])
                    }
                }
            }
            .navigationTitle("Listened Songs")
            .navigationBarTitleDisplayMode(.large)
            .sheet(isPresented: $isShowingItemSheet) {
                Sheet()
            }
            .sheet(item: $ToEdit){ song in
                Sheet(song: song)
            }
           
            .toolbar{
                Button("Add", systemImage: "plus"){
                    isShowingItemSheet = true
                }
            }
            
            .alert("An error occurred", isPresented: $isShowingErrorAlert) {
                Button("OKK"){
                    dismiss()
                }
            } message: {
                Text(error?.localizedDescription ?? "Please try again.")
            }

        }
    }
}


#Preview {
    ContentView()
        .modelContainer(for: [Song.self], inMemory: true)
}
