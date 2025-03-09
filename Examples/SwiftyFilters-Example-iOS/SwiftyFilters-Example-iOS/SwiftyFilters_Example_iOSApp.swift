//
//  SwiftyFilters_Example_iOSApp.swift
//  SwiftyFilters-Example-iOS
//
//  Created by Michael Skuratau on 23/02/25.
//

import SwiftUI

@main
struct SwiftyFilters_Example_iOSApp: App {
    var body: some Scene {
        WindowGroup {
            let worker = AircraftListWorkerStub()
            let viewModel = AircraftListViewModel(worker: worker)
            AircraftListView(viewModel: viewModel)
        }
    }
}
