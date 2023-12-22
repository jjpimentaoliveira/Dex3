//
//  ContentView.swift
//  Dex3
//
//  Created by José João Pimenta Oliveira on 21/12/2023.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Pokemon.id, ascending: true)],
        animation: .default)
    private var pokedex: FetchedResults<Pokemon>

    @StateObject private var pokemonViewModel = PokemonViewModel(controller: FetchController())

    var body: some View {
        switch pokemonViewModel.status {
        case .notStarted:
            ProgressView()

        case .fetching:
            ProgressView()

        case .success:
            NavigationStack {
                List(pokedex) { pokemon in
                    NavigationLink(value: pokemon) {
                        AsyncImage(url: pokemon.sprite) { image in
                            image
                                .resizable()
                                .scaledToFit()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 100, height: 100)

                        Text("#\(pokemon.id) ")
                            .fontWeight(.medium)
                        Text(pokemon.name!.capitalized)
                    }
                }
                .navigationTitle("Pokédex")
                .navigationDestination(for: Pokemon.self, destination: { pokemon in
                    PokemonDetail()
                        .environmentObject(pokemon)
                })
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        EditButton()
                    }
                }
            }

        case .failed:
            ProgressView()
        }
    }
}

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
