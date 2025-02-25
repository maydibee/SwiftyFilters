//
//  AircraftTypeFilterResolver.swift
//  SwiftyFilters-Example-iOS
//
//  Created by Софтрэйн on 25/02/25.
//

import SwiftyFilters


// MARK: AircraftTypeFilter resolver implementation

class AircraftTypeFilterResolver: SFFilterResolver {
    
    func filterItems(_ inputItems: [Aircraft], basedOn criteriaItem: [AircraftType], isNoneEnabled: Bool) -> [Aircraft] {
        inputItems.filter { inputItem in
            criteriaItem.contains { $0.id == inputItem.type.id }
        }
    }
}
