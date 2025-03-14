//
//  AircraftRow.swift
//  SwiftyFilters-Example-iOS
//
//  Created by Michael Skuratau on 24/02/25.
//

import SwiftUI


// MARK: - AircraftRow view

struct AircraftRow: View {
    let aircraft: Aircraft
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }
    
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            
            Image(aircraft.type.photoName)
                .resizable()
                .scaledToFill()
                .frame(width: 80, height: 80)
                .cornerRadius(8)
                .clipped()
            
            
            VStack(alignment: .leading, spacing: 4) {
                Text(aircraft.type.name)
                    .font(.headline)
                    .foregroundColor(.primary)
                
                Text("Capacity: \(aircraft.capacity) passengers")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                if let exploater = aircraft.lastExploater {
                    Text("Last exploater: \(exploater.name)")
                        .font(.caption)
                        .foregroundColor(.gray)
                } else {
                    Text("New aircraft")
                        .font(.caption)
                        .foregroundColor(.green)
                }
                
                Text("First flight: \(dateFormatter.string(from: aircraft.firstFlightDate))")
                    .font(.caption)
                    .foregroundColor(.gray)
                
                Text("Manufacture date: \(dateFormatter.string(from: aircraft.manufactureDate))")
                    .font(.caption)
                    .foregroundColor(.gray)
                
                Text(aircraft.remarks)
                    .font(.caption)
                    .foregroundColor(.gray)
                    .lineLimit(2)
                    .padding(.top, 4)
            }
        }
        .padding(.vertical, 8)
    }
}
