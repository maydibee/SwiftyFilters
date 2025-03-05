//
//  Aircraft+SFFilter.swift
//  SwiftyFilters-Example-iOS
//
//  Created by Michael Skuratau on 25/02/25.
//

import SwiftyFilters


// MARK: - SFFiltersTitleable implementation

extension AircraftType: SFFiltersTitleable {
    
    var title: String {
        self.name
    }
}

// MARK: - Equatable implementation

extension AircraftType: Equatable {
    
    static func == (lhs: AircraftType, rhs: AircraftType) -> Bool {
        lhs.id == rhs.id
    }
}

// MARK: - SFFiltersTitleable implementation

extension AircraftExploiter: SFFiltersTitleable {
    
    var title: String {
        self.name
    }
}

// MARK: - Equatable implementation

extension AircraftExploiter: Equatable {
    
    static func == (lhs: AircraftExploiter, rhs: AircraftExploiter) -> Bool {
        lhs.id == rhs.id
    }
}
