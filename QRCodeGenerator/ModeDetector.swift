import Foundation

final class ModeDetector {

    enum Mode: String {
        case numeric
        case alphaNumeric
        case byte
        case kanji
        case unknown

        var properties: (modeIndicator: String, characterCountIndicator: Int) {
            switch self {
                case .numeric: return ("0001", 10)
                case .alphaNumeric: return ("0010", 9)
                case .byte: return ("0100", 8)
                case .kanji: return ("1000", 8)
                case .unknown: return ("-1", -1)
            }
        }
    }

    func detect(input: String) -> Mode {
        switch true {
            case isNumeric(input): return .numeric
            case isAlphaNumeric(input): return .alphaNumeric
            case isByte(input): return .byte
            case isKanji(input): return .kanji
            default: return .unknown
        }
    }

    private func isAlphaNumeric(_ input: String) -> Bool {
        return input.unicodeScalars.allSatisfy { AlphanumericTable.values.keys.contains(String($0)) }
    }

    private func isByte(_ input: String) -> Bool {
        return input.data(using: .isoLatin1)
            .flatMap { String(data: $0, encoding: .isoLatin1) }
            .map { $0 == input } ?? false
    }

    private func isNumeric(_ input: String) -> Bool {
        return Int(input) != nil
    }

    private func isKanji(_ input: String) -> Bool {
        return input.unicodeScalars.allSatisfy { character in
            return (0x4E00...0x9FA5 ~= character.value)
        }
    }
}
