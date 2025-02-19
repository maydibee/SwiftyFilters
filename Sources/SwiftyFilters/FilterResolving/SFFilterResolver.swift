//
//  SFFilterResolver.swift
//  ObservationFilters
//
//  Created by Michael Skuratau on 07/02/25.
//

import Foundation


// MARK: - Filter's resolver abstraction (API-RO)
//BASE

public protocol SFFilterResolver<FilteredItem, CriteriaItem> {

    associatedtype FilteredItem
    associatedtype CriteriaItem

    func filterItems(_ inputItems: [FilteredItem], basedOn criteriaItem: CriteriaItem, isNoneEnabled: Bool ) -> [FilteredItem]
}
