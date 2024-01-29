import XCTest
@testable import QRCodeGenerator

final class QRCodeDataEncoderTests: XCTestCase {

    func testQRCodeDataEncodingAlphanumericInput() {
        let mode = "0010"

        let oddString = "HELLO WORLD"
        let oddCharacterCount = "000001011"
        let oddData = "0110000101101111000110100010111001011011100010011010100001101"
        let encodedOddString = QRCodeDataEncoder().encode(oddString)
        XCTAssertEqual(mode + oddCharacterCount + oddData, encodedOddString)

        let string = "HELLO CC WORLD"
        let characterCount = "000001110"
        let data = "01100001011011110001101000101110001000101000110011101001000101001101110111110"
        let encodedString = QRCodeDataEncoder().encode(string)
        XCTAssertEqual(mode + characterCount + data, encodedString)
    }

    func testSplitStringIntoPairs() {
        let alphanumericEncoder = AlphanumericMode()
        let string = "HELLLO CC WORLD"
        let pairs = alphanumericEncoder.splitStringIntoPairs(input: string)
        XCTAssertTrue(pairs.count == 8)
    }
}
