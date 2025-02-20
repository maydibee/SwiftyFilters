
import XCTest
@testable import SwiftyFilters


final class SFFilterRangeContainerTests: XCTestCase {
    
    // MARK: - Properties
    
    private var resolver: SFFilterResolverRangeStub!
    private var container: SFFilterRangeContainer<SFFilterFilteredItemMock, Int>!
    
    // MARK: - Test Setup
    
    override func setUp() {
        super.setUp()
        resolver = SFFilterResolverRangeStub()
        container = SFFilterRangeContainer(resolver: resolver)
    }
    
    override func tearDown() {
        resolver = nil
        container = nil
        super.tearDown()
    }
    
    // MARK: - Initial State Tests
    
    func testInitialState_WhenCreatedWithDefaultParameters_ShouldHaveCorrectProperties() {
        // Assert
        XCTAssertFalse(container.isNoneIncluded)
        XCTAssertFalse(container.isNoneEnabled)
        XCTAssertEqual(container.isNoneEnabled, container.isNoneIncluded)
        XCTAssertNil(container.range.lowerBound)
        XCTAssertNil(container.range.upperBound)
        XCTAssertFalse(container.isFilterActive)
    }
    
    func testInitialState_WhenNoneIsIncluded_ShouldEnableNoneByDefault() {
        // Arrange
        let container = SFFilterRangeContainer(resolver: resolver, isNoneIncluded: true)
        
        // Assert
        XCTAssertTrue(container.isNoneIncluded)
        XCTAssertTrue(container.isNoneEnabled)
        XCTAssertEqual(container.isNoneEnabled, container.isNoneIncluded)
    }
    
    // MARK: - Filter Activity Tests
    
    func testFilterActivity_WhenNoBoundsSet_ShouldBeInactive() {
        // Assert
        XCTAssertFalse(container.isFilterActive)
    }
    
    func testFilterActivity_WhenLowerBoundSet_ShouldBeActive() {
        // Act
        container.range = SFFilterRange(lowerBound: 5, upperBound: nil)
        
        // Assert
        XCTAssertTrue(container.isFilterActive)
    }
    
    func testFilterActivity_WhenUpperBoundSet_ShouldBeActive() {
        // Act
        container.range = SFFilterRange(lowerBound: nil, upperBound: 10)
        
        // Assert
        XCTAssertTrue(container.isFilterActive)
    }
    
    func testFilterActivity_WhenBothBoundsSet_ShouldBeActive() {
        // Act
        container.range = SFFilterRange(lowerBound: 5, upperBound: 10)
        
        // Assert
        XCTAssertTrue(container.isFilterActive)
    }
    
    func testFilterActivity_WhenNoneIncludedAndDisabled_ShouldBeActive() {
        // Arrange
        let container = SFFilterRangeContainer(resolver: resolver, isNoneIncluded: true)
        
        // Act
        container.isNoneEnabled = false
        
        // Assert
        XCTAssertTrue(container.isFilterActive)
    }
    
    func testFilterActivity_WhenNoneIncludedAndEnabled_ShouldBeInactive() {
        // Arrange
        let container = SFFilterRangeContainer(resolver: resolver, isNoneIncluded: true)
        
        // Assert
        XCTAssertFalse(container.isFilterActive)
    }
    
    // MARK: - Filtration Behavior Tests
    
    func testFilterItems_WhenInactive_ShouldReturnAllItems() {
        // Arrange
        let inputItems = Array(1...3).map(SFFilterFilteredItemMock.init)
        
        // Act
        let result = container.filterItems(inputItems: inputItems)
        
        // Assert
        XCTAssertEqual(result.count, 3)
    }
    
    func testFilterItems_WhenActive_ShouldApplyResolverLogic() {
        // Arrange
        let inputItems = Array(1...5).map(SFFilterFilteredItemMock.init)
        container.range = SFFilterRange(lowerBound: 2, upperBound: 4)
        
        // Act
        let result = container.filterItems(inputItems: inputItems)
        
        // Assert
        XCTAssertEqual(result.count, 3)
        XCTAssertTrue(result.allSatisfy { $0.id >= 2 && $0.id <= 4 })
    }
}
