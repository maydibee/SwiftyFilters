//
//  AircraftListWorker.swift
//  SwiftyFilters-Example-iOS
//
//  Created by Michael Skuratau on 04/03/25.
//

import Foundation


// MARK: - AircraftListWorker

protocol AircraftListWorker {
    
    func fetchAllAircrafts() async -> [Aircraft]
    func fetchAllTypes() async -> [AircraftType]
    func fetchAllExploiters() async -> [AircraftExploiter]
}


// MARK: - AircraftListWorker stub

class AircraftListWorkerStub: AircraftListWorker {
    
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
