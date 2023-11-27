import XCTest
@testable import QRCodeGenerator

final class InputTypeDetectorTests: XCTestCase {
    var inputTypeDetector: InputTypeDetector!

    override func setUpWithError() throws {
        inputTypeDetector = InputTypeDetector()
    }

    override func tearDownWithError() throws {
        inputTypeDetector = nil
    }

    func testNumericInputDetectionSuccess() {
        let input = "657595"
        let inputType = inputTypeDetector.detectInputType(input: input)
        XCTAssertEqual(inputType, InputType.numeric)
    }

    func testNumericInputDetectionFailure() {
        let input = "pippo"
        let inputType = inputTypeDetector.detectInputType(input: input)
        XCTAssertNotEqual(inputType, InputType.numeric)
    }

    func testByteInputDetectionSuccess() {
        let input = "e´"
        let inputType = inputTypeDetector.detectInputType(input: input)
        XCTAssertEqual(inputType, InputType.byte)
    }

    func testByteInputDetectionFailure() {
        let input = "ラ"
        let inputType = inputTypeDetector.detectInputType(input: input)
        XCTAssertNotEqual(inputType, InputType.byte)
    }

    func testAlphanumericInputDetectionSuccess() {
        let input = "pippo123"
        let inputType = inputTypeDetector.detectInputType(input: input)
        XCTAssertEqual(inputType, InputType.alphaNumeric)
    }

    func testAlphanumericInputDetectionFailure() {
        let input = "@"
        let inputType = inputTypeDetector.detectInputType(input: input)
        XCTAssertNotEqual(inputType, InputType.alphaNumeric)
    }

    func testKanjiInputDetectionSuccess() {
        let input = "漢字"
        let inputType = inputTypeDetector.detectInputType(input: input)
        XCTAssertEqual(inputType, InputType.kanji)
    }

    func testKanjiInputDetectionFailure() {
        let input = "p"
        let inputType = inputTypeDetector.detectInputType(input: input)
        XCTAssertNotEqual(inputType, InputType.kanji)
    }
}
