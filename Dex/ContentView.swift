//
//  ContentView.swift
//  Dex
//
//  Created by Sarvesh Roshan on 21/10/25.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Pokemon.id, ascending: true)],
        animation: .default)
    private var pokeDex: FetchedResults<Pokemon>

    var body: some View {
        NavigationView {
            List {
                ForEach(pokeDex) { pokemon in
                    NavigationLink {
                        Text(pokemon.name ?? "no name")
                    } label: {
                        Text(pokemon.name ?? "no name")
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button("Add Item", systemImage: "plus") {
                        
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
