import Foundation

enum InputType {
    case numeric
    case alphaNumeric
    case byte
    case kanji
    case unknown
}

class InputTypeDetector {

    func detectInputType(input: String) -> InputType {
        // swiftlint:disable switch_case_alignment
        switch true {
            case isNumeric(input: input): return .numeric
            case isAlphanumeric(input: input): return .alphaNumeric
            case isByte(input: input): return .byte
            case isKanji(input: input): return .kanji
            default: return .unknown
        }
        // swiftlint:enable switch_case_alignment
    }

    private func isAlphanumeric(input: String) -> Bool {
        let allowedCharacterSet = CharacterSet(charactersIn:
                                            "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwyz$%*+-./: ")
        return input.unicodeScalars.allSatisfy { allowedCharacterSet.contains($0) }
    }

    private func isByte(input: String) -> Bool {
        return input.data(using: .isoLatin1)
            .flatMap { String(data: $0, encoding: .isoLatin1) }
            .map { $0 == input } ?? false
    }

    private func isNumeric(input: String) -> Bool {
        return Int(input) != nil
    }

    private func isKanji(input: String) -> Bool {
        return input.unicodeScalars.allSatisfy { character in
            return (0x4E00...0x9FA5 ~= character.value)
        }
    }
}
