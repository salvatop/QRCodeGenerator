final class QRCodeGenerator {

    func createQRCode(version: String, errorCorrection: ErrorCorrectionLevelSelector) -> QRCodeDataCapacity {
        var qrCodeCapacity = QRCodeDataCapacity(numeric: 0, alphanumeric: 0, byte: 0, kanji: 0)
        let qrCode = QRCodeDatasetMaker()
        let version = qrCode.dataset?.version[version]
        if let codeVersion = version?[errorCorrection.rawValue] {
            qrCodeCapacity = codeVersion
        }
        return qrCodeCapacity
    }
}
