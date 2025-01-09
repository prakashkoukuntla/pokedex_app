//
//  PokemonViewModelTests.swift
//  pokedex
//
//  Created by Prakash Koukuntla on 12/24/24.
//

import Foundation
import Testing
@testable import pokedex

struct PokemonViewModelTests {

    @Test("Initial Pokémon list fetch populates pokemonList")
    func testInitialPokemonListFetch() async throws {
        // Arrange
        let viewModel = await PokemonViewModel()

        // Act
        await viewModel.initializePokemonList()

        // Assert
        await #expect(viewModel.pokemonList.count > 0, "pokemonList should not be empty after initial fetch.")
    }

    @Test("Pagination appends new Pokémon to pokemonList")
    func testPaginationAppendsPokemon() async throws {
        // Arrange
        let viewModel = await PokemonViewModel()
        await viewModel.initializePokemonList()
        let initialCount = await viewModel.pokemonList.count

        // Act
        await viewModel.fetchPokemonList()

        // Assert
        await #expect(viewModel.pokemonList.count > initialCount, "pokemonList should have more Pokémon after pagination.")
    }

    @Test("Load more fetches additional Pokémon")
    func testLoadMoreFetchesAdditionalPokemon() async throws {
        // Arrange
        let viewModel = await PokemonViewModel()
        await viewModel.initializePokemonList()
        let initialCount = await viewModel.pokemonList.count
        guard let lastPokemon = await viewModel.pokemonList.last else {
            #expect(false, "pokemonList should have at least one Pokémon after initialization.")
            return
        }

        // Act
        await viewModel.loadMoreIfNeeded(currentItem: lastPokemon)

        // Assert
        await #expect(viewModel.pokemonList.count > initialCount, "pokemonList should have more Pokémon after loadMoreIfNeeded is triggered.")
    }
}
