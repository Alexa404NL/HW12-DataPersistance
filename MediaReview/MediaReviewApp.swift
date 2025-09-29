//
//  MovieReviewApp.swift
//  MovieReview
//
//  Created by Alexa Nohemi Lara Carvajal on 28/09/25.
//

import SwiftUI
import SwiftData

@main
struct MediaReviewApp: App {
    var body: some Scene {
        WindowGroup {
            
            ContentView()
        }
        .modelContainer(for: [Song.self])
    }
}
