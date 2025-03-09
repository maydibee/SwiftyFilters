import Foundation
import SwiftyFilters


struct AircraftType: Identifiable {
    
    var id: UUID
    var name: String
    var photoName: String
    
    // MARK: - Mocks
    
    static let mockBoeing1 = Self(id: UUID(), name: "Boeing 737 MAX", photoName: "boeing737")
    static let mockBoeing2 = Self(id: UUID(), name: "Boeing 777-200", photoName: "boeing777")
    static let mockBoeing3 = Self(id: UUID(), name: "Boeing 787 Dreamliner", photoName: "boeing787")
    
    static let mockAirbus1 = Self(id: UUID(), name: "Airbus A330-300", photoName: "airbus330_300")
    static let mockAirbus2 = Self(id: UUID(), name: "Airbus A330-200", photoName: "airbus330_200")
    static let mockAirbus3 = Self(id: UUID(), name: "Airbus A350-900", photoName: "airbus350")
}

extension AircraftType: SFFiltersTitleable {
    
    var title: String {
        self.name
    }
}

extension AircraftType: Equatable {
    
    static func == (lhs: AircraftType, rhs: AircraftType) -> Bool {
        lhs.id == rhs.id
    }
}
