//
//  AircraftFilter.swift
//  SwiftyFilters-Example-iOS
//
//  Created by Michael Skuratau on 04/03/25.
//


import SwiftyFilters


// - MARK: AircraftFilter

struct AircraftFilter: SFFilter {
    
    let worker: AircraftListWorker
    
    var body: [SFFilterComponent<Aircraft>] {
        
        // MARK: - Aircraft types filter
        
        SFMultiSelectionFilter<Aircraft, AircraftType>(title: "Type")
            .fetchItems { await worker.fetchAllTypes() }
            .filter(by: \.type)
            .displayIn { node in
                MultiSelectionFilterView(node: node)
            }
        
        // MARK: - Last exploiter filter with default view
        
        SFMultiSelectionFilter<Aircraft, AircraftExploiter>(title: "Last exploiter")
            .fetchItems { await self.worker.fetchAllExploiters() }
            .filter(byOptional: \.lastExploater)
            .includeNone(withTitle: "New aircraft")

        // MARK: - Remarks filter
        
        SFKeywordsFilter(title: "Remarks")
            .filter(by: \.remarks)
            .includeNone(withTitle: "No remarks")
        
        // MARK: - Dates section
        
        AircraftDatesFilter()
    }
}
