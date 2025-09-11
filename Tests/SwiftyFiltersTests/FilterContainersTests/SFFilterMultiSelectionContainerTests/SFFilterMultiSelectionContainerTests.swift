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
        XCTAssertTrue(container.isFilterActive)
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
    
    func testFilterActivity_WhenUnloaded_ShouldBeActive() async {

        // Assert
        XCTAssertTrue(container.isFilterActive)
    }
    
    func testFilterActivity_WhenAllItemsSelected_ShouldBeActive() async {
        // Arrange
        await container.initializeFilter()
        
        // Assert
        XCTAssertTrue(container.isFilterActive)
    }
    
    func testFilterActivity_WhenItemDeselected_ShouldBeActive() async {
        // Arrange
        await container.initializeFilter()
        
        // Act
        container.selectedItems.removeFirst()
        
        // Assert
        XCTAssertTrue(container.isFilterActive)
    }
    
    func testFilterActivity_WhenAllDeselected_ShouldBeActive() async {
        // Arrange
        await container.initializeFilter()
        
        // Act
        container.selectedItems.removeAll()
        
        // Assert
        XCTAssertFalse(container.isFilterActive)
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
    
    // MARK: - isFilterModified Tests

    func testIsFilterModified_WhenUnloaded_ShouldReturnFalse() {
        // Assert - initial state with empty items
        XCTAssertFalse(container.isFilterModified)
    }

    func testIsFilterModified_WhenAllItemsSelected_ShouldReturnFalse() async {
        // Arrange
        await container.initializeFilter()
        
        // Assert - all items are selected by default after initialization
        XCTAssertFalse(container.isFilterModified)
    }

    func testIsFilterModified_WhenItemDeselected_ShouldReturnTrue() async {
        // Arrange
        await container.initializeFilter()
        
        // Act
        container.selectedItems.removeFirst()
        
        // Assert
        XCTAssertTrue(container.isFilterModified)
    }

    func testIsFilterModified_WhenAllDeselected_ShouldReturnTrue() async {
        // Arrange
        await container.initializeFilter()
        
        // Act
        container.selectedItems.removeAll()
        
        // Assert
        XCTAssertTrue(container.isFilterModified)
    }

    func testIsFilterModified_WhenNoneIncludedAndNoneDisabled_ShouldReturnTrue() {
        // Arrange
        let container = SFFilterMultiSelectionContainer(
            resolver: resolver,
            fetcher: fetcher,
            isNoneIncluded: true
        )
        
        // Act
        container.isNoneEnabled = false
        
        // Assert
        XCTAssertTrue(container.isFilterModified)
    }

    func testIsFilterModified_WhenNoneIncludedAndNoneEnabled_ShouldReturnFalse() {
        // Arrange
        let container = SFFilterMultiSelectionContainer(
            resolver: resolver,
            fetcher: fetcher,
            isNoneIncluded: true
        )
        
        // Assert - none is enabled by default when included
        XCTAssertFalse(container.isFilterModified)
    }

    func testIsFilterModified_WhenNoneIncludedAllSelectedAndNoneEnabled_ShouldReturnFalse() async {
        // Arrange
        let container = SFFilterMultiSelectionContainer(
            resolver: resolver,
            fetcher: fetcher,
            isNoneIncluded: true
        )
        
        // Act
        await container.initializeFilter()
        
        // Assert
        XCTAssertFalse(container.isFilterModified)
    }

    func testIsFilterModified_WhenNoneIncludedAllSelectedAndNoneDisabled_ShouldReturnTrue() async {
        // Arrange
        let container = SFFilterMultiSelectionContainer(
            resolver: resolver,
            fetcher: fetcher,
            isNoneIncluded: true
        )
        
        // Act
        await container.initializeFilter()
        container.isNoneEnabled = false
        
        // Assert
        XCTAssertTrue(container.isFilterModified)
    }

    func testIsFilterModified_WhenNoneIncludedNotAllSelectedAndNoneEnabled_ShouldReturnTrue() async {
        // Arrange
        let container = SFFilterMultiSelectionContainer(
            resolver: resolver,
            fetcher: fetcher,
            isNoneIncluded: true
        )
        
        // Act
        await container.initializeFilter()
        container.selectedItems.removeFirst() // Deselect one item
        
        // Assert
        XCTAssertTrue(container.isFilterModified)
    }

    func testIsFilterModified_WhenNoneNotIncludedAndItemDeselected_ShouldReturnTrue() async {
        // Arrange
        await container.initializeFilter()
        
        // Act
        container.selectedItems.removeFirst()
        
        // Assert
        XCTAssertTrue(container.isFilterModified)
    }

    func testIsFilterModified_WhenNoneNotIncludedAndAllSelected_ShouldReturnFalse() async {
        // Arrange
        await container.initializeFilter()
        
        // Assert - all items selected after initialization
        XCTAssertFalse(container.isFilterModified)
    }

    func testIsFilterModified_WhenReselectedAllAfterDeselection_ShouldReturnFalse() async {
        // Arrange
        await container.initializeFilter()
        
        // Act
        container.selectedItems.removeFirst() // Deselect
        let allItems = container.allItems
        container.selectedItems = allItems // Reselect all
        
        // Assert
        XCTAssertFalse(container.isFilterModified)
    }

    func testIsFilterModified_WhenNoneToggledBackToOriginalState_ShouldReturnFalse() {
        // Arrange
        let container = SFFilterMultiSelectionContainer(
            resolver: resolver,
            fetcher: fetcher,
            isNoneIncluded: true
        )
        
        // Act
        container.isNoneEnabled = false
        container.isNoneEnabled = true // Back to original state
        
        // Assert
        XCTAssertFalse(container.isFilterModified)
    }
    
    // MARK: - Filtration Behavior Tests
    
    func testFilterItems_WhenUnload_ShouldReturnAllItems() async {
        // Arrange
        let inputItems = Array(1...3).map(SFFilterFilteredItemMock.init)
        
        // Act
        let result = container.filterItems(inputItems: inputItems)
        
        
        // Assert
        XCTAssertEqual(result.count, 3)
        XCTAssertTrue(container.allItems.isEmpty)
        
    }
    
    func testFilterItems_WhenInactive_ShouldReturnAllItems() async {
        // Arrange
        let inputItems = Array(1...3).map(SFFilterFilteredItemMock.init)
        await container.initializeFilter()
        
        // Act
        container.selectedItems.removeAll()
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
        XCTAssertTrue(container.isFilterActive)
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
        XCTAssertTrue(container.isFilterActive)
    }
    
    // MARK: - isItemSelected Tests

    func testIsItemSelected_WhenItemIsInSelectedItems_ShouldReturnTrue() async {
        // Arrange
        await container.initializeFilter()
        let firstItem = container.allItems.first!
        
        // Act
        let result = container.isItemSelected(firstItem)
        
        // Assert
        XCTAssertTrue(result)
    }

    func testIsItemSelected_WhenItemIsNotInSelectedItems_ShouldReturnFalse() async {
        // Arrange
        await container.initializeFilter()
        let nonExistentItem = SFFilterCriteriaItemMock(id: 999)
        
        // Act
        let result = container.isItemSelected(nonExistentItem)
        
        // Assert
        XCTAssertFalse(result)
    }

    func testIsItemSelected_WhenSelectedItemsIsEmpty_ShouldReturnFalse() async {
        // Arrange
        await container.initializeFilter()
        container.selectedItems.removeAll()
        let anyItem = container.allItems.first!
        
        // Act
        let result = container.isItemSelected(anyItem)
        
        // Assert
        XCTAssertFalse(result)
    }

    func testIsItemSelected_WhenItemWasDeselected_ShouldReturnFalse() async {
        // Arrange
        await container.initializeFilter()
        let itemToDeselect = container.allItems.first!
        container.selectedItems.removeAll { $0 == itemToDeselect }
        
        // Act
        let result = container.isItemSelected(itemToDeselect)
        
        // Assert
        XCTAssertFalse(result)
    }

    func testIsItemSelected_WhenItemWasAddedToSelection_ShouldReturnTrue() async {
        // Arrange
        await container.initializeFilter()
        let newItem = SFFilterCriteriaItemMock(id: 100)
        container.allItems.append(newItem)
        container.selectedItems.append(newItem)
        
        // Act
        let result = container.isItemSelected(newItem)
        
        // Assert
        XCTAssertTrue(result)
    }

    func testIsItemSelected_WithDuplicateItemsInSelection_ShouldReturnTrue() async {
        // Arrange
        await container.initializeFilter()
        let duplicateItem = container.allItems.first!
        container.selectedItems.append(duplicateItem) // Add duplicate
        
        // Act
        let result = container.isItemSelected(duplicateItem)
        
        // Assert
        XCTAssertTrue(result)
    }

    func testIsItemSelected_WhenItemIsLastInSelection_ShouldReturnTrue() async {
        // Arrange
        await container.initializeFilter()
        let lastItem = container.allItems.last!
        
        // Act
        let result = container.isItemSelected(lastItem)
        
        // Assert
        XCTAssertTrue(result)
    }

    func testIsItemSelected_WhenItemIsMiddleInSelection_ShouldReturnTrue() async {
        // Arrange
        await container.initializeFilter()
        let middleIndex = container.allItems.count / 2
        let middleItem = container.allItems[middleIndex]
        
        // Act
        let result = container.isItemSelected(middleItem)
        
        // Assert
        XCTAssertTrue(result)
    }

    func testIsItemSelected_BeforeInitialization_ShouldReturnFalse() {
        // Arrange
        let anyItem = SFFilterCriteriaItemMock(id: 1)
        
        // Act
        let result = container.isItemSelected(anyItem)
        
        // Assert
        XCTAssertFalse(result)
    }

    func testIsItemSelected_WithNilItem_ShouldReturnFalse() async {
        // Arrange
        await container.initializeFilter()
        
        // Act
        let result = container.isItemSelected(SFFilterCriteriaItemMock(id: -1))
        
        // Assert
        XCTAssertFalse(result)
    }

    func testIsItemSelected_AfterResettingSelection_ShouldReturnFalseForAll() async {
        // Arrange
        await container.initializeFilter()
        container.selectedItems.removeAll()
        
        // Act & Assert
        for item in container.allItems {
            XCTAssertFalse(container.isItemSelected(item))
        }
    }

    func testIsItemSelected_AfterSelectingAll_ShouldReturnTrueForAll() async {
        // Arrange
        await container.initializeFilter()
        container.selectedItems.removeAll()
        container.selectedItems = container.allItems
        
        // Act & Assert
        for item in container.allItems {
            XCTAssertTrue(container.isItemSelected(item))
        }
    }
}
