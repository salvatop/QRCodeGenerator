import Foundation

public enum InputTypeIndicators: Int {
    case numeric
    case alphanumeric
    case byte
    case kanji

    var properties: (characterCountIndicator: Int, modeIndicator: Int) {
        switch self {
            case .numeric: return (10, 1)
            case .alphanumeric: return (9, 2)
            case .byte, .kanji: return (8, 3)
        }
    }
}

final class QRCodeDataEncoder {

    func encode(stringToEncode: String) -> String {
        let modeIndicator = ModeDetector().detect(input: stringToEncode).properties.modeIndicator
        let stringToEncodeBinaryLenght = decimalToBinary(stringToEncode.count)
        let characterCountIndicator = ModeDetector().detect(input: stringToEncode).properties.characterCountIndicator

        return (modeIndicator
        + leftPadding(input: stringToEncodeBinaryLenght,characterCountIndicator: characterCountIndicator)
        + stringToBinary(stringToEncode))
    }

    private func decimalToBinary(_ decimal: Int) -> String {
        let binaryString = String(decimal, radix: 2)
        return binaryString
    }

    private func leftPadding(input: String, characterCountIndicator: Int) -> String {
        let numberOfZeros = characterCountIndicator - input.count
        let leftPad = String(repeating: "0", count: numberOfZeros)
        return leftPad + input
    }
    //TODO: to be reviewd
    private func stringToBinary(_ input: String) -> String {
        return input.utf8.map { String($0, radix: 2).padding(toLength: 8, withPad: "0", startingAt: 0) }.joined()
    }
}
