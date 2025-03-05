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
    
    @StateObject var viewModel: AircraftListViewModel
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationView {
            List(viewModel.filteredAircraft, id: \.id) { aircraft in
                AircraftRow(aircraft: aircraft)
                    .padding(.vertical, 8)
                    .transition(.slide)
            }
            .navigationTitle("Aircraft List")
            .listStyle(PlainListStyle())
            .animation(.smooth, value: viewModel.filteredAircraft.count)
            .background {
                Image("background")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .opacity(0.6)
                    .ignoresSafeArea()
            }
            .task {
                await viewModel.loadAircraft()
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
        let worker = AircraftListWorkerStub()
        let viewModel = AircraftListViewModel(worker: worker)
        AircraftListView(viewModel: viewModel)
    }
}
