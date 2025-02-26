//
//  AircraftListFiltersView.swift
//  SwiftyFilters-Example-iOS
//
//  Created by Софтрэйн on 25/02/25.
//

import SwiftUI
import SwiftyFilters


// MARK: - AircraftListFiltersView

struct AircraftListFiltersView: View {
    @StateObject var filtersCore: SFFiltersCore<Aircraft>
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Button {
                    filtersCore.resetFilters()
                } label: {
                    Text("Reset")
                        .foregroundStyle(.white)
                }
                Spacer()
                Button {
                    dismiss()
                } label: {
                    Text("OK")
                        .foregroundStyle(.white)
                }
            }
            .padding()
            .background(.blue.opacity(0.8))
            
            SFFilterRootView(filtersCore: filtersCore)
        }
    }
}


struct IntegerRangeFilterView: View {
    
    
    @StateObject var node: SFFilterRangeNode<Aircraft, Double>
    
    @State private var lowerBound: Double = 0
        @State private var upperBound: Double = 100

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Фильтр по диапазону")
                .font(.headline)
            
            Slider(value: $lowerBound, in: 0...upperBound, step: 1) {
                Text("Нижняя граница")
            }
            
            Slider(value: $upperBound, in: lowerBound...400, step: 1) {
                Text("Верхняя граница")
            }
            
            Text("Диапазон: \(Int(lowerBound)) - \(Int(upperBound))")
                .font(.subheadline)
            
            Button(action: {
                //node.range = SFFilterRange(lowerBound: lowerBound, upperBound: upperBound)
                node.range = SFFilterRange(lowerBound: self.lowerBound, upperBound: self.upperBound)
            }, label: {
                Text("Применить фильтр")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            })
            .padding()
        }
    }
}


class TestViewProvider: SFFilterRangeViewProvider {
    
    func makeView(with node: SFFilterRangeNode<Aircraft, Double>) -> any View {
        IntegerRangeFilterView(node: node)
    }
}






class KeywordsFilterViewProvider: SFFilterKeywordsViewProvider {
    
    func makeView(with node: SFFilterKeywordsNode<Aircraft, String>) -> any View {
        SFFilterKeywordsView<Aircraft>(node: node)
    }
}


