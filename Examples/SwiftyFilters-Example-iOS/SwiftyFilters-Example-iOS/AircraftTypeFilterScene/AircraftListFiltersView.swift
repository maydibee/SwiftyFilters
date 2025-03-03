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
        SFFilterKeywordsDefaultView<Aircraft>(node: node)
    }
}

class DatesRangeFilterViewProvider: SFFilterRangeViewProvider {
    
    func makeView(with node: SFFilterRangeNode<Aircraft, Date>) -> any View {
        SFFilterDateRangeView<Aircraft>(node: node)
    }
}

struct MultiSelectionFilterView: View {
    
    @StateObject var node: SFFilterMultiSelectionNode<Aircraft>
    
    var body: some View {
        Group {
            if node.isLoading {
                ProgressView()
            } else {
                List {
                    Group {
                        AircraftFilterAllResetActionCell(node: node)
                        ForEach(node.nestedNodes) { child in
                            MultiSelectionFilterCellView(node: child)
                                .onTapGesture {
                                    child.isItemEnabled.toggle()
                                }
                        }
                    }
                    .listRowInsets(EdgeInsets())
                    .listRowSeparator(.hidden)
                }
                .listStyle(PlainListStyle())
            }
        }
        .animation(.easeIn(duration: 0.1), value: node.isItemEnabled)
    }
}

struct MultiSelectionFilterCellView: View {
    
    @StateObject var node: SFFilterNode<Aircraft>
    
    var body: some View {
        HStack {
            Text(node.title)
                .fontWeight(.semibold)
                .foregroundStyle(node.isItemEnabled ? .blue : .gray)
                .padding()
            Spacer()
        }
        .capsuled(borderColor: node.isItemEnabled ? .blue : .gray.opacity(0.7))
        .contentShape(Rectangle())
        .frame(height: 50)
        .padding(.horizontal)
        .padding(.vertical, 5)
    }
}

struct AircraftFilterAllResetActionCell: View {
    
    @StateObject var node: SFFilterMultiSelectionNode<Aircraft>
    
    var body: some View {
        HStack {
            Text(node.isItemEnabled ? "All" : "Reset")
                .fontWeight(.semibold)
                .foregroundStyle(node.isItemEnabled ? .blue : .red)
                .padding()
            Spacer()
        }
        .capsuled(borderColor: node.isItemEnabled ? .blue : .red.opacity(0.7))
        .contentShape(Rectangle())
        .frame(height: 30)
        .padding()
        .onTapGesture {
            if node.isItemEnabled {
                node.deselectAll()
            } else {
                node.resetAllFilters()
            }
        }
    }
}


extension View {
    
    func capsuled(borderColor: Color) -> some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(.clear)
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(borderColor, lineWidth: 1)
            }
            .overlay {
                self
            }
    }
}




class AircraftTypeFilterViewProvider: SFFilterMultiSelectionViewProvider {

    func makeView(with node: SFFilterMultiSelectionNode<Aircraft>) -> any View {
        MultiSelectionFilterView(node: node)
    }
}


import SwiftUI

struct SFSingleValueRadioButtonsView<FilteredItem>: View {

    @StateObject var node: SFFilterSingleValueNode<FilteredItem, Bool>
    
    struct Option {
        let value: Bool
        let title: String
    }
    
    private let options = [Option(value: true, title: "New"), Option(value: false, title: "Used")]
    
    
    var body: some View {
        List {
            if node.value != nil {
                Button(action: resetSelection) {
                    HStack {
                        Text("Reset")
                            .foregroundColor(.red)
                        Spacer()
                    }
                }
            }

            ForEach(options, id: \.value) { option in
                HStack {
                    Text(option.title)
                        .foregroundColor(node.value == option.value ? .blue : .primary)
                    Spacer()
                    if node.value == option.value {
                        Image(systemName: "checkmark")
                            .foregroundColor(.blue)
                    }
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    node.value = option.value
                }
            }
        }
        .navigationTitle(node.title)
        .animation(.easeInOut, value: node.value)
    }
    
    private func resetSelection() {
        node.value = nil
    }
}
