//
//  AircraftListViewModel.swift
//  SwiftyFilters-Example-iOS
//
//  Created by Michael Skuratau on 25/02/25.
//

import SwiftUI
import SwiftyFilters


// MARK: - AircraftListViewModel 

class AircraftListViewModel: ObservableObject {
    
    private var aircraft: [Aircraft] = []
    private let worker: AircraftListWorker
    
    @Published var filteredAircraft: [Aircraft] = []
    @Published var isFiltersViewPresented = false
    
    let filtersCore: SFFiltersCore<Aircraft>
    
    
    init(worker: AircraftListWorker) {
        self.worker = worker
        let filter = AircraftFilter(worker: worker)
        self.filtersCore = SFFiltersCore<Aircraft>(title: "Filters", content: filter)
    }
    
    func loadAircraft() async {
        self.aircraft = await worker.fetchAllAircraft()
        await MainActor.run {
            self.filteredAircraft = self.aircraft
        }
    }
    
    func applyFilters() {
        self.filteredAircraft = filtersCore.getFilteredData(from: aircraft)
    }
}
