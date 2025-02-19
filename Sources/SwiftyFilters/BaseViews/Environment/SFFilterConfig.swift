//
//  SFFilterConfig.swift
//  ObservationFilters
//
//  Created by Michael Skuratau on 18/02/25.
//

import SwiftUI


// MARK: - Filters config

struct SFFilterConfig {
    
    let allString: String
    let resetString: String
    let enabledCheckboxImage: Image
    let disabledCheckboxImage: Image
    let enabledCheckboxColor: Color
    let disabledCheckboxColor: Color
    let enterKeywordString: String
    let caseSensitiveImage: Image
    let addString: String
    let noKeywordsString: String
    let deleteKeywordButtonImage: Image
    let startDateString: String
    let endDateString: String
    let dateString: String
    let noneString: String
    
    
    // MARK: - Filters default config
    
    static let `default` = Self.init(allString: "All",
                                     resetString: "Reset",
                                     enabledCheckboxImage: Image(systemName: "checkmark.circle.fill"),
                                     disabledCheckboxImage: Image(systemName: "circle"),
                                     enabledCheckboxColor: .blue,
                                     disabledCheckboxColor: .gray,
                                     enterKeywordString: "Enter keyword",
                                     caseSensitiveImage: Image(systemName: "textformat"),
                                     addString: "Add",
                                     noKeywordsString: "No keywords added yet",
                                     deleteKeywordButtonImage: Image(systemName: "xmark.circle.fill"),
                                     startDateString: "Start date",
                                     endDateString: "End date",
                                     dateString: "Date",
                                     noneString: "None")
}
