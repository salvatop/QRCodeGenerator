import XCTest
@testable import QRCodeGenerator

final class QRCodeGeneratorTests: XCTestCase {
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
        XCTAssertEqual(inputType, .numeric)
    }

    func testNumericInputDetectionFailure() {
        let input = "pippo"
        let inputType = inputTypeDetector.detectInputType(input: input)
        XCTAssertNotEqual(inputType, .numeric)
    }

    func testByteInputDetectionSuccess() {
        let input = "e´"
        let inputType = inputTypeDetector.detectInputType(input: input)
        XCTAssertEqual(inputType, .byte)
    }

    func testByteInputDetectionFailure() {
        let input = "ラ"
        let inputType = inputTypeDetector.detectInputType(input: input)
        XCTAssertNotEqual(inputType, .byte)
    }

    func testAlphanumericInputDetectionSuccess() {
        let input = "pippo123"
        let inputType = inputTypeDetector.detectInputType(input: input)
        XCTAssertEqual(inputType, .alphaNumeric)
    }

    func testAlphanumericInputDetectionFailure() {
        let input = "@"
        let inputType = inputTypeDetector.detectInputType(input: input)
        XCTAssertNotEqual(inputType, .alphaNumeric)
    }

    func testKanjiInputDetectionSuccess() {
        let input = "漢字"
        let inputType = inputTypeDetector.detectInputType(input: input)
        XCTAssertEqual(inputType, .kanji)
    }

    func testKanjiInputDetectionFailure() {
        let input = "p"
        let inputType = inputTypeDetector.detectInputType(input: input)
        XCTAssertNotEqual(inputType, .kanji)
    }
}
