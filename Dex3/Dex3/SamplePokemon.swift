//
//  SamplePokemon.swift
//  Dex3
//
//  Created by José João Pimenta Oliveira on 21/12/2023.
//

import CoreData
import Foundation

struct SamplePokemon {
    static let samplePokemon = {
        let context = PersistenceController.preview.container.viewContext

        let fetchRequest: NSFetchRequest<Pokemon> = Pokemon.fetchRequest()
        fetchRequest.fetchLimit = 1

        let result = try! context.fetch(fetchRequest)
        return result.first!
    }()
}
