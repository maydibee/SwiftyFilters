//
//  Aircraft+SFFilter.swift
//  SwiftyFilters-Example-iOS
//
//  Created by Софтрэйн on 25/02/25.
//

import SwiftyFilters


extension AircraftType: Identifiable, SFFiltersTitleable {
    
    var title: String {
        self.name
    }
}
