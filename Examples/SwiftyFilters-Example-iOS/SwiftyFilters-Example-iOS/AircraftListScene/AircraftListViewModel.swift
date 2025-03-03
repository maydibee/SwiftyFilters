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
        let aircraftTypeFilterComponent = SFFilterComponentsFactory.createMultiSelectionComponent(
            title: "Type",
            resolver: AircraftTypeFilterResolver(),
            fetcher: AircraftTypeFilterFetcher(),
            viewProvider: AircraftTypeFilterViewProvider(),
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
            
            // MARK: - Aircraft types filter
            
            SFMultiSelectionFilter<Aircraft, AircraftType>(title: "Type")
                .fetchItems { [weak self] in
                    guard let self else { return [] }
                    return await self.worker.fetchAllTypes()
                }
                .filter(by: \.type.id)
                .displayIn { node in
                    MultiSelectionFilterView(node: node)
                }
            
            // MARK: - Last exploiter filter
            
            SFMultiSelectionFilter<Aircraft, AircraftExploiter>(title: "Last exploiter")
                .fetchItems {
                    [weak self] in
                    guard let self else { return [] }
                    return await self.worker.fetchAllExploiters()
                }
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
    
    func loadAircrafts() {
        self.filteredAircrafts = aircrafts
    }
    
    func applyFilters() {
        self.filteredAircrafts = filtersCore.getFilteredData(from: aircrafts)
    }
}


