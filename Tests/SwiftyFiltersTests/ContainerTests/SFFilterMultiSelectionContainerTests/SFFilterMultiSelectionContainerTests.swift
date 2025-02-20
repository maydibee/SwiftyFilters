import XCTest
@testable import SwiftyFilters


final class SFFilterMultiSelectionContainerTests: XCTestCase {
    
    // MARK: - Properties
    
    private var resolver: SFFilterResolverStub!
    private var fetcher: SFFilterFetcherStub!
    private var container: SFFilterMultiSelectionContainer<SFFilterFilteredItemMock, SFFilterCriteriaItemMock>!
    
    // MARK: - Test Setup
    
    override func setUp() {
        super.setUp()
        resolver = SFFilterResolverStub()
        fetcher = SFFilterFetcherStub()
        container = SFFilterMultiSelectionContainer(
            resolver: resolver,
            fetcher: fetcher
        )
    }
    
    override func tearDown() {
        resolver = nil
        fetcher = nil
        container = nil
        super.tearDown()
    }
    
    // MARK: - Initial State Tests
    
    func testInitialState_WhenCreatedWithDefaultParameters_ShouldHaveCorrectProperties() {
        // Assert
        XCTAssertFalse(container.isNoneIncluded)
        XCTAssertFalse(container.isNoneEnabled)
        XCTAssertEqual(container.isNoneEnabled, container.isNoneIncluded)
        XCTAssertTrue(container.allItems.isEmpty)
        XCTAssertTrue(container.selectedItems.isEmpty)
        XCTAssertFalse(container.isFilterActive)
    }
    
    func testInitialState_WhenNoneIsIncluded_ShouldEnableNoneByDefault() {
        // Arrange
        let container = SFFilterMultiSelectionContainer(
            resolver: resolver,
            fetcher: fetcher,
            isNoneIncluded: true
        )
        
        // Assert
        XCTAssertTrue(container.isNoneIncluded)
        XCTAssertTrue(container.isNoneEnabled)
    }
    
    // MARK: - Filter Initialization Tests
    
    func testInitializeFilter_ShouldFetchAndSetItems() async {
        // Act
        let fetchedItems = await container.initializeFilter()
        
        // Assert
        XCTAssertEqual(fetchedItems.count, 3)
        XCTAssertEqual(container.allItems.count, 3)
        XCTAssertEqual(container.selectedItems.count, 3)
        XCTAssertEqual(container.selectedItems.count, container.allItems.count)
    }
    
    // MARK: - Filter Activity Tests
    
    func testFilterActivity_WhenAllItemsSelected_ShouldBeInactive() async {
        // Arrange
        await container.initializeFilter()
        
        // Assert
        XCTAssertFalse(container.isFilterActive)
    }
    
    func testFilterActivity_WhenItemDeselected_ShouldBeActive() async {
        // Arrange
        await container.initializeFilter()
        
        // Act
        container.selectedItems.removeFirst()
        
        // Assert
        XCTAssertTrue(container.isFilterActive)
    }
    
    func testFilterActivity_WhenNoneDisabledWithInclusion_ShouldBeActive() {
        // Arrange
        let container = SFFilterMultiSelectionContainer(
            resolver: resolver,
            fetcher: fetcher,
            isNoneIncluded: true
        )
        
        // Act
        container.isNoneEnabled = false
        
        // Assert
        XCTAssertTrue(container.isFilterActive)
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
    
    func testFilterItems_WhenActive_ShouldApplyResolverLogic() async {
        // Arrange
        let inputItems = Array(1...3).map(SFFilterFilteredItemMock.init)
        await container.initializeFilter()
        container.selectedItems.removeFirst()
        
        // Act
        let result = container.filterItems(inputItems: inputItems)
        
        // Assert
        XCTAssertEqual(result.count, 2)
        XCTAssertTrue(result.allSatisfy { $0.id != 1 })
    }
    
    // MARK: - None Inclusion Tests
    
    func testNoneHandling_WhenNotIncluded_ShouldIgnoreNoneState() {
        // Act
        container.isNoneEnabled = false
        
        // Assert
        XCTAssertFalse(container.isFilterActive)
    }
    
    func testNoneHandling_WhenIncludedAndDisabled_ShouldAffectFilterState() {
        // Arrange
        let container = SFFilterMultiSelectionContainer(
            resolver: resolver,
            fetcher: fetcher,
            isNoneIncluded: true
        )
        
        // Act
        container.isNoneEnabled = false
        
        // Assert
        XCTAssertTrue(container.isFilterActive)
    }
    
    func testNoneHandling_WhenIncludedAndEnabled_ShouldNotAffectFilterState() {
        // Arrange
        let container = SFFilterMultiSelectionContainer(
            resolver: resolver,
            fetcher: fetcher,
            isNoneIncluded: true
        )
        
        // Assert
        XCTAssertFalse(container.isFilterActive)
    }
}
