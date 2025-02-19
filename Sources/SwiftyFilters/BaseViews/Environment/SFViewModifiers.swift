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


// MARK: - View Modifiers

public extension View {
    
    func allString(_ value: String) -> some View {
        environment(\.allString, value)
    }
    
    func resetString(_ value: String) -> some View {
        environment(\.resetString, value)
    }
    
    func enabledCheckboxImage(_ value: Image) -> some View {
        environment(\.enabledCheckboxImage, value)
    }
    
    func disabledCheckboxImage(_ value: Image) -> some View {
        environment(\.disabledCheckboxImage, value)
    }
    
    func enabledCheckboxColor(_ value: Color) -> some View {
        environment(\.enabledCheckboxColor, value)
    }
    
    func disabledCheckboxColor(_ value: Color) -> some View {
        environment(\.disabledCheckboxColor, value)
    }
    
    func enterKeywordString(_ value: String) -> some View {
        environment(\.enterKeywordString, value)
    }
    
    func caseSensitiveImage(_ value: Image) -> some View {
        environment(\.caseSensitiveImage, value)
    }
    
    func addString(_ value: String) -> some View {
        environment(\.addString, value)
    }
    
    func noKeywordsString(_ value: String) -> some View {
        environment(\.noKeywordsString, value)
    }
    
    func deleteKeywordButtonImage(_ value: Image) -> some View {
        environment(\.deleteKeywordButtonImage, value)
    }
    
    func startDateString(_ value: String) -> some View {
        environment(\.startDateString, value)
    }
    
    func dateString(_ value: String) -> some View {
        environment(\.dateString, value)
    }
    
    func endDateString(_ value: String) -> some View {
        environment(\.endDateString, value)
    }
    
    func noneString(_ value: String) -> some View {
        environment(\.noneString, value)
    }
}
