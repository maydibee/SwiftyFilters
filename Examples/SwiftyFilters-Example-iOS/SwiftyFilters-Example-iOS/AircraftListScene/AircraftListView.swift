//
//  AircraftListView.swift
//  SwiftyFilters-Example-iOS
//
//  Created by Michael Skuratau on 24/02/25.
//

import SwiftUI


// MARK: - AircraftListView

struct AircraftListView: View {
    let aircrafts: [Aircraft] = Aircraft.mockAircrafts
    
    var body: some View {
        NavigationView {
            List(aircrafts, id: \.id) { aircraft in
                AircraftRow(aircraft: aircraft)
                    .padding(.vertical, 8)
            }
            .navigationTitle("Aircraft List")
            .listStyle(PlainListStyle())
            .background {
                VStack {
                    Image("background")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .opacity(0.6)
                    Spacer()
                }
                .ignoresSafeArea()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        //
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
        }
    }
}


// MARK: - AircraftListView preview

struct AircraftListView_Previews: PreviewProvider {
    static var previews: some View {
        AircraftListView()
    }
}
