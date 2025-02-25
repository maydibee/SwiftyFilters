//
//  AircraftTypeFilterFetcher.swift
//  SwiftyFilters-Example-iOS
//
//  Created by Софтрэйн on 24/02/25.
//

import SwiftyFilters


// MARK: AircraftTypeFilter fetcher implementation

class AircraftTypeFilterFetcher: SFFilterFetcher {
    
    func fetchFilterItems() async -> [AircraftType] {
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
}
