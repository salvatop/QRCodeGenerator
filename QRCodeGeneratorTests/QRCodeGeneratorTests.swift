import XCTest
@testable import QRCodeGenerator

final class QRCodeGeneratorTests: XCTestCase {
    var inputTypeDetector: InputTypeDetector!
    
    override func setUpWithError() throws {
        inputTypeDetector = InputTypeDetector()
    }
    
    override func tearDownWithError() throws{
        inputTypeDetector = nil
    }
    
    func testNumericInputDetection() {
        var input = "657595"
        let inputType = inputTypeDetector.detectInputType(input: input)
        
        XCTAssertEqual(inputType, InputType.numeric)
    }
}
