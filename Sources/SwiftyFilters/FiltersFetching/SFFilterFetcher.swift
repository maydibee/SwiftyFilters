//
//  SFFilterFetcher.swift
//  ObservationFilters
//
//  Created by Michael Skuratau on 07/02/25.
//

import Foundation


// MARK: - Filter's fetcher abstraction (API-RO)
// BASE

public protocol SFFilterFetcher<CriteriaItem> {
    
    associatedtype CriteriaItem
    
    func fetchFilterItems() async -> [CriteriaItem]
}
