//
//  SFFilterFilterable.swift
//  ObservationFilters
//
//  Created by Michael Skuratau on 10/02/25.
//

import Foundation


// MARK: - Filterable component abstraction (API-RO)

public protocol SFFilterFilterable<FilteredItem> {
    
    associatedtype FilteredItem
    
    func getFilteredItems(for items: [FilteredItem]) -> [FilteredItem]
}
