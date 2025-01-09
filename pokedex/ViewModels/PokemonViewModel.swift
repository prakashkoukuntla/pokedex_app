//
//  PokemonViewModel.swift
//  pokedex
//
//  Created by Prakash Koukuntla on 12/24/24.
//

import Foundation
import SwiftUI

@MainActor
class PokemonViewModel: ObservableObject {
    @Published var pokemonList: [PokemonListItem] = []
    @Published var selectedPokemon: PokemonListItem?
    @Published var errorMessage: String?

    // Pagination state
    private let increment = 10
    private var offset = 0
    private var isFetching = false

    init() {}

    func initializePokemonList() async {
        await fetchPokemonList()
    }

    func fetchPokemonList() async {
        guard !isFetching else { return }
        isFetching = true
        defer { isFetching = false }

        do {
            let response = try await NetworkManager.shared.fetchPokemonList(offset: offset, limit: increment)
            var newItems = [PokemonListItem?](repeating: nil, count: response.results.count)
            
            // Concurrency: fetch details for each Pokémon in parallel
            await withTaskGroup(of: (index: Int, item: PokemonListItem?).self) { group in
                for (i, pokemon) in response.results.enumerated() {
                    group.addTask {
                        if let detail = try? await NetworkManager.shared.fetchPokemonDetail(urlString: pokemon.url) {
                            return (i, PokemonListItem(name: pokemon.name, url: pokemon.url, details: detail))
                        }
                        return (i, nil)
                    }
                }
                
                for await (i, maybePokemon) in group {
                    newItems[i] = maybePokemon
                }
            }

            let filtered = newItems.compactMap { $0 }
            pokemonList.append(contentsOf: filtered)
            
            offset += increment

        } catch {
            errorMessage = "Error fetching Pokémon list: \(error.localizedDescription)"
            print(errorMessage!)
        }
    }

    // Trigger pagination when nearing the bottom of the list
    func loadMoreIfNeeded(currentItem item: PokemonListItem) async {
        guard let lastItem = pokemonList.last else { return }
        if item.id == lastItem.id {
            await fetchPokemonList()
        }
    }
}
