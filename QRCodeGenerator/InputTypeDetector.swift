import Foundation

enum InputType {
    case numeric
    case alphaNumeric
    case byte
    case kanji
}

class InputTypeDetector {
    
    func detectInputType(input: String) -> InputType {
        
        return InputType.numeric
    }
}
