//
//  PokedexViewModel.swift
//  VerkadaSubmission
//
//  Created by Yongye on 10/10/24.
//

import Foundation

struct Sprites: Codable, Hashable {
    let frontDefault: String?

    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}

struct Pokemon: Codable, Hashable {
    let sprites: Sprites

    init(sprites: Sprites) {
        self.sprites = sprites
    }
}


struct PokedexAPIResult: Decodable, Hashable {

    var name: String?

    var url: String?

    init(name: String? = nil, url: String? = nil) {
        self.name = name
        self.url = url
    }
}


struct PokedexAPIResponse: Decodable, Hashable {

    var count: Int?

    var next: String?

    var previous: String?

    var results: [PokedexAPIResult]?

    init(count: Int? = nil, next: String? = nil, previous: String? = nil, results: [PokedexAPIResult]? = nil) {
        self.count = count
        self.next = next
        self.previous = previous
        self.results = results
    }
}

@Observable class PokedexViewModel {

    var pokemons: [Pokemon]

    init(pokemons: [Pokemon] = []) {
        self.pokemons = pokemons
    }

    func fetchPokemon() async throws {

        guard let serverURL = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=20&offset=0") else { return }

        // fetch data asynchronously from the server url
        let (data, _) = try await URLSession.shared.data(from: serverURL)

        // parse the JSON data to swift struct
        let response = try JSONDecoder().decode(PokedexAPIResponse.self, from: data)

        for result in response.results ?? [] {
            if let url = result.url {

                let (data, _) = try await URLSession.shared.data(from: URL(string: url)!)

                let pokemon = try JSONDecoder().decode(Pokemon.self, from: data)

                self.pokemons.append(pokemon)

            }
        }
    }

}
