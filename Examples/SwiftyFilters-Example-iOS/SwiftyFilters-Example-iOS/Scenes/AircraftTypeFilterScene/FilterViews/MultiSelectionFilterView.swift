//
//  MultiSelectionFilterView.swift
//  SwiftyFilters-Example-iOS
//
//  Created by Michael Skuratau on 04/03/25.
//

import SwiftyFilters
import SwiftUI


// MARK: - Multi-selection filter custom view

struct MultiSelectionFilterView: View {
    
    @StateObject var node: SFFilterMultiSelectionNode<Aircraft>
    
    var body: some View {
        Group {
            if node.isLoading {
                ProgressView()
            } else {
                List {
                    Group {
                        MultiSelectionFilterActionsCell(node: node)
                        ForEach(node.nestedNodes) { child in
                            MultiSelectionFilterCell(node: child)
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


// MARK: - Cell view

struct MultiSelectionFilterCell: View {
    
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


// MARK: - All/reset actions cell view

struct MultiSelectionFilterActionsCell: View {
    
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
