//
//  FetchController.swift
//  Dex3
//
//  Created by José João Pimenta Oliveira on 21/12/2023.
//

import CoreData
import Foundation

struct FetchController {
    enum NetworkError: Error {
        case badData
        case badResponse
        case badURL
    }

    private let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")!

    func fetchAllPokemon() async throws -> [TempPokemon]? {

        if hasPokemon() {
            return nil
        }

        var allPokemon: [TempPokemon] = []

        var fetchComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        fetchComponents?.queryItems = [
            URLQueryItem(name: "limit", value: "386")
        ]

        guard let fetchURL = fetchComponents?.url else {
            throw NetworkError.badURL
        }

        let (data, response) = try await URLSession.shared.data(from: fetchURL)
        guard 
            let response = response as? HTTPURLResponse,
            response.statusCode == 200
        else {
            throw NetworkError.badResponse
        }

        guard 
            let pokeDictionary = try JSONSerialization.jsonObject(with: data) as? [String: Any],
            let pokedex = pokeDictionary["results"] as? [[String: String]]
        else {
            throw NetworkError.badData
        }

        for pokemon in pokedex {
            if let url = pokemon["url"] {
                allPokemon.append(try await fetchPokemon(from: URL(string: url)!))
            }
        }

        return allPokemon
    }

    private func fetchPokemon(from url: URL) async throws -> TempPokemon {
        let (data, response) = try await URLSession.shared.data(from: url)

        guard
            let response = response as? HTTPURLResponse,
            response.statusCode == 200
        else {
            throw NetworkError.badResponse
        }

        let tempPokemon = try JSONDecoder().decode(TempPokemon.self, from: data)

        print("Fetched \(tempPokemon.id): \(tempPokemon.name)")

        return tempPokemon
    }

    private func hasPokemon() -> Bool {
        let context = PersistenceController.shared.container.newBackgroundContext()
        let fetchRequest: NSFetchRequest<Pokemon> = Pokemon.fetchRequest()
        
        fetchRequest.predicate = NSPredicate(format: "id IN %@", [1, 386])

        do {
            let checkPokemon = try context.fetch(fetchRequest)
            return checkPokemon.count == 2
        } catch {
            print("Fetch failed: \(error)")
            return false
        }
    }
}
