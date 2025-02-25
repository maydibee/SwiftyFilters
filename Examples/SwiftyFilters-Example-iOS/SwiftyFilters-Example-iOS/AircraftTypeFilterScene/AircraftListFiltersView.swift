//
//  AircraftListFiltersView.swift
//  SwiftyFilters-Example-iOS
//
//  Created by Софтрэйн on 25/02/25.
//

import SwiftUI
import SwiftyFilters


// MARK: - AircraftListFiltersView

struct AircraftListFiltersView: View {
    @StateObject var filtersCore: SFFiltersCore<Aircraft>
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Button {
                    filtersCore.resetFilters()
                } label: {
                    Text("Reset")
                        .foregroundStyle(.red)
                }
                Spacer()
                Button {
                    dismiss()
                } label: {
                    Text("OK")
                        .foregroundStyle(.white)
                }
            }
            .padding()
            .background(.blue.opacity(0.8))
            
            SFFilterRootView(filtersCore: filtersCore)
        }
    }
}


