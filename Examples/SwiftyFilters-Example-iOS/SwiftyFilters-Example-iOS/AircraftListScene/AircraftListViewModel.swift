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
            title: "Type",
            resolver: AircraftTypeFilterResolver(),
            fetcher: AircraftTypeFilterFetcher(),
            noneItemTitle: "None"
        )
//        
//        let aircraftExploiterFilterComponent = SFFilterComponentsFactory.createMultiSelectionComponent(
//            title: "Last exploiter",
//            resolver: AircraftExploiterFilterResolver(),
//            fetcher: AircraftExploiterFilterFetcher(),
//            isNoneIncluded: true,
//            noneItemTitle: "None"
//        )
        
        let aircraftRemarksFilterComponent = SFFilterComponentsFactory.createKeywordsComponent(
            title: "Remarks",
            resolver: AircraftRemarksFilterResolver(),
            viewProvider: KeywordsFilterViewProvider(),
            isNoneIncluded: true,
            noneItemTitle: "None"
        )
        
        let aircraftFirstFlightDateFilterComponent = SFFilterComponentsFactory.createRangeComponent(
            title: "First flight date",
            resolver: AircraftFirstFlightDateFilterResolver(),
            viewProvider: DatesRangeFilterViewProvider(),
            isNoneIncluded: true,
            noneItemTitle: "None"
        )
        
        let aircraftManufactureDateFilterComponent = SFFilterComponentsFactory.createRangeComponent(
            title: "Manufacture date",
            resolver: AircraftManufactureDateFilterResolver(),
            viewProvider: DatesRangeFilterViewProvider(),
            noneItemTitle: "None"
        )
//        
//        // Unsupported
//        
//        let aircraftCapacityFilterComponent = SFFilterComponentsFactory.createRangeComponent(
//            title: "Capacity",
//            resolver: AircraftCapacityFilterResolver(),
//            noneItemTitle: "None"
//        )
//        
//        let aircraftTestCapacityFilterComponent = SFFilterComponentsFactory.createRangeComponent1(title: "Test provider",
//                                                                                                  resolver: AircraftCapacityFilterResolver(), viewProvider: TestViewProvider(), noneItemTitle: "None")
//        
//        let aircraftNewnessFilterComponent = SFFilterComponentsFactory.createSingleValueComponent(
//            title: "Newness",
//            resolver: AircraftNewnessFilterResolver(),
//            noneItemTitle: "None"
//        )
        
        
        
        self.filtersCore = SFFiltersCore<Aircraft>(title: "Filters") {
            aircraftTypeFilterComponent
//            aircraftExploiterFilterComponent
            aircraftRemarksFilterComponent
            
            SFGroupedComponent(title: "Dates") {
                aircraftFirstFlightDateFilterComponent
                aircraftManufactureDateFilterComponent
            }
            
//            aircraftCapacityFilterComponent
//            aircraftNewnessFilterComponent
//            
//            aircraftTestCapacityFilterComponent
        }
    }
    
    func loadAircrafts() {
        self.filteredAircrafts = aircrafts
    }
    
    func applyFilters() {
        self.filteredAircrafts = filtersCore.getFilteredData(from: aircrafts)
    }
}
