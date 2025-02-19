//
//  SFGroupedComponent.swift
//  ObservationFilters
//
//  Created by Michael Skuratau on 17/02/25.
//

import Foundation


// MARK: - Filter's hierarchy grouped component

public struct SFGroupedComponent<FilteredItem> {
    
    let title: String

    @SFFiltersBuilder<FilteredItem> let content: () -> [any SFFilterComponent<FilteredItem>]
    
    public init(title: String, @SFFiltersBuilder<FilteredItem> content: @escaping () -> [any SFFilterComponent<FilteredItem>]) {
        self.title = title
        self.content = content
    }
}
