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
