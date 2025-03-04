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

extension AircraftType: Equatable {
    
    static func == (lhs: AircraftType, rhs: AircraftType) -> Bool {
        lhs.id == rhs.id
    }
}

//MARK: - AircraftExploiter + SFFiltersTitleable

extension AircraftExploiter: SFFiltersTitleable {
    
    var title: String {
        self.name
    }
}

extension AircraftExploiter: Equatable {
    
    static func == (lhs: AircraftExploiter, rhs: AircraftExploiter) -> Bool {
        lhs.id == rhs.id
    }
}
