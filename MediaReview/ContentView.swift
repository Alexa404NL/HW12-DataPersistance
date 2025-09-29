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
    @Query(sort: \Song.rating) var songs : [Song]
    
    
    @State private var isShowingItemSheet = false
    @State private var ToEdit: Song?
        
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

        }
        
        
    }
}

#Preview {
    ContentView()
        .modelContainer(for: [Song.self], inMemory: true)
}
