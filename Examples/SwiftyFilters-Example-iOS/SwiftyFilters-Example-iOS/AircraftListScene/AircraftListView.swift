//
//  AircraftListView.swift
//  SwiftyFilters-Example-iOS
//
//  Created by Michael Skuratau on 24/02/25.
//

import SwiftUI
import SwiftyFilters


// MARK: - AircraftListView

struct AircraftListView: View {
    @StateObject private var viewModel = AircraftListViewModel()
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationView {
            List(viewModel.filteredAircrafts, id: \.id) { aircraft in
                AircraftRow(aircraft: aircraft)
                    .padding(.vertical, 8)
                    .transition(.slide)
            }
            .navigationTitle("Aircraft List")
            .listStyle(PlainListStyle())
            .animation(.smooth, value: viewModel.filteredAircrafts.count)
            .background {
                Image("background")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .opacity(0.6)
                    .ignoresSafeArea()
            }
            .task {
                viewModel.loadAircrafts()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        viewModel.isFiltersViewPresented = true
                    } label: {
                        Image("filter-icon")
                            .renderingMode(.template)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(colorScheme == .dark ? .white : .black )
                            .frame(width: 30)
                    }
                }
            }
            .sheet(isPresented: $viewModel.isFiltersViewPresented) {
                AircraftListFiltersView(filtersCore: viewModel.filtersCore)
                    .onDisappear {
                        viewModel.applyFilters()
                    }
            }
        }
    }
}


// MARK: - AircraftListView preview

struct AircraftListView_Previews: PreviewProvider {
    static var previews: some View {
        AircraftListView()
    }
}
