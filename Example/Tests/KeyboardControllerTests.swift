import UIKit
import XCTest
import KeyboardController

class KeyboardControllerTests: XCTestCase {
    var sut: KeyboardController!
    
    override func setUp() {
        super.setUp()
    }
    
    func test_init() {
        let mockTextField = UITextField()
        
        self.sut = KeyboardController(field: mockTextField)
        
        XCTAssertTrue(mockTextField.delegate === self.sut)
    }
    
}

class MockTextField: UITextField {
    
}