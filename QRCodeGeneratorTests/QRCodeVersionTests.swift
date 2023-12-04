import XCTest
@testable import QRCodeGenerator

final class QRCodeVersionTests: XCTestCase {

    func testQRCodeVersion4() {
        let errorCorrectionLevelPercentage: ErrorCorrectionLevelPercentage = .lowL
        let version = "4"
        let qrCodeGenerator = QRCodeGenerator()

        let qrCodeVersion4DataCapacity = qrCodeGenerator.loadQRCodeVersionTable(version: version, 
                                                                                errorCorrection: errorCorrectionLevelPercentage)
        let expectedDataCapacity = QRCodeDataCapacity(numeric: 187, alphanumeric: 114, byte: 78, kanji: 48)
        XCTAssertEqual(qrCodeVersion4DataCapacity, expectedDataCapacity)
    }
}
