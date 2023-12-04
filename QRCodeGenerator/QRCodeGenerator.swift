import Foundation

class QRCodeGenerator {

    func loadQRCodeVersionTable(version: String, errorCorrection: ErrorCorrectionLevelPercentage) ->  QRCodeDataCapacity {
        let qrCodeVersionCapacity = QRCodeDataCapacity(numeric: 0, alphanumeric: 0, byte: 0, kanji: 0)
        return qrCodeVersionCapacity
    }
}
