
import XCTest
@testable import SwiftyFilters


final class SFKeywordsFilterTests: XCTestCase {
    
    // MARK: - Test Setup
    
    var filter: SFKeywordsFilter<Aircraft>!
    
    let testAircrafts = [
        Aircraft(
            id: UUID(),
            type: .mockBoeing1,
            remarks: "New delivery, requires inspection",
            capacity: 180,
            lastExploater: .mockExploiter1,
            firstFlightDate: Date(),
            manufactureDate: Date()
        ),
        Aircraft(
            id: UUID(),
            type: .mockAirbus1,
            remarks: "Regular maintenance completed",
            capacity: 220,
            lastExploater: nil,
            firstFlightDate: Date(),
            manufactureDate: Date()
        ),
        Aircraft(
            id: UUID(),
            type: .mockBoeing2,
            remarks: "Leased aircraft, no remarks",
            capacity: 200,
            lastExploater: .mockExploiter2,
            firstFlightDate: Date(),
            manufactureDate: Date()
        ),
        Aircraft(
            id: UUID(),
            type: .mockBoeing3,
            remarks: "", // Empty remarks
            capacity: 250,
            lastExploater: .mockExploiter3,
            firstFlightDate: Date(),
            manufactureDate: Date()
        )
    ]
    
    override func setUp() {
        super.setUp()
        
        // Initialize filter with test data
        filter = SFKeywordsFilter(title: "Remarks")
            .filter(by: \.remarks)
            .includeNone(withTitle: "No Remarks")
    }
    
    override func tearDown() {
        filter = nil
        super.tearDown()
    }
    
    // MARK: - Keyword Filtering Tests
    
    func testFilterByRemarks_IncludesMatchingAircraft() {
        // Arrange
        var keywordsModel = SFFilterKeywordsModel<String>()
        keywordsModel.addKeywords(["inspection"])
        
        // Act
        let result = filter.filterBehavior(testAircrafts, keywordsModel, false)
        
        // Assert
        XCTAssertEqual(result.count, 1)
        XCTAssertTrue(result.contains { $0.remarks.contains("inspection") })
    }
    
    func testFilterByRemarks_ExcludesNonMatchingAircraft() {
        // Arrange
        var keywordsModel = SFFilterKeywordsModel<String>()
        keywordsModel.addKeywords(["urgent"])
        
        // Act
        let result = filter.filterBehavior(testAircrafts, keywordsModel, false)
        
        // Assert
        XCTAssertTrue(result.isEmpty)
    }
    
    func testFilterByRemarks_EmptyKeywords_ReturnsAllItems() {
        // Arrange
        let keywordsModel = SFFilterKeywordsModel<String>()
        
        // Act
        let result = filter.filterBehavior(testAircrafts, keywordsModel, false)
        
        // Assert
        XCTAssertFalse(result.isEmpty)
    }
    
    // MARK: - None Inclusion Tests
    
    func testIncludeNone_IncludesAircraftWithEmptyRemarksWhenEnabled() {
        // Arrange
        var keywordsModel = SFFilterKeywordsModel<String>()
        keywordsModel.addKeywords(["inspection"])
        
        // Act
        let result = filter.filterBehavior(testAircrafts, keywordsModel, true)
        
        // Assert
        XCTAssertEqual(result.count, 2)
        XCTAssertTrue(result.contains { $0.remarks.isEmpty })
        XCTAssertTrue(result.contains { $0.remarks.contains("inspection") })
    }
    
    func testIncludeNone_ExcludesAircraftWithEmptyRemarksWhenDisabled() {
        // Arrange
        var keywordsModel = SFFilterKeywordsModel<String>()
        keywordsModel.addKeywords(["inspection"])
        
        // Act
        let result = filter.filterBehavior(testAircrafts, keywordsModel, false)
        
        // Assert
        XCTAssertEqual(result.count, 1)
        XCTAssertFalse(result.contains { $0.remarks.isEmpty })
    }
    
    // MARK: - Edge Cases
    
    func testFilterByRemarks_CaseInsensitiveMatching() {
        // Arrange
        var keywordsModel = SFFilterKeywordsModel<String>()
        keywordsModel.addKeywords(["INSPECTION"])
        
        // Act
        let result = filter.filterBehavior(testAircrafts, keywordsModel, false)
        
        // Assert
        XCTAssertEqual(result.count, 1)
        XCTAssertTrue(result.contains { $0.remarks.lowercased().contains("inspection") })
    }
    
    func testFilterByRemarks_PartialKeywordMatching() {
        // Arrange
        var keywordsModel = SFFilterKeywordsModel<String>()
        keywordsModel.addKeywords(["insp"])
        
        // Act
        let result = filter.filterBehavior(testAircrafts, keywordsModel, false)
        
        // Assert
        XCTAssertEqual(result.count, 1)
        XCTAssertTrue(result.contains { $0.remarks.contains("inspection") })
    }

}
