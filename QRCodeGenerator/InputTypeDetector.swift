import Foundation

final class InputTypeDetector {

    enum InputType {
        case numeric
        case alphaNumeric
        case byte
        case kanji
        case unknown
    }

    func detectInputType(input: String) -> InputType {
        switch true {
            case isNumeric(input: input): return .numeric
            case isAlphaNumeric(input: input): return .alphaNumeric
            case isByte(input: input): return .byte
            case isKanji(input: input): return .kanji
            default: return .unknown
        }
    }

    private func isAlphaNumeric(input: String) -> Bool {
        let aphabet = "abcdefghijklmnopqrstuvwyz"
        let numbers = "0123456789"
        let symbols = "$%*+-./: "
        let characterSet = CharacterSet(charactersIn: aphabet + aphabet.uppercased() + numbers + symbols)
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
