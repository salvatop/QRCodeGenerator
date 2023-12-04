import Foundation

public enum ErrorCorrectionLevelPercentage: Int {
    case lowL = 7
    case mediumM = 15
    case quartileQ = 25
    case highH = 30
}

struct QRCodeDataCapacity: Equatable {
    var numeric: Int
    var alphanumeric: Int
    var byte: Int
    var kanji: Int
}

struct QRCodeVersion {
    let errorCorrectionLevelPercentage: ErrorCorrectionLevelPercentage
    let version: String
    let dataCapacity: QRCodeDataCapacity
}
