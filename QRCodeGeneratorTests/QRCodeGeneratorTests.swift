import XCTest
@testable import QRCodeGenerator

final class QRCodeGeneratorTests: XCTestCase {
    var modeDetector: ModeDetector!

    override func setUpWithError() throws {
        modeDetector = ModeDetector()
    }

    override func tearDownWithError() throws {
        modeDetector = nil
    }

    func testNumericInputDetectionSuccess() {
        let input = "657595"
        let mode = modeDetector.detect(input: input)
        XCTAssertEqual(mode, .numeric)
    }

    func testNumericInputDetectionFailure() {
        let input = "pippo"
        let mode = modeDetector.detect(input: input)
        XCTAssertNotEqual(mode, .numeric)
    }

    func testByteInputDetectionSuccess() {
        let input = "e´"
        let mode = modeDetector.detect(input: input)
        XCTAssertEqual(mode, .byte)
    }

    func testByteInputDetectionFailure() {
        let input = "ラ"
        let mode = modeDetector.detect(input: input)
        XCTAssertNotEqual(mode, .byte)
    }

    func testAlphanumericInputDetectionSuccess() {
        let input = "PIPPO123"
        let mode = modeDetector.detect(input: input)
        XCTAssertEqual(mode, .alphaNumeric)
    }

    func testAlphanumericInputDetectionFailure() {
        let input = "@"
        let mode = modeDetector.detect(input: input)
        XCTAssertNotEqual(mode, .alphaNumeric)
    }

    func testKanjiInputDetectionSuccess() {
        let input = "漢字"
        let mode = modeDetector.detect(input: input)
        XCTAssertEqual(mode, .kanji)
    }

    func testKanjiInputDetectionFailure() {
        let input = "p"
        let mode = modeDetector.detect(input: input)
        XCTAssertNotEqual(mode, .kanji)
    }
}
