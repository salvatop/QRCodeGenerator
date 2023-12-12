import XCTest
@testable import QRCodeGenerator

final class QRCodeDataEncoderTests: XCTestCase {

    func testQRCodeDataEncoder() {
        let string = "HELLO CC WORLD"
        let mode = "0010"
        let characterCount = "000001110"
        let data = "01100001011011110001101000101110001000101000110011101001000101001101110111110"

        let qrDataEncoder = QRCodeDataEncoder()
        let encodedString = qrDataEncoder.encode(stringToEncode: string)

        XCTAssertEqual(encodedString, mode + characterCount + data)
    }
}
