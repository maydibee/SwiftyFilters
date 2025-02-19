//
//  View.swift
//  ObservationFilters
//
//  Created by Michael Skuratau on 14/02/25.
//

import SwiftUI


extension View {
    
    func capsuled() -> some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(.clear)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray.opacity(0.7), lineWidth: 1)
            )
            .overlay {
                self
                
            }
    }
}
