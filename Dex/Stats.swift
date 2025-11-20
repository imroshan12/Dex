//
//  Stats.swift
//  Dex
//
//  Created by Sarvesh Roshan on 20/11/25.
//

import SwiftUI
import Charts

struct Stats: View {
    var pokemon: Pokemon
    var body: some View {
        Chart(pokemon.stats) { stat in
            BarMark(x: .value("Value", stat.value), y: .value("Stat", stat.name))
                .annotation(position: .trailing) {
                    Text("\(stat.value)")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
        }
        .frame(height: 200)
        .padding([.horizontal, .bottom])
        .foregroundStyle(pokemon.typeColor)
        .chartXScale(domain: 0...pokemon.highestStat.value+10)
    }
}

#Preview {
    Stats(pokemon: PersistenceController.previewPokemon)
}
