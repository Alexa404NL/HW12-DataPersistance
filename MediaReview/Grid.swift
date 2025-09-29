//
//  Grid.swift
//  MediaReview
//
//  Created by Alexa Nohemi Lara Carvajal on 28/09/25.
//

import SwiftUI

struct Grid: View {
    var body: some View {
        GridRow {
               Text("Hello")
               Image(systemName: "globe")
           }
           GridRow {
               Image(systemName: "hand.wave")
               Text("World")
           }
    }
}

#Preview {
    Grid()
}
