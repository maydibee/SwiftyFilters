//
//  AircraftDatesFilter.swift
//  SwiftyFilters-Example-iOS
//
//  Created by Michael Skuratau on 04/03/25.
//

import SwiftyFilters


// - MARK: AircraftDatesFilter sub-filter

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

