//
//  AircraftManufactureDateFilterResolver.swift
//  SwiftyFilters-Example-iOS
//
//  Created by Софтрэйн on 25/02/25.
//

import Foundation
import SwiftyFilters


// MARK: AircraftManufactureDateFilter resolver implementation

class AircraftManufactureDateFilterResolver: SFFilterResolver {
    
    func filterItems(_ inputItems: [Aircraft], basedOn criteriaItem: SFFilterRange<Date>, isNoneEnabled: Bool) -> [Aircraft] {
        
        return inputItems
            .filter({ inputItem in
                criteriaItem.contains(inputItem.manufactureDate)
            })
    }
}
