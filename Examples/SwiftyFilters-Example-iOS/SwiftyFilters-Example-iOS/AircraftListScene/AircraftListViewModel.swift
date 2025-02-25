//
//  AircraftListViewModel.swift
//  SwiftyFilters-Example-iOS
//
//  Created by Софтрэйн on 25/02/25.
//

import SwiftUI
import SwiftyFilters


// MARK: - AircraftListViewModel 

class AircraftListViewModel: ObservableObject {
    @Published var filteredAircrafts: [Aircraft] = []
    @Published var isFiltersViewPresented = false
    
    let aircrafts: [Aircraft] = Aircraft.mockAircrafts
    
    let filtersCore: SFFiltersCore<Aircraft>
    
    init() {
        let aircraftTypeFilterComponent = SFFilterComponentsFactory.createMultiSelectionComponent(
            title: "Aircraft type",
            resolver: AircraftTypeFilterResolver(),
            fetcher: AircraftTypeFilterFetcher(),
            noneItemTitle: "None"
        )
        
        self.filtersCore = SFFiltersCore<Aircraft>(title: "Filters") {
            aircraftTypeFilterComponent
        }
    }
    
    func loadAircrafts() {
        self.filteredAircrafts = aircrafts
    }
    
    func applyFilters() {
        self.filteredAircrafts = filtersCore.getFilteredData(from: aircrafts)
    }
}
