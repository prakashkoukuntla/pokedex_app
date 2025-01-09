//
//  NetworkManager.swift
//  pokedex
//
//  Created by Prakash Koukuntla on 12/24/24.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    private init() {}

    private let baseURL = "https://pokeapi.co/api/v2/pokemon"

    // Fetch a list of Pokémon
    func fetchPokemonList(offset: Int, limit: Int) async throws -> PokemonListResponse {
        let urlString = "\(baseURL)?offset=\(offset)&limit=\(limit)"
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }

        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }

        let decoder = JSONDecoder()
        return try decoder.decode(PokemonListResponse.self, from: data)
    }

    // Fetch Pokémon details
    func fetchPokemonDetail(urlString: String) async throws -> PokemonDetail {
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }

        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }

        let decoder = JSONDecoder()
        return try decoder.decode(PokemonDetail.self, from: data)
    }
}
