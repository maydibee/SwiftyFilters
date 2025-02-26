//
//  AircraftCapacityFilterResolver.swift
//  SwiftyFilters-Example-iOS
//
//  Created by Софтрэйн on 25/02/25.
//

import Foundation
import SwiftyFilters


// MARK: AircraftCapacityFilter resolver implementation

class AircraftCapacityFilterResolver: SFFilterResolver {
    
    func filterItems(_ inputItems: [Aircraft], basedOn criteriaItem: SFFilterRange<Double>, isNoneEnabled: Bool) -> [Aircraft] {
        
        return inputItems
            .filter({ inputItem in
                criteriaItem.contains(Double(inputItem.capacity))
            })
    }
}
