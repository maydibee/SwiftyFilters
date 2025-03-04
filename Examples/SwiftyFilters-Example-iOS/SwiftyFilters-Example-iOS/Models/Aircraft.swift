//
//  Car.swift
//  SwiftyFilters-Example-iOS
//
//  Created by Michael Skuratau on 24/02/25.
//

import Foundation


// MARK: - Aircraft model

struct Aircraft {
    
    var id: UUID
    var type: AircraftType
    var remarks: String
    var capacity: Int
    var lastExploater: AircraftExploiter?
    
    var firstFlightDate: Date
    var manufactureDate: Date
    
    var isNew: Bool {
        lastExploater == nil
    }
}


// MARK: - Mocks

extension Aircraft {
    
    static let mockAircrafts: [Aircraft] = [
        Aircraft(
            id: UUID(),
            type: AircraftType.mockBoeing1,
            remarks: "Newly refurbished with advanced avionics.",
            capacity: 180,
            lastExploater: AircraftExploiter.mockExploiter1,
            firstFlightDate: Date(timeIntervalSince1970: 1577836800), // 2020-01-01
            manufactureDate: Date(timeIntervalSince1970: 1546300800) // 2019-01-01
        ),
        Aircraft(
            id: UUID(),
            type: AircraftType.mockBoeing2,
            remarks: "High-capacity long-haul aircraft.",
            capacity: 350,
            lastExploater: AircraftExploiter.mockExploiter2,
            firstFlightDate: Date(timeIntervalSince1970: 1609459200), // 2021-01-01
            manufactureDate: Date(timeIntervalSince1970: 1577836800) // 2020-01-01
        ),
        Aircraft(
            id: UUID(),
            type: AircraftType.mockBoeing3,
            remarks: "Fuel-efficient and comfortable.",
            capacity: 290,
            lastExploater: nil, // Новый самолет
            firstFlightDate: Date(timeIntervalSince1970: 1640995200), // 2022-01-01
            manufactureDate: Date(timeIntervalSince1970: 1609459200) // 2021-01-01
        ),
        Aircraft(
            id: UUID(),
            type: AircraftType.mockAirbus1,
            remarks: "Wide-body aircraft with modern amenities.",
            capacity: 300,
            lastExploater: AircraftExploiter.mockExploiter3,
            firstFlightDate: Date(timeIntervalSince1970: 1672531200), // 2023-01-01
            manufactureDate: Date(timeIntervalSince1970: 1640995200) // 2022-01-01
        ),
        Aircraft(
            id: UUID(),
            type: AircraftType.mockAirbus2,
            remarks: "Reliable and efficient for medium-haul flights.",
            capacity: 250,
            lastExploater: AircraftExploiter.mockExploiter1,
            firstFlightDate: Date(timeIntervalSince1970: 1546300800), // 2019-01-01
            manufactureDate: Date(timeIntervalSince1970: 1514764800) // 2018-01-01
        ),
        Aircraft(
            id: UUID(),
            type: AircraftType.mockAirbus3,
            remarks: "State-of-the-art with carbon fiber construction.",
            capacity: 320,
            lastExploater: nil, // Новый самолет
            firstFlightDate: Date(timeIntervalSince1970: 1609459200), // 2021-01-01
            manufactureDate: Date(timeIntervalSince1970: 1577836800) // 2020-01-01
        ),
        Aircraft(
            id: UUID(),
            type: AircraftType.mockBoeing1,
            remarks: "Recently serviced and ready for operation.",
            capacity: 180,
            lastExploater: AircraftExploiter.mockExploiter2,
            firstFlightDate: Date(timeIntervalSince1970: 1672531200), // 2023-01-01
            manufactureDate: Date(timeIntervalSince1970: 1640995200) // 2022-01-01
        ),
        Aircraft(
            id: UUID(),
            type: AircraftType.mockBoeing2,
            remarks: "Ideal for transcontinental flights.",
            capacity: 350,
            lastExploater: AircraftExploiter.mockExploiter3,
            firstFlightDate: Date(timeIntervalSince1970: 1546300800), // 2019-01-01
            manufactureDate: Date(timeIntervalSince1970: 1514764800) // 2018-01-01
        ),
        Aircraft(
            id: UUID(),
            type: AircraftType.mockBoeing3,
            remarks: "Eco-friendly and quiet operation.",
            capacity: 290,
            lastExploater: nil, // Новый самолет
            firstFlightDate: Date(timeIntervalSince1970: 1609459200), // 2021-01-01
            manufactureDate: Date(timeIntervalSince1970: 1577836800) // 2020-01-01
        ),
        Aircraft(
            id: UUID(),
            type: AircraftType.mockAirbus1,
            remarks: "Spacious cabin with premium seating.",
            capacity: 300,
            lastExploater: AircraftExploiter.mockExploiter1,
            firstFlightDate: Date(timeIntervalSince1970: 1672531200), // 2023-01-01
            manufactureDate: Date(timeIntervalSince1970: 1640995200) // 2022-01-01
        ),
        Aircraft(
            id: UUID(),
            type: AircraftType.mockAirbus2,
            remarks: "Proven reliability for short-haul routes.",
            capacity: 250,
            lastExploater: AircraftExploiter.mockExploiter2,
            firstFlightDate: Date(timeIntervalSince1970: 1546300800), // 2019-01-01
            manufactureDate: Date(timeIntervalSince1970: 1514764800) // 2018-01-01
        ),
        Aircraft(
            id: UUID(),
            type: AircraftType.mockAirbus3,
            remarks: "Advanced technology for long-haul comfort.",
            capacity: 320,
            lastExploater: nil, // Новый самолет
            firstFlightDate: Date(timeIntervalSince1970: 1609459200), // 2021-01-01
            manufactureDate: Date(timeIntervalSince1970: 1577836800) // 2020-01-01
        )
    ]
}
