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
    
    /// Sets the title for the "All" action used to deselect all filter items.
    ///
    /// - Parameter value: The title string.
    /// - Returns: A view with the updated environment value.
    ///
    func allString(_ value: String) -> some View {
        environment(\.allString, value)
    }
    
    /// Sets the title for the "Reset" action used to reset a specific filter.
    ///
    /// - Parameter value: The title string.
    /// - Returns: A view with the updated environment value.
    ///
    func resetString(_ value: String) -> some View {
        environment(\.resetString, value)
    }
    
    /// Sets the image for the checkbox when the item is selected.
    ///
    /// - Parameter value: The image to display.
    /// - Returns: A view with the updated environment value.
    ///
    func enabledCheckboxImage(_ value: Image) -> some View {
        environment(\.enabledCheckboxImage, value)
    }
    
    /// Sets the image for the checkbox when the item is not selected.
    ///
    /// - Parameter value: The image to display.
    /// - Returns: A view with the updated environment value.
    ///
    func disabledCheckboxImage(_ value: Image) -> some View {
        environment(\.disabledCheckboxImage, value)
    }
    
    /// Sets the color for the checkbox when the item is selected.
    ///
    /// - Parameter value: The color to apply.
    /// - Returns: A view with the updated environment value.
    ///
    func enabledCheckboxColor(_ value: Color) -> some View {
        environment(\.enabledCheckboxColor, value)
    }
    
    /// Sets the color for the checkbox when the item is not selected.
    ///
    /// - Parameter value: The color to apply.
    /// - Returns: A view with the updated environment value.
    ///
    func disabledCheckboxColor(_ value: Color) -> some View {
        environment(\.disabledCheckboxColor, value)
    }
    
    /// Sets the hint text for the text field in the keywords filter component.
    ///
    /// - Parameter value: The hint text string.
    /// - Returns: A view with the updated environment value.
    ///
    func enterKeywordString(_ value: String) -> some View {
        environment(\.enterKeywordString, value)
    }
    
    /// Sets the image for the button to toggle case sensitivity in the keywords filter component.
    ///
    /// - Parameter value: The image to display.
    /// - Returns: A view with the updated environment value.
    ///
    func caseSensitiveImage(_ value: Image) -> some View {
        environment(\.caseSensitiveImage, value)
    }
    
    /// Sets the title for the button used to add items (e.g., keywords) in the filter component.
    ///
    /// - Parameter value: The title string.
    /// - Returns: A view with the updated environment value.
    ///
    func addString(_ value: String) -> some View {
        environment(\.addString, value)
    }
    
    /// Sets the title for the label displayed when no keywords are added in the keywords filter component.
    ///
    /// - Parameter value: The title string.
    /// - Returns: A view with the updated environment value.
    ///
    func noKeywordsString(_ value: String) -> some View {
        environment(\.noKeywordsString, value)
    }
    
    /// Sets the image for the button used to delete keywords in the keywords filter component.
    ///
    /// - Parameter value: The image to display.
    /// - Returns: A view with the updated environment value.
    ///
    func deleteKeywordButtonImage(_ value: Image) -> some View {
        environment(\.deleteKeywordButtonImage, value)
    }
    
    /// Sets the title for the label of the start date picker in the date range filter component.
    ///
    /// - Parameter value: The title string.
    /// - Returns: A view with the updated environment value.
    ///
    func startDateString(_ value: String) -> some View {
        environment(\.startDateString, value)
    }
    
    /// Sets the title for the label of the date picker in the single date filter component.
    ///
    /// - Parameter value: The title string.
    /// - Returns: A view with the updated environment value.
    ///
    func dateString(_ value: String) -> some View {
        environment(\.dateString, value)
    }
    
    /// Sets the title for the label of the end date picker in the date range filter component.
    ///
    /// - Parameter value: The title string.
    /// - Returns: A view with the updated environment value.
    /// 
    func endDateString(_ value: String) -> some View {
        environment(\.endDateString, value)
    }
    
    
    /// Sets the the title display mode for the for navigation bar displayed in all filter components.
    ///
    /// - Parameter value: The style to use for displaying the title.
    /// - Returns: A view with the updated environment value.
    ///
    func titleDisplayMode(_ value: NavigationBarItem.TitleDisplayMode) -> some View {
        environment(\.titleDisplayMode, value)
    }
    
}
