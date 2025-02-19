import XCTest
@testable import SwiftyFilters

final class SFFilterMultiSelectionContainerTests: XCTestCase {
    
    // MARK: - Container initial state testing
    
    func testInitialization() {
        // Arrange
        let resolver = SFFilterResolverStub()
        let fetcher = SFFilterFetcherStub()
        let container = SFFilterMultiSelectionContainer(resolver: resolver, fetcher: fetcher, isNoneIncluded: true)

        // Assert
        XCTAssertTrue(container.isNoneIncluded)
        XCTAssertTrue(container.isNoneEnabled)
        XCTAssertEqual(container.isNoneEnabled, container.isNoneIncluded)
        XCTAssertEqual(container.allItems.count, 0)
        XCTAssertEqual(container.selectedItems.count, 0)
        XCTAssertFalse(container.isFilterActive)
    }
    
    // MARK: - Container initialized state testing
    
    func testInitializeFilter() async {
        // Arrange
        let resolver = SFFilterResolverStub()
        let fetcher = SFFilterFetcherStub()
        let container = SFFilterMultiSelectionContainer(resolver: resolver, fetcher: fetcher)

        // Act
        let fetchedItems = await container.initializeFilter()

        // Assert
        XCTAssertEqual(fetchedItems.count, 3)
        XCTAssertEqual(container.allItems.count, 3)
        XCTAssertEqual(container.selectedItems.count, 3)
        XCTAssertEqual(container.selectedItems.count, container.allItems.count)
    }
    
    // MARK: - Inactive filter should't influence filtering
    
    func testFilterItemsInactive() {
        // Arrange
        let resolver = SFFilterResolverStub()
        let fetcher = SFFilterFetcherStub()
        let container = SFFilterMultiSelectionContainer(resolver: resolver, fetcher: fetcher)

        let inputItems = [SFFilterFilteredItemMock(id: 1), SFFilterFilteredItemMock(id: 2), SFFilterFilteredItemMock(id: 3)]

        // Act
        let filteredItems = container.filterItems(inputItems: inputItems)
        
        // Assert
        XCTAssertFalse(container.isFilterActive)
        XCTAssertEqual(filteredItems.count, 3)
    }
    
    // MARK: - Filtering testing
    
    func testFilterItemsActive() async {
        // Arrange
        let resolver = SFFilterResolverStub()
        let fetcher = SFFilterFetcherStub()
        let container = SFFilterMultiSelectionContainer(resolver: resolver, fetcher: fetcher)

        let inputItems = [SFFilterFilteredItemMock(id: 1), SFFilterFilteredItemMock(id: 2), SFFilterFilteredItemMock(id: 3)]

        // Act
        await container.initializeFilter()
        container.selectedItems.removeFirst()
        let filteredItems = container.filterItems(inputItems: inputItems)
        
        // Assert
        XCTAssertEqual(filteredItems.count, 2)
        XCTAssertTrue(container.isFilterActive)
    }
    
    // MARK: - None should't be taken into account if it isn't included
    
    func testFilterNoneIsntIncluded() async {
        // Arrange
        let resolver = SFFilterResolverStub()
        let fetcher = SFFilterFetcherStub()
        let container = SFFilterMultiSelectionContainer(resolver: resolver, fetcher: fetcher, isNoneIncluded: false)
    
        // Assert
        XCTAssertFalse(container.isNoneEnabled)
    }
    
    // MARK: - Filter should be inactive even if isNoneEnabled is false while isNoneIncluded is false by default
    
    func testFilterNoneIsntIncludedActiveState() async {
        // Arrange
        let resolver = SFFilterResolverStub()
        let fetcher = SFFilterFetcherStub()
        let container = SFFilterMultiSelectionContainer(resolver: resolver, fetcher: fetcher, isNoneIncluded: false)
        
        // Act
        container.isNoneEnabled = false
        
        // Assert
        XCTAssertFalse(container.isFilterActive)
    }
    
    // MARK: - Filter should be active if isNoneIncluded is true but isNoneEnabled is false
    
    func testFilterNoneIncludedButNoneUnabled() {
        // Arrange
        let resolver = SFFilterResolverStub()
        let fetcher = SFFilterFetcherStub()
        let container = SFFilterMultiSelectionContainer(resolver: resolver, fetcher: fetcher, isNoneIncluded: true)
        
        // Act
        container.isNoneEnabled = false
        
        // Assert
        XCTAssertTrue(container.isFilterActive)
    }
}
