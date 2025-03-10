
import XCTest
@testable import SwiftyFilters


final class SFSingleValueFilterTests: XCTestCase {
    
    // MARK: - Test Setup
    
    var filterByType: SFSingleValueFilter<Aircraft, AircraftType>!
    var filterByExploiter: SFSingleValueFilter<Aircraft, AircraftExploiter>!
    
    let testAircrafts = [
        Aircraft(
            id: UUID(),
            type: .mockBoeing1,
            remarks: "New delivery",
            capacity: 180,
            lastExploater: .mockExploiter1,
            firstFlightDate: Date().addingTimeInterval(-86400 * 365), // 1 year ago
            manufactureDate: Date()
        ),
        Aircraft(
            id: UUID(),
            type: .mockAirbus1,
            remarks: "Regular maintenance",
            capacity: 220,
            lastExploater: nil, // No exploiter
            firstFlightDate: Date().addingTimeInterval(-86400 * 180), // 6 months ago
            manufactureDate: Date()
        ),
        Aircraft(
            id: UUID(),
            type: .mockBoeing2,
            remarks: "Leased aircraft",
            capacity: 200,
            lastExploater: .mockExploiter2,
            firstFlightDate: Date().addingTimeInterval(-86400 * 730), // 2 years ago
            manufactureDate: Date()
        ),
        Aircraft(
            id: UUID(),
            type: .mockBoeing3,
            remarks: "Out of service",
            capacity: 0,
            lastExploater: .mockExploiter3,
            firstFlightDate: Date().addingTimeInterval(-86400 * 3650), // 10 years ago
            manufactureDate: Date()
        )
    ]
    
    override func setUp() {
        super.setUp()
        
        // Filter by AircraftType (non-optional)
        filterByType = SFSingleValueFilter<Aircraft, AircraftType>(title: "Aircraft Type")
            .filter(by: \.type)
        
        // Filter by AircraftExploiter (optional)
        filterByExploiter = SFSingleValueFilter<Aircraft, AircraftExploiter>(title: "Last Exploiter")
            .filter(byOptional: \.lastExploater)
            .includeNone(withTitle: "No Exploiter")
    }
    
    // MARK: - AircraftType Tests (Non-Optional)
    
    func testTypeFilter_IncludesMatchingType() {
        let result = filterByType.filterBehavior(testAircrafts, .mockBoeing1, false)
        
        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result.first?.type, .mockBoeing1)
    }
    
    func testTypeFilter_ExcludesNonMatchingType() {
        let result = filterByType.filterBehavior(testAircrafts, .mockAirbus1, false)
        
        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result.first?.type, .mockAirbus1)
    }
    
    // MARK: - AircraftExploiter Tests (Optional)
    
    func testExploiterFilter_IncludesMatchingExploiter() {
        let result = filterByExploiter.filterBehavior(testAircrafts, .mockExploiter1, false)
        
        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result.first?.lastExploater, .mockExploiter1)
    }
    
    func testExploiterFilter_IncludesNoneWhenEnabled() {
        let result = filterByExploiter.filterBehavior(testAircrafts, .mockExploiter1, true)
        
        XCTAssertEqual(result.count, 2)
        XCTAssertTrue(result.contains { $0.lastExploater == .mockExploiter1 })
        XCTAssertTrue(result.contains { $0.lastExploater == nil })
    }
    
    func testExploiterFilter_ExcludesNoneWhenDisabled() {
        let result = filterByExploiter.filterBehavior(testAircrafts, .mockExploiter1, false)
        
        XCTAssertEqual(result.count, 1)
        XCTAssertFalse(result.contains { $0.lastExploater == nil })
    }
    
    // MARK: - Edge Cases
    
    func testTypeFilter_NoMatches() {
        let nonExistentType = AircraftType(id: UUID(), name: "Non-Existent", photoName: "none")
        let result = filterByType.filterBehavior(testAircrafts, nonExistentType, false)
        
        XCTAssertTrue(result.isEmpty)
    }
    
    func testExploiterFilter_NoMatches() {
        let nonExistentExploiter = AircraftExploiter(id: UUID(), name: "Non-Existent")
        let result = filterByExploiter.filterBehavior(testAircrafts, nonExistentExploiter, false)
        
        XCTAssertTrue(result.isEmpty)
    }
    
    func testExploiterFilter_AllNone() {
        let result = filterByExploiter.filterBehavior(testAircrafts, .mockExploiter1, true)
        
        XCTAssertEqual(result.count, 2)
        XCTAssertTrue(result.contains { $0.lastExploater == .mockExploiter1 })
        XCTAssertTrue(result.contains { $0.lastExploater == nil })
    }
}

