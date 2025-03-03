//
//  AircraftListViewModel.swift
//  SwiftyFilters-Example-iOS
//
//  Created by Софтрэйн on 25/02/25.
//

import SwiftUI
import SwiftyFilters


class AircraftListWorker {
    
    func fetchAllAircrafts() async -> [Aircraft] {
        try? await Task.sleep(nanoseconds: 200_000_000)
        
        // returns mock data with delay
        return Aircraft.mockAircrafts
    }
    
    func fetchAllTypes() async -> [AircraftType] {
        try? await Task.sleep(nanoseconds: 200_000_000)
        
        // returns mock data with delay
        return [
            AircraftType.mockAirbus1,
            AircraftType.mockAirbus2,
            AircraftType.mockAirbus3,
            AircraftType.mockBoeing1,
            AircraftType.mockBoeing2,
            AircraftType.mockBoeing3,
        ]
    }
    
    func fetchAllExploiters() async -> [AircraftExploiter] {
        try? await Task.sleep(nanoseconds: 200_000_000)
        
        // returns mock data with delay
        return [
            AircraftExploiter.mockExploiter1,
            AircraftExploiter.mockExploiter2,
            AircraftExploiter.mockExploiter3
        ]
    }
}


// MARK: - AircraftListViewModel 

class AircraftListViewModel: ObservableObject {
    @Published var filteredAircrafts: [Aircraft] = []
    @Published var isFiltersViewPresented = false
    
    let worker = AircraftListWorker()
    
    let aircrafts: [Aircraft] = Aircraft.mockAircrafts
    
    var filtersCore: SFFiltersCore<Aircraft>!
    
    init() {
        self.filtersCore = SFFiltersCore<Aircraft>(title: "Filters", content: AircraftFilter())
    }
    
    func loadAircrafts() {
        self.filteredAircrafts = aircrafts
    }
    
    func applyFilters() {
        self.filteredAircrafts = filtersCore.getFilteredData(from: aircrafts)
    }
}


import SwiftyFilters


struct AircraftFilter: SFFilter {
    
    let worker = AircraftListWorker()
    
    var body: [SFFilterComponent<Aircraft>] {
        
        AircraftDatesFilter()
        
        // MARK: - Aircraft types filter
        
        SFMultiSelectionFilter<Aircraft, AircraftType>(title: "Type")
            .fetchItems { await worker.fetchAllTypes() }
            .filter(by: \.type.id)
            .displayIn { node in
                MultiSelectionFilterView(node: node)
            }
        
        // MARK: - Last exploiter filter
        
        SFMultiSelectionFilter<Aircraft, AircraftExploiter>(title: "Last exploiter")
            .fetchItems { await self.worker.fetchAllExploiters() }
            .filter(byOptional: \.lastExploater?.id)
            .includeNone(withTitle: "New aircraft")
            .displayIn { node in
                MultiSelectionFilterView(node: node)
            }
        
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
                
                SFSingleValueFilter<Aircraft, Bool>(title: "Newness")
                    .filter(by: \.isNew)
                    .displayIn { node in
                        SFSingleValueRadioButtonsView(node: node)
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
                
                SFSingleValueFilter<Aircraft, Bool>(title: "Newness")
                    .filter(by: \.isNew)
                    .displayIn { node in
                        SFSingleValueRadioButtonsView(node: node)
                    }
            }
            
        }
    }
}
