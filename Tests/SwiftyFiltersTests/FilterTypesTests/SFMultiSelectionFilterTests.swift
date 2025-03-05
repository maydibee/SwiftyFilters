import XCTest
@testable import SwiftyFilters

final class SFMultiSelectionFilterTests: XCTestCase {
    
    // MARK: - Test Setup
    
    var filterByType: SFMultiSelectionFilter<Aircraft, AircraftType>!
    var filterByExploiter: SFMultiSelectionFilter<Aircraft, AircraftExploiter>!
    
    let testAircraftTypes = [
        AircraftType.mockBoeing1,
        AircraftType.mockBoeing2,
        AircraftType.mockAirbus1,
        AircraftType.mockAirbus2
    ]
    
    let testExploiters = [
        AircraftExploiter.mockExploiter1,
        AircraftExploiter.mockExploiter2,
        AircraftExploiter.mockExploiter3
    ]
    
    let testAircrafts = [
        Aircraft(
            id: UUID(),
            type: .mockBoeing1,
            remarks: "New delivery",
            capacity: 180,
            lastExploater: .mockExploiter1,
            firstFlightDate: Date(),
            manufactureDate: Date()
        ),
        Aircraft(
            id: UUID(),
            type: .mockAirbus1,
            remarks: "Regular maintenance",
            capacity: 220,
            lastExploater: nil,
            firstFlightDate: Date(),
            manufactureDate: Date()
        ),
        Aircraft(
            id: UUID(),
            type: .mockBoeing2,
            remarks: "Leased aircraft",
            capacity: 200,
            lastExploater: .mockExploiter2,
            firstFlightDate: Date(),
            manufactureDate: Date()
        )
    ]
    
    override func setUp() {
        super.setUp()
        
        // Initialize filters with test data
        filterByType = SFMultiSelectionFilter<Aircraft, AircraftType>(title: "Aircraft Type")
            .fetchItems { self.testAircraftTypes }
            .filter(by: \.type)
        
        filterByExploiter = SFMultiSelectionFilter<Aircraft, AircraftExploiter>(title: "Last Exploiter")
            .fetchItems { self.testExploiters }
            .filter(byOptional: \.lastExploater)
    }
    
    override func tearDown() {
        filterByType = nil
        filterByExploiter = nil
        super.tearDown()
    }
    
    // MARK: - Filter by Aircraft Type Tests
    
    func testFilterByType_IncludesMatchingAircraft() {
        // Arrange
        let selectedTypes = [AircraftType.mockBoeing1, AircraftType.mockAirbus1]
        
        // Act
        let result = filterByType.filterBehavior(testAircrafts, selectedTypes, false)
        
        // Assert
        XCTAssertEqual(result.count, 2)
        XCTAssertTrue(result.contains { $0.type == .mockBoeing1 })
        XCTAssertTrue(result.contains { $0.type == .mockAirbus1 })
    }
    
    func testFilterByType_ExcludesNonMatchingAircraft() {
        // Arrange
        let selectedTypes = [AircraftType.mockBoeing2]
        
        // Act
        let result = filterByType.filterBehavior(testAircrafts, selectedTypes, false)
        
        // Assert
        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result.first?.type, .mockBoeing2)
    }
    
    // MARK: - Filter by Last Exploiter Tests
    
    func testFilterByExploiter_IncludesAircraftWithMatchingExploiter() {
        // Arrange
        let selectedExploiters = [AircraftExploiter.mockExploiter1]
        
        // Act
        let result = filterByExploiter.filterBehavior(testAircrafts, selectedExploiters, false)
        
        // Assert
        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result.first?.lastExploater, .mockExploiter1)
    }
    
    func testFilterByExploiter_IncludesAircraftWithNoExploiterWhenNoneEnabled() {
        // Arrange
        let selectedExploiters = [AircraftExploiter.mockExploiter2]
        
        // Act
        let result = filterByExploiter.filterBehavior(testAircrafts, selectedExploiters, true)
        
        // Assert
        XCTAssertEqual(result.count, 2)
        XCTAssertTrue(result.contains { $0.lastExploater == nil })
        XCTAssertTrue(result.contains { $0.lastExploater == .mockExploiter2 })
    }
    
    func testFilterByExploiter_ExcludesAircraftWithNoExploiterWhenNoneDisabled() {
        // Arrange
        let selectedExploiters = [AircraftExploiter.mockExploiter2]
        
        // Act
        let result = filterByExploiter.filterBehavior(testAircrafts, selectedExploiters, false)
        
        // Assert
        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result.first?.lastExploater, .mockExploiter2)
    }
    
    // MARK: - Datasource Tests
    
    func testFetchItems_SetsCorrectDatasourceForTypes() async {
        // Act
        let items = await filterByType.criteriaItemsDatasource()
        
        // Assert
        XCTAssertEqual(items, testAircraftTypes)
    }
    
    func testFetchItems_SetsCorrectDatasourceForExploiters() async {
        // Act
        let items = await filterByExploiter.criteriaItemsDatasource()
        
        // Assert
        XCTAssertEqual(items, testExploiters)
    }
    
    // MARK: - Edge Cases
    
    func testFilterByType_EmptyCriteria_ReturnsNoMatches() {
        // Arrange
        let selectedTypes: [AircraftType] = []
        
        // Act
        let result = filterByType.filterBehavior(testAircrafts, selectedTypes, false)
        
        // Assert
        XCTAssertTrue(result.isEmpty)
    }
    
    func testFilterByExploiter_EmptyCriteria_ReturnsNoMatches() {
        // Arrange
        let selectedExploiters: [AircraftExploiter] = []
        
        // Act
        let result = filterByExploiter.filterBehavior(testAircrafts, selectedExploiters, false)
        
        // Assert
        XCTAssertTrue(result.isEmpty)
    }
    
    func testFilterByExploiter_NoneIncludedButDisabled_ReturnsNoMatchesForNilExploiters() {
        // Arrange
        let selectedExploiters: [AircraftExploiter] = []
        
        // Act
        let result = filterByExploiter.filterBehavior(testAircrafts, selectedExploiters, false)
        
        // Assert
        XCTAssertTrue(result.isEmpty)
    }
}

