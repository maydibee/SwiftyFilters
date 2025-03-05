import XCTest
@testable import SwiftyFilters


final class SFRangeFilterTests: XCTestCase {
    
    // MARK: - Test Setup
    
    var filterByCapacity: SFRangeFilter<Aircraft, Int>!
    var filterByFlightDate: SFRangeFilter<Aircraft, Date>!
    
    let testAircrafts = [
        Aircraft(
            id: UUID(),
            type: .mockBoeing1,
            remarks: "New delivery",
            capacity: 180,
            lastExploater: .mockExploiter1,
            firstFlightDate: Date().addingTimeInterval(-86400*365), // 1 year ago
            manufactureDate: Date()
        ),
        Aircraft(
            id: UUID(),
            type: .mockAirbus1,
            remarks: "Regular maintenance",
            capacity: 220,
            lastExploater: nil,
            firstFlightDate: nil, // No flight date
            manufactureDate: Date()
        ),
        Aircraft(
            id: UUID(),
            type: .mockBoeing2,
            remarks: "Leased aircraft",
            capacity: 200,
            lastExploater: .mockExploiter2,
            firstFlightDate: Date().addingTimeInterval(-86400*180), // 6 months ago
            manufactureDate: Date()
        ),
        Aircraft(
            id: UUID(),
            type: .mockBoeing3,
            remarks: "Out of service",
            capacity: 0,
            lastExploater: .mockExploiter3,
            firstFlightDate: Date().addingTimeInterval(-86400*730), // 2 years ago
            manufactureDate: Date()
        )
    ]
    
    override func setUp() {
        super.setUp()
        
        // Non-optional capacity filter
        filterByCapacity = SFRangeFilter<Aircraft, Int>(title: "Capacity")
            .filter(by: \.capacity)
        
        // Optional flight date filter
        filterByFlightDate = SFRangeFilter<Aircraft, Date>(title: "First Flight")
            .filter(byOptional: \.firstFlightDate)
            .includeNone(withTitle: "No Date")
    }
    
    // MARK: - Capacity Tests (Non-Optional)
    
    func testCapacityFilter_IncludesInRange() {
        let range = SFFilterRange(lowerBound: 150, upperBound: 210)
        let result = filterByCapacity.filterBehavior(testAircrafts, range, false)
        
        XCTAssertEqual(result.count, 2)
        XCTAssertTrue(result.contains { $0.capacity == 180 })
        XCTAssertTrue(result.contains { $0.capacity == 200 })
    }
    
    func testCapacityFilter_ExactMatch() {
        let range = SFFilterRange(lowerBound: 220, upperBound: 220)
        let result = filterByCapacity.filterBehavior(testAircrafts, range, false)
        
        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result.first?.capacity, 220)
    }
    
    // MARK: - Flight Date Tests (Optional)
    
    func testFlightDateFilter_IncludesInDateRange() {
        let now = Date()
        let range = SFFilterRange(
            lowerBound: Date().addingTimeInterval(-86400*365).startOfDay, // 1 year ago
            upperBound: now.endOfDay
        )
        
        let result = filterByFlightDate.filterBehavior(testAircrafts, range, false)
        
        XCTAssertEqual(result.count, 2)
        XCTAssertTrue(result.contains { $0.firstFlightDate != nil })
    }
    
    func testFlightDateFilter_IncludesNilWhenNoneEnabled() {
        let now = Date()
        let range = SFFilterRange(
            lowerBound: Date().addingTimeInterval(-86400*365).startOfDay, // 1 year ago,
            upperBound: now.endOfDay
        )
        
        let result = filterByFlightDate.filterBehavior(testAircrafts, range, true)
        
        XCTAssertEqual(result.count, 3)
        XCTAssertTrue(result.contains { $0.firstFlightDate == nil })
    }
    
    func testFlightDateFilter_ExcludesNilWhenNoneDisabled() {
        let now = Date()
        let range = SFFilterRange(
            lowerBound: now.addingTimeInterval(-86400*365).startOfDay,
            upperBound: now.endOfDay
        )
        
        let result = filterByFlightDate.filterBehavior(testAircrafts, range, false)
        
        XCTAssertEqual(result.count, 2)
        XCTAssertFalse(result.contains { $0.firstFlightDate == nil })
    }
    
    // MARK: - Edge Cases
    
    func testZeroCapacity_HandledCorrectly() {
        let range = SFFilterRange(lowerBound: 0, upperBound: 0)
        let result = filterByCapacity.filterBehavior(testAircrafts, range, false)
        
        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result.first?.capacity, 0)
    }
    
    func testFutureDateRange_ReturnsNoMatches() {
        let futureDate = Date().addingTimeInterval(86400*30)
        let range = SFFilterRange(lowerBound: futureDate.startOfDay, upperBound: futureDate.addingTimeInterval(86400).endOfDay)
        
        let result = filterByFlightDate.filterBehavior(testAircrafts, range, false)
        
        XCTAssertTrue(result.isEmpty)
    }
}
