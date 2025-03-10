
import XCTest
@testable import SwiftyFilters


final class SFFilterSingleValueContainerTests: XCTestCase {
    
    // MARK: - Properties
    
    private var resolver: SFFilterResolverSingleValueStub!
    private var container: SFFilterSingleValueContainer<SFFilterFilteredItemMock, Int>!
    
    // MARK: - Test Setup
    
    override func setUp() {
        super.setUp()
        resolver = SFFilterResolverSingleValueStub()
        container = SFFilterSingleValueContainer(resolver: resolver)
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
        XCTAssertNil(container.value)
        XCTAssertFalse(container.isFilterActive)
    }
    
    func testInitialState_WhenNoneIsIncluded_ShouldEnableNoneByDefault() {
        // Arrange
        let container = SFFilterSingleValueContainer(resolver: resolver, isNoneIncluded: true)
        
        // Assert
        XCTAssertTrue(container.isNoneIncluded)
        XCTAssertTrue(container.isNoneEnabled)
        XCTAssertEqual(container.isNoneEnabled, container.isNoneIncluded)
    }
    
    // MARK: - Filter Activity Tests
    
    func testFilterActivity_WhenValueIsNil_ShouldBeInactive() {
        // Assert
        XCTAssertFalse(container.isFilterActive)
    }
    
    func testFilterActivity_WhenValueIsSet_ShouldBeActive() {
        // Act
        container.value = 5
        
        // Assert
        XCTAssertTrue(container.isFilterActive)
    }
    
    func testFilterActivity_WhenNoneIncludedAndDisabled_ShouldBeActive() {
        // Arrange
        let container = SFFilterSingleValueContainer(resolver: resolver, isNoneIncluded: true)
        
        // Act
        container.isNoneEnabled = false
        
        // Assert
        XCTAssertTrue(container.isFilterActive)
    }
    
    func testFilterActivity_WhenNoneIncludedAndEnabled_ShouldBeInactive() {
        // Arrange
        let container = SFFilterSingleValueContainer(resolver: resolver, isNoneIncluded: true)
        
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
        container.value = 3
        
        // Act
        let result = container.filterItems(inputItems: inputItems)
        
        // Assert
        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result.first?.id, 3)
    }
}

