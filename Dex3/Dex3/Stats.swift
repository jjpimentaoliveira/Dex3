//
//  Stats.swift
//  Dex3
//
//  Created by José João Pimenta Oliveira on 22/12/2023.
//

import Charts
import SwiftUI

struct Stats: View {
    @EnvironmentObject var pokemon: Pokemon

    var body: some View {
        Chart(pokemon.stats) { stat in
            BarMark(
                x: .value("Value", stat.value),
                y: .value("Stat", stat.label)
            )
            .annotation(position: .trailing) {
                Text("\(stat.value)")
                    .padding(.top, -5)
                    .foregroundStyle(.secondary)
                    .font(.subheadline)
            }
        }
        .frame(height: 200)
        .padding([.leading, .bottom, .trailing])
        .foregroundStyle(Color(pokemon.types![0].capitalized))
        .chartXScale(domain: 0...pokemon.highestStat.value + 5)
        .chartYAxis {
            AxisMarks(stroke: StrokeStyle(lineWidth: 0))
        }
        .chartXAxis(.hidden)
        .chartXAxis {
            AxisMarks(stroke: StrokeStyle(lineWidth: 0))
        }
    }
}

#Preview {
    Stats()
        .environmentObject(SamplePokemon.samplePokemon)
}
