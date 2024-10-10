//
//  PokedexViewModel.swift
//  VerkadaSubmission
//
//  Created by Yongye on 10/10/24.
//

import Foundation

struct Pokemon {

}

struct PokedexAPIResult: Decodable {

    var name: String?

    var url: String?

    init(name: String? = nil, url: String? = nil) {
        self.name = name
        self.url = url
    }
}


struct PokedexAPIResponse: Decodable {

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

    var pokemon: [Pokemon]

    init(pokemon: [Pokemon] = []) {
        self.pokemon = pokemon
    }

    func fetchPokemon() async throws {

        guard let serverURL = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=20&offset=0") else { return }

        // fetch data asynchronously from the server url
        let (data, _) = try await URLSession.shared.data(from: serverURL)

        // parse the JSON data to swift struct
        var results = try JSONDecoder().decode(PokedexAPIResponse.self, from: data)

        print(results)

//        self.results = items

    }

}
