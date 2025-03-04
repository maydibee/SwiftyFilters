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
            .filter1(by: \.type)
            .displayIn { node in
                MultiSelectionFilterView(node: node)
            }
        
        // MARK: - Last exploiter filter with default view
        
        SFMultiSelectionFilter<Aircraft, AircraftExploiter>(title: "Last exploiter")
            .fetchItems { await self.worker.fetchAllExploiters() }
            .filter(byOptional: \.lastExploater?.id)
            .includeNone(withTitle: "New aircraft")

        // MARK: - Remarks filter
        
        SFKeywordsFilter(title: "Remarks")
            .filter(by: \.remarks)
            .includeNone(withTitle: "No remarks")
        
        // MARK: - Dates section
        
        SFGroupedComponent(title: "Dates") {
            
            // MARK: First flight date filter
            
            SFRangeFilter(title: "First flight date")
                .filter(by: \.firstFlightDate)
                .displayIn { node in
                    SFFilterDateRangeView(node: node)
                }
            
            // MARK: - Aircraft age section
            
            SFGroupedComponent(title: "Age") {
                
                // MARK: Manufacture date filter
                
                SFRangeFilter(title: "Manufacture date")
                    .filter(by: \.manufactureDate)
                    .displayIn { node in
                        SFFilterDateRangeView(node: node)
                    }
                
                // MARK: Newness filter
                
                SFSingleValueFilter<Aircraft, Bool>(title: "Is new")
                    .filter(by: \.isNew)
                    .displayIn { node in
                        BooleanOptionFilterView(node: node)
                    }
            }
            
        }
    }
}


struct AircraftDatesFilter: SFFilter {
    
    var body: [SFFilterComponent<Aircraft>] {
        
        // MARK: - Dates section
        
        SFGroupedComponent(title: "Dates") {
            
            // MARK: First flight date filter
            
            SFRangeFilter(title: "First flight date")
                .filter(by: \.firstFlightDate)
                .displayIn { node in
                    SFFilterDateRangeView(node: node)
                }
            
            // MARK: - Aircraft age section
            
            SFGroupedComponent(title: "Age") {
                
                // MARK: Manufacture date filter
                
                SFRangeFilter(title: "Manufacture date")
                    .filter(by: \.manufactureDate)
                    .displayIn { node in
                        SFFilterDateRangeView(node: node)
                    }
                
                // MARK: Newness filter
                
                SFSingleValueFilter<Aircraft, Bool>(title: "Is new")
                    .filter(by: \.isNew)
                    .displayIn { node in
                        BooleanOptionFilterView(node: node)
                    }
            }
            
        }
    }
}
