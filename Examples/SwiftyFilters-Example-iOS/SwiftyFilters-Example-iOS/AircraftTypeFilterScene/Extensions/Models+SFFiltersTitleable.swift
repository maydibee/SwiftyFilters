//
//  Aircraft+SFFilter.swift
//  SwiftyFilters-Example-iOS
//
//  Created by Michael Skuratau on 25/02/25.
//

import SwiftyFilters


//MARK: - AircraftType + SFFiltersTitleable

extension AircraftType: SFFiltersTitleable {
    
    var title: String {
        self.name
    }
}

//MARK: - AircraftExploiter + SFFiltersTitleable

extension AircraftExploiter: SFFiltersTitleable {
    
    var title: String {
        self.name
    }
}
