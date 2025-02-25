//
//  AircraftNewnessFilter.swift
//  SwiftyFilters-Example-iOS
//
//  Created by Софтрэйн on 25/02/25.
//

import Foundation
import SwiftyFilters


// MARK: AircraftNewnessFilter resolver implementation

class AircraftNewnessFilterResolver: SFFilterResolver {
    
    func filterItems(_ inputItems: [Aircraft], basedOn criteriaItem: Bool, isNoneEnabled: Bool) -> [Aircraft] {
        
        return inputItems
            .filter({ inputItem in
                inputItem.isNew == criteriaItem
            })
    }
}
