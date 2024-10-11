//
//  PokedexViewModel.swift
//  VerkadaSubmission
//
//  Created by Yongye on 10/10/24.
//

import Foundation

@Observable class PokedexViewModel {

    var pokemons: [Pokemon]

    var offset: Int = 0

    var isLoading: Bool = false

    let limit: Int = 20

    init(pokemons: [Pokemon] = []) {
        self.pokemons = pokemons
    }

    func fetchPokemon() async throws {

        guard !isLoading else { return }

        isLoading = true

        guard let serverURL = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=\(limit)&offset=\(offset)") else { return }

        // fetch data asynchronously from the server url
        let (data, _) = try await URLSession.shared.data(from: serverURL)

        // parse the JSON data to swift struct
        let response = try JSONDecoder().decode(PokedexAPIResponse.self, from: data)

        // iterate over each result and fetch each pokemon data and deserialize it
        for result in response.results ?? [] {

            // validate the url
            guard let urlString = result.url, let url = URL(string: urlString) else { continue }

            let (data, _) = try await URLSession.shared.data(from: url)

            let pokemon = try JSONDecoder().decode(Pokemon.self, from: data)

            self.pokemons.append(pokemon)

        }

        self.offset += limit
        isLoading = false
    }

}
