//
//  PokedexAppView.swift
//  VerkadaSubmission
//
//  Created by Yongye on 10/10/24.
//

import SwiftUI

struct PokedexAppView: View {

    @State private var pokedexViewModel = PokedexViewModel()

    @State private var selectedPokemon: Pokemon? = nil

    let columns = Array(repeating: GridItem(.adaptive(minimum: 100, maximum: 200)), count: 3)

    var body: some View {
        NavigationStack {
            ScrollView {

                VStack {
                    if let selectedPokemon {
                        AsyncImage(url: URL(string: selectedPokemon.sprites?.frontDefault ?? "")) { result in
                            result.image?
                                .resizable()
                                .scaledToFit()
                        }
                        .frame(width: 200, height: 200)
                    }
                }

                LazyVGrid(columns: columns) {
                    ForEach(pokedexViewModel.pokemons, id: \.self) { pokemon in
                        AsyncImage(url: URL(string: pokemon.sprites?.frontDefault ?? ""))
                            .onTapGesture {
                                selectedPokemon = pokemon
                            }
                    }
                }
            }
            .navigationTitle("Pokedex")
            .task(loadPokemons)
        }
    }

    @Sendable
    private func loadPokemons() async {
        do {
            try await pokedexViewModel.fetchPokemon()
            print("current", pokedexViewModel.pokemons)
        } catch {
            print(error)
        }
    }
}

#Preview {
    PokedexAppView()
}
