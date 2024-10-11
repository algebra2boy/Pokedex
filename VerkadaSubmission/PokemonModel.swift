//
//  PokemonModel.swift
//  VerkadaSubmission
//
//  Created by Yongye on 10/10/24.
//

import Foundation

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

struct Sprites: Decodable, Hashable {
    let frontDefault: String?

    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}

struct Pokemon: Identifiable, Decodable, Hashable {
    let id: Int?
    let sprites: Sprites?

    init(id: Int? = nil, sprites: Sprites? = nil) {
        self.id = id
        self.sprites = sprites
    }
}
