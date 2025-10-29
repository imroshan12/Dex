//
//  FetchService.swift
//  Dex
//
//  Created by Sarvesh Roshan on 29/10/25.
//

import Foundation

enum FetchError: Error {
    case badResponse
}

struct FetchService {
    private let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon")!
    
    func fetchPokemon(_ id: Int) async throws -> FetchedPokemon {
        let fetchURL = baseURL.appending(path: String(id))
        let (data, response) = try await URLSession.shared.data(from: fetchURL)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw FetchError.badResponse
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let pokemon = try decoder.decode(FetchedPokemon.self, from: data)
        
        print("Fetched pokemon \(pokemon.id): \(pokemon.name)")
        
        return pokemon
    }
}
