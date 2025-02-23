//
// SwiftyFilters
//
// Copyright (c) 2025 Michael Skuratau - https://github.com/maydibee
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.


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
