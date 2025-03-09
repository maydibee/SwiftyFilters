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
    
    var titleDisplayMode: NavigationBarItem.TitleDisplayMode {
        get { self[SFTitleDisplayMode.self] }
        set { self[SFTitleDisplayMode.self] = newValue }
    }
}
