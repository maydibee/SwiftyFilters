//
//  AircraftRemarksFilter.swift
//  SwiftyFilters-Example-iOS
//
//  Created by Софтрэйн on 25/02/25.
//

import SwiftyFilters


// MARK: AircraftRemarksFilter resolver implementation

class AircraftRemarksFilterResolver: SFFilterResolver {
    
    func filterItems(_ inputItems: [Aircraft], basedOn criteriaItem: SFFilterKeywordsModel<String>, isNoneEnabled: Bool) -> [Aircraft] {
        inputItems.filter({ inputItem in
            if !inputItem.remarks.isEmpty {
                return criteriaItem.isSafisfy(inputItem.remarks)
            } else {
                return isNoneEnabled
            }
        })
    }
}

