//
//  PokemonListView.swift
//  pokedex
//
//  Created by Prakash Koukuntla on 12/24/24.
//

import SwiftUI

struct PokemonListView: View {
    @StateObject private var viewModel = PokemonViewModel()

    private let gridLayout = [GridItem(.adaptive(minimum: 100))]

    @State private var showShinySprites: [String: Bool] = [:]

    var body: some View {
        NavigationView {
            VStack {
                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                }

                ScrollView {
                    LazyVGrid(columns: gridLayout) {
                        ForEach(viewModel.pokemonList, id: \.name) { pokemon in
                            Button(action: {
                                showShinySprites[pokemon.name, default: false].toggle()
                            }) {
                                VStack {
                                    ZStack {
                                        if showShinySprites[pokemon.name, default: false] {
                                            shinySprite(for: pokemon)
                                                .transition(.opacity) // Smooth transition
                                        } else {
                                            defaultSprite(for: pokemon)
                                                .transition(.opacity)
                                        }
                                    }
                                    .frame(width: 80, height: 80)

                                    Text(pokemon.name.capitalized)
                                        .font(.caption)
                                }
                            }.onAppear {
                                Task {
                                    await viewModel.loadMoreIfNeeded(currentItem: pokemon)
                                }
                            }
                        }
                    }
                    .padding()
                }
            }
            .onAppear {
                Task {
                    if viewModel.pokemonList.isEmpty { // Prevent reinitialization
                        await viewModel.initializePokemonList()
                    }
                }
            }
            .navigationTitle("Pokédex")
        }
    }

    private func defaultSprite(for pokemon: PokemonListItem) -> some View {
        Group {
            if let spriteURL = URL(string: pokemon.details?.sprites.other?.showdown?.front_default ?? "") {
                AsyncImage(url: spriteURL) { image in
                    image.resizable().aspectRatio(contentMode: .fit)
                } placeholder: {
                    ProgressView()
                }
            } else {
                Color.gray // Fallback placeholder
            }
        }
    }


    private func shinySprite(for pokemon: PokemonListItem) -> some View {
        Group {
            if let spriteURL = URL(string: pokemon.details?.sprites.other?.showdown?.front_shiny ?? "") {
                AsyncImage(url: spriteURL) { image in
                    image.resizable().aspectRatio(contentMode: .fit)
                } placeholder: {
                    ProgressView()
                }
            } else {
                Color.gray // Fallback placeholder
            }
        }
    }

}

#Preview {
    PokemonListView()
}
