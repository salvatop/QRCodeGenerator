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
            case isInputNumeric(input: input): return InputType.numeric
            case isInputByte(input: input): return InputType.byte
            case isInputKanji(input: input): return InputType.kanji
            case isInputAlphanumeric(input: input): return InputType.alphaNumeric
            default: return InputType.unknown
        }
    }

    private func isInputByte(input: String) -> Bool {
        return input.canBeConverted(to: .isoLatin1)
    }

    private func isInputNumeric(input: String) -> Bool {
        return Double(input) != nil
    }

    private func isInputKanji(input: String) -> Bool {
        return input.canBeConverted(to: .japaneseEUC)
    }

    private func isInputAlphanumeric(input: String) -> Bool {
        let allowed = CharacterSet.alphanumerics
        //return CharacterSet.alphanumerics.contains(input.unicodeScalars)

        for char in input {
            if !char.isNumber && !char.isLetter {
                return false
            }
        }
        return true
    }
}
