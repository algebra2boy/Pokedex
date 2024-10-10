//
//  PokedexAppView.swift
//  VerkadaSubmission
//
//  Created by Yongye on 10/10/24.
//

import SwiftUI

struct PokedexAppView: View {

    @State private var pokedexViewModel = PokedexViewModel()

    let columns = Array(repeating: GridItem(.adaptive(minimum: 100, maximum: 200)), count: 3)

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(pokedexViewModel.pokemons, id: \.self) { pokemon in
                        AsyncImage(url: URL(string: pokemon.sprites?.frontDefault ?? ""))
                    }
                }
            }
            .navigationTitle("Pokedex")
            .task {
                do {
                    try await pokedexViewModel.fetchPokemon()
                    print(pokedexViewModel.pokemons)
                } catch {
                    print(error)
                }
            }
        }
    }
}

#Preview {
    PokedexAppView()
}
