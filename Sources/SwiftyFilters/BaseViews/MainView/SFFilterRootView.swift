//
//  SFFilterRootView.swift
//  ObservationFilters
//
//  Created by Michael Skuratau on 17/02/25.
//

import SwiftUI


// MARK: - Filters root view

public struct SFFilterRootView<FilteredItem>: View {
    
    @StateObject public var filtersCore: SFFiltersCore<FilteredItem>

    
    public init(filtersCore: SFFiltersCore<FilteredItem>) {
        _filtersCore = StateObject(wrappedValue: filtersCore)
    }
    
    public var body: some View {
        NavigationView {
            if let rootNode = filtersCore.rootNode {
                SFFilterComponentView(node: rootNode)
            } else {
                ProgressView()
            }
        }
        .onAppear {
            if filtersCore.rootNode == nil {
                filtersCore.compose()
            }
        }
        .onDisappear { filtersCore.onFiltesUpdated?() }
    }
}
