import XCTest
@testable import SwiftyFilters


final class SFFilterKeyWordsContainerTests: XCTestCase {
    
    // MARK: - Properties
    
    private var resolver: SFFilterResolverKeywordsStub!
    private var container: SFFilterKeyWordsContainer<SFFilterFilteredItemKeywordsMock, String>!
    
    // MARK: - Setup
    
    override func setUp() {
        super.setUp()
        resolver = SFFilterResolverKeywordsStub()
        container = SFFilterKeyWordsContainer(resolver: resolver)
    }
    
    override func tearDown() {
        resolver = nil
        container = nil
        super.tearDown()
    }
    
    // MARK: - Initial State Tests
    
    func testInitialization_DefaultValues() {
        // Assert
        XCTAssertFalse(container.isNoneIncluded)
        XCTAssertFalse(container.isNoneEnabled)
        XCTAssertEqual(container.isNoneEnabled, container.isNoneIncluded)
        XCTAssertTrue(container.keywordsModel.isEmpty)
        XCTAssertFalse(container.isFilterActive)
    }
    
    // MARK: - Filter Activity Tests
    
    func testFilterActivity_WhenKeywordAdded_FilterIsActive() {
        // Act
        container.keywordsModel.addKeyword("Comment")
        
        // Assert
        XCTAssertTrue(container.isFilterActive)
    }
    
    func testFilterActivity_WhenNoneIsNotIncludedAndNoneEnabledIsFalse_FilterIsInactive() {
        // Act
        container.isNoneEnabled = false
        
        // Assert
        XCTAssertFalse(container.isFilterActive)
    }
    
    func testFilterActivity_WhenNoneIsIncludedAndNoneEnabledIsFalse_FilterIsActive() {
        // Arrange
        let container = SFFilterKeyWordsContainer(resolver: resolver, isNoneIncluded: true)
        
        // Act
        container.isNoneEnabled = false
        
        // Assert
        XCTAssertTrue(container.isFilterActive)
    }
    
    func testFilterActivity_WhenKeywordAddedAndThenDeleted_FilterIsInactive() {
        // Act
        container.keywordsModel.addKeyword("Comment")
        container.keywordsModel.reset()
        
        // Assert
        XCTAssertFalse(container.isFilterActive)
    }
    
    func testFilterActivity_WhenNoneEnabledToggled_FilterIsInactive() {
        // Act
        container.isNoneEnabled = false
        container.isNoneEnabled = true
        
        // Assert
        XCTAssertFalse(container.isFilterActive)
    }
    
    // MARK: - Filtration Tests
    
    func testFiltration_WhenFilterActive_ReturnsFilteredItems() {
        // Arrange
        let inputItems = [SFFilterFilteredItemKeywordsMock(comment: "comment")]
        
        // Act
        container.keywordsModel.addKeyword("Mock")
        let filteredItems = container.filterItems(inputItems: inputItems)
        
        // Assert
        XCTAssertTrue(container.isFilterActive)
        XCTAssertEqual(filteredItems.count, 0)
    }
    
    func testFiltration_WhenFilterInactive_ReturnsAllItems() {
        // Arrange
        let inputItems = [SFFilterFilteredItemKeywordsMock(comment: "comment")]
        
        // Act
        let filteredItems = container.filterItems(inputItems: inputItems)
        
        // Assert
        XCTAssertEqual(filteredItems.count, 1)
    }
}
