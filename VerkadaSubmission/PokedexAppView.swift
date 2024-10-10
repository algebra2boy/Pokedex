//
//  PokedexAppView.swift
//  VerkadaSubmission
//
//  Created by Yongye on 10/10/24.
//

import SwiftUI

struct PokedexAppView: View {

    @State private var pokedexViewModel = PokedexViewModel()

    var body: some View {
        Text("Hello, World!")
            .task {
                do {
                    try await pokedexViewModel.fetchPokemon()
                } catch {
                    print(error)
                }
            }
    }
}

#Preview {
    PokedexAppView()
}
