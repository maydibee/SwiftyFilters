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
    
    private var aircrafts: [Aircraft] = []
    private let worker: AircraftListWorker
    
    @Published var filteredAircrafts: [Aircraft] = []
    @Published var isFiltersViewPresented = false
    
    let filtersCore: SFFiltersCore<Aircraft>
    
    
    init(worker: AircraftListWorker) {
        self.worker = worker
        let filter = AircraftFilter(worker: worker)
        self.filtersCore = SFFiltersCore<Aircraft>(title: "Filters", content: filter)
    }
    
    func loadAircrafts() async {
        self.aircrafts = await worker.fetchAllAircrafts()
        await MainActor.run {
            self.filteredAircrafts = self.aircrafts
        }
    }
    
    func applyFilters() {
        self.filteredAircrafts = filtersCore.getFilteredData(from: aircrafts)
    }
}
