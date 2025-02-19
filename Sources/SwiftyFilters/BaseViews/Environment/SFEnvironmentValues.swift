//
//  SFEnvironmentValues.swift
//  ObservationFilters
//
//  Created by Michael Skuratau on 18/02/25.
//

import SwiftUI


// MARK: - Environment Values

extension EnvironmentValues {
    
    var allString: String {
        get { self[SFAllStringKey.self] }
        set { self[SFAllStringKey.self] = newValue }
    }
    
    var resetString: String {
        get { self[SFResetStringKey.self] }
        set { self[SFResetStringKey.self] = newValue }
    }
    
    var enabledCheckboxImage: Image {
        get { self[SFEnabledCheckboxImageKey.self] }
        set { self[SFEnabledCheckboxImageKey.self] = newValue }
    }
    
    var disabledCheckboxImage: Image {
        get { self[SFDisabledCheckboxImageKey.self] }
        set { self[SFDisabledCheckboxImageKey.self] = newValue }
    }
    
    var enabledCheckboxColor: Color {
        get { self[SFEnabledCheckboxColorKey.self] }
        set { self[SFEnabledCheckboxColorKey.self] = newValue }
    }
    
    var disabledCheckboxColor: Color {
        get { self[SFDisabledCheckboxColorKey.self] }
        set { self[SFDisabledCheckboxColorKey.self] = newValue }
    }
    
    var enterKeywordString: String {
        get { self[SFEnterKeywordStringKey.self] }
        set { self[SFEnterKeywordStringKey.self] = newValue }
    }
    
    var caseSensitiveImage: Image {
        get { self[SFCaseSensitiveImageKey.self] }
        set { self[SFCaseSensitiveImageKey.self] = newValue }
    }
    
    var addString: String {
        get { self[SFAddStringKey.self] }
        set { self[SFAddStringKey.self] = newValue }
    }
    
    var noKeywordsString: String {
        get { self[SFNoKeywordsStringKey.self] }
        set { self[SFNoKeywordsStringKey.self] = newValue }
    }
    
    var deleteKeywordButtonImage: Image {
        get { self[SFDeleteKeywordButtonImageKey.self] }
        set { self[SFDeleteKeywordButtonImageKey.self] = newValue }
    }
    
    var startDateString: String {
        get { self[SFStartDateStringKey.self] }
        set { self[SFStartDateStringKey.self] = newValue }
    }
    
    var endDateString: String {
        get { self[SFEndDateStringKey.self] }
        set { self[SFEndDateStringKey.self] = newValue }
    }
    
    var dateString: String {
        get { self[SFDateStringKey.self] }
        set { self[SFDateStringKey.self] = newValue }
    }
    
    var noneString: String {
        get { self[SFNoneStringKey.self] }
        set { self[SFNoneStringKey.self] = newValue }
    }
}
