//
//  Persistence.swift
//  Dex
//
//  Created by Sarvesh Roshan on 21/10/25.
//

import CoreData

struct PersistenceController {
    // The thing that controls our database
    static let shared = PersistenceController()

    // The thing that controls our sample preview database
    @MainActor
    static let preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        let newPokemon = Pokemon(context: viewContext)
        newPokemon.id = 1
        newPokemon.name = "bulbasaur"
        newPokemon.types = ["grass", "poison"]
        newPokemon.hp = 45
        newPokemon.defense = 49
        newPokemon.attack = 49
        newPokemon.speed = 45
        newPokemon.specialAttack = 65
        newPokemon.specialDefense = 65
        newPokemon.spriteURL = URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png")
        newPokemon.shinyURL = URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/1.png")
        do {
            try viewContext.save()
        } catch {
            print(error)
        }
        return result
    }()

    // The thing that holds the stuff (database)
    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Dex")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                print(error)
            }
        })
        container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyStoreTrump
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
