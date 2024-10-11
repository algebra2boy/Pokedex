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
    
    @State private var isPaginating: Bool = true
    
    let columns = Array(repeating: GridItem(.adaptive(minimum: 100, maximum: 200)), count: 3)
    
    var body: some View {
        NavigationStack {
            
            ScrollView {
                
                VStack {
                    
                    if let selectedPokemon {
                        ImageView(url: selectedPokemon.sprites?.frontDefault)
                    }
                }
                
                LazyVGrid(columns: columns, spacing: 50) {
                    ForEach(pokedexViewModel.pokemons) { pokemon in
                        LazyVStack { // enable lazy loading to display pokemon only when it is needed
                            ImageView(url: pokemon.sprites?.frontDefault)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(pokemon == selectedPokemon ? Color.blue : Color.clear, lineWidth: 2)
                                )
                                .onTapGesture { selectedPokemon = pokemon }
                                .onAppear { performPagination(currentPokemon: pokemon) }
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
        } catch {
            print(error)
        }
    }
    
    private func performPagination(currentPokemon: Pokemon) {
        if currentPokemon == pokedexViewModel.pokemons.last && isPaginating {
            isPaginating = false
            Task {
                try await Task.sleep(nanoseconds: 200_000_000)
                await loadPokemons()
                isPaginating = true
            }
        }
    }
}

struct ImageView: View {
    
    let url: String?
    
    let size: CGFloat = 100
    
    var body: some View {
        AsyncImage(url: URL(string: url ?? "")) { phase in
            switch phase {
            case .empty:
                ProgressView()
                    .frame(width: size, height: size)
            case .success(let image):
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: size, height: size)
            case .failure:
                // Reference: https://forums.developer.apple.com/forums/thread/682498
                // Sometimes async image would fail to load for the first time, therefore we need to refetch
                ImageView(url: url)
            @unknown default:
                EmptyView()
            }
        }
    }
}

#Preview {
    PokedexAppView()
}
