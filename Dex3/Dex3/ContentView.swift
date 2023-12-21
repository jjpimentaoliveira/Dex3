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

    var body: some View {
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

                    Text(pokemon.name!.capitalized)
                }
            }
            .navigationTitle("Pokédex")
            .navigationDestination(for: Pokemon.self, destination: { pokemon in
                // TODO: Pokemon Details View
                AsyncImage(url: pokemon.sprite) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 100, height: 100)
            })
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
            }
        }
    }
}

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
