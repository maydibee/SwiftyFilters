
import XCTest
@testable import SwiftyFilters


final class SFFilterKeywordsModelTests: XCTestCase {
    
    // MARK: - Properties
    
    private var keywordsModel: SFFilterKeywordsModel<String>!
    
    // MARK: - Setup
    
    override func setUp() {
        super.setUp()
        keywordsModel = SFFilterKeywordsModel()
    }
    
    override func tearDown() {
        keywordsModel = nil
        super.tearDown()
    }
    
    // MARK: - Tests
    
    func testInitialState_IsEmpty() {
        XCTAssertTrue(keywordsModel.isEmpty)
    }
    
    func testAddKeyword_ModelIsNotEmpty() {
        // Act
        keywordsModel.addKeyword("Comment")
        
        // Assert
        XCTAssertFalse(keywordsModel.isEmpty)
    }
    
    func testReset_ModelIsEmpty() {
        // Arrange
        keywordsModel.addKeyword("Comment")
        
        // Act
        keywordsModel.reset()
        
        // Assert
        XCTAssertTrue(keywordsModel.isEmpty)
    }
    
    func testIsSatisfy_WhenKeywordMatches_ReturnsTrue() {
        // Arrange
        keywordsModel.addKeyword("Comment")
        
        // Act & Assert
        XCTAssertTrue(keywordsModel.isSafisfy("This is a comment"))
    }
    
    func testIsSatisfy_WhenKeywordDoesNotMatch_ReturnsFalse() {
        // Arrange
        keywordsModel.addKeyword("Comment")
        
        // Act & Assert
        XCTAssertFalse(keywordsModel.isSafisfy("This is a post"))
    }
    
    func testIsSatisfy_WhenCaseSensitive_ReturnsFalse() {
        // Arrange
        keywordsModel.addKeyword("Comment")
        keywordsModel.isCaseSensitive = true
        
        // Act & Assert
        XCTAssertFalse(keywordsModel.isSafisfy("This is a comment"))
    }
}
