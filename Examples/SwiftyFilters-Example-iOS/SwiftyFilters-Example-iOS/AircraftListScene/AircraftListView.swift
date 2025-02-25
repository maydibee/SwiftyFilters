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
    let aircrafts: [Aircraft] = Aircraft.mockAircrafts
    
    @State var filteredAircrafts: [Aircraft] = []
    
    static private var aircraftTypeFilterComponent: SFFilterComponent = {
        let fetcher = AircraftTypeFilterFetcher()
        let resolver = AircraftTypeFilterResolver()
        
        return SFFilterComponentsFactory.createMultiSelectionComponent(title: "Aircraft type",
                                                                       resolver: resolver,
                                                                       fetcher: fetcher,
                                                                       noneItemTitle: "None")
    }()
    
    private var filtersCore = SFFiltersCore<Aircraft>(title: "Filters") {
        Self.aircraftTypeFilterComponent
    }
    
    @State private var isFiltersViewPresented = false
    
    var body: some View {
        NavigationView {
            List(filteredAircrafts, id: \.id) { aircraft in
                AircraftRow(aircraft: aircraft)
                    .padding(.vertical, 8)
                    .transition(.slide)
            }
            .navigationTitle("Aircraft List")
            .listStyle(PlainListStyle())
            .animation(.smooth, value: filteredAircrafts.count)
            .background {
                VStack {
                    Image("background")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .opacity(0.6)
                        .ignoresSafeArea()
                    Spacer()
                }
                .ignoresSafeArea()
            }
            .task {
                self.filteredAircrafts = aircrafts
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        isFiltersViewPresented = true
                    } label: {
                        Image("filter-icon")
                            .renderingMode(.template)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(.black)
                            .frame(width: 30)
                    }
                }
            }
            .sheet(isPresented: $isFiltersViewPresented) {
                AircraftListFiltersView(filtersCore: filtersCore)
                    .onDisappear {
                        self.filteredAircrafts = filtersCore.getFilteredData(from: aircrafts)
                    }
            }
        }
    }
}

import SwiftyFilters

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
                        Text("Apply")
                            .foregroundStyle(.white)
                    }
                }
                .padding()
                .background(.blue.opacity(0.7))
            
                SFFilterRootView(filtersCore: filtersCore)
            }

    }
}



// MARK: - AircraftListView preview

struct AircraftListView_Previews: PreviewProvider {
    static var previews: some View {
        AircraftListView()
    }
}
