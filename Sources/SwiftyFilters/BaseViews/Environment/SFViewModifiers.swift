//
//  SFViewModifiers.swift
//  ObservationFilters
//
//  Created by Michael Skuratau on 18/02/25.
//

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
