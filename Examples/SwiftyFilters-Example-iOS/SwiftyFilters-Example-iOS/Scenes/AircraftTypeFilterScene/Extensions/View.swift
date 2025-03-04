//
//  View.swift
//  SwiftyFilters-Example-iOS
//
//  Created by Michael Skuratau on 04/03/25.
//

import SwiftUI


// MARK: - View extension

extension View {
    
    func capsuled(borderColor: Color) -> some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(.clear)
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(borderColor, lineWidth: 1)
            }
            .overlay {
                self
            }
    }
}
