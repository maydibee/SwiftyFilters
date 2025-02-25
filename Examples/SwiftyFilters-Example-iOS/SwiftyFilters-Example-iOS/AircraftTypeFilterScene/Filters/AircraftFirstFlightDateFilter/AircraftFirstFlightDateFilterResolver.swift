//
//  AircraftFirstFlightDateFilter.swift
//  SwiftyFilters-Example-iOS
//
//  Created by Софтрэйн on 25/02/25.
//

import Foundation
import SwiftyFilters


// MARK: AircraftFirstFlightDateFilter resolver implementation

class AircraftFirstFlightDateFilterResolver: SFFilterResolver {
    
    func filterItems(_ inputItems: [Aircraft], basedOn criteriaItem: SFFilterRange<Date>, isNoneEnabled: Bool) -> [Aircraft] {
        
        return inputItems
            .filter({ inputItem in
                criteriaItem.contains(inputItem.firstFlightDate)
            })
    }
}

