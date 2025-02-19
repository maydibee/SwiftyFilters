//
//  SFEnvironmentKeys.swift
//  ObservationFilters
//
//  Created by Michael Skuratau on 18/02/25.
//

import SwiftUI


// MARK: - Environment Keys

struct SFAllStringKey: EnvironmentKey {
    static let defaultValue: String = SFFilterConfig.default.allString
}

struct SFResetStringKey: EnvironmentKey {
    static let defaultValue: String = SFFilterConfig.default.resetString
}

struct SFEnabledCheckboxImageKey: EnvironmentKey {
    static let defaultValue: Image = SFFilterConfig.default.enabledCheckboxImage
}

struct SFDisabledCheckboxImageKey: EnvironmentKey {
    static let defaultValue: Image = SFFilterConfig.default.disabledCheckboxImage
}

struct SFEnabledCheckboxColorKey: EnvironmentKey {
    static let defaultValue: Color = SFFilterConfig.default.enabledCheckboxColor
}

struct SFDisabledCheckboxColorKey: EnvironmentKey {
    static let defaultValue: Color = SFFilterConfig.default.disabledCheckboxColor
}

struct SFEnterKeywordStringKey: EnvironmentKey {
    static let defaultValue: String = SFFilterConfig.default.enterKeywordString
}

struct SFCaseSensitiveImageKey: EnvironmentKey {
    static let defaultValue: Image = SFFilterConfig.default.caseSensitiveImage
}

struct SFAddStringKey: EnvironmentKey {
    static let defaultValue: String = SFFilterConfig.default.addString
}

struct SFNoKeywordsStringKey: EnvironmentKey {
    static let defaultValue: String = SFFilterConfig.default.noKeywordsString
}

struct SFDeleteKeywordButtonImageKey: EnvironmentKey {
    static let defaultValue: Image = SFFilterConfig.default.deleteKeywordButtonImage
}

struct SFStartDateStringKey: EnvironmentKey {
    static let defaultValue: String = SFFilterConfig.default.startDateString
}

struct SFEndDateStringKey: EnvironmentKey {
    static let defaultValue: String = SFFilterConfig.default.endDateString
}

struct SFDateStringKey: EnvironmentKey {
    static let defaultValue: String = SFFilterConfig.default.dateString
}

struct SFNoneStringKey: EnvironmentKey {
    static let defaultValue: String = SFFilterConfig.default.noneString
}
