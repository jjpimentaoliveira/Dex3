//
//  PokemonDetail.swift
//  Dex3
//
//  Created by José João Pimenta Oliveira on 21/12/2023.
//

import CoreData
import SwiftUI

struct PokemonDetail: View {
    @EnvironmentObject var pokemon: Pokemon

    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    PokemonDetail()
        .environmentObject(SamplePokemon.samplePokemon)
}
