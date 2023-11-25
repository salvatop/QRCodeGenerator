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
        switch true {
            case isNumeric(input: input): return .numeric
            case isAlphanumeric(input: input): return .alphaNumeric
            case isByte(input: input): return .byte
            case isKanji(input: input): return .kanji
            default: return .unknown
        }
    }

    private func isAlphanumeric(input: String) -> Bool {
        let characters = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwyz$%*+-./: "
        let characterSet = CharacterSet(charactersIn: characters)
        return input.unicodeScalars.allSatisfy { characterSet.contains($0) }
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
