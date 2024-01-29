import XCTest
@testable import QRCodeGenerator

final class QRCodeVersionTests: XCTestCase {

    func testQRCodeDatasetMaker() {
        let datasetMaker = QRCodeDatasetMaker()
        guard let qrCodeDataset = datasetMaker.loadJson(filename: "QRCodeDataset") else { return XCTFail("Failed to load JSON dataset") }
        XCTAssertNotNil(qrCodeDataset.version["4"])
    }

    func testCreateQRCodeVersion4() {
        let qrCodeGenerator = QRCodeGenerator()
        let qrCodeVersion4DataCapacity = qrCodeGenerator.createQRCode(version: "4", errorCorrection: .low)
        let expectedDataCapacity = QRCodeDataCapacity(codewords: 80, numeric: 187, alphanumeric: 114, byte: 78, kanji: 48)

        XCTAssertEqual(qrCodeVersion4DataCapacity, expectedDataCapacity)
    }
}
