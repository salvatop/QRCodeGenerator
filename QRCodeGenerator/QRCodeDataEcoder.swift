final class QRCodeDataEncoder {

    func encode(_ input: String) -> String {
        let mode = ModeDetector().detect(input: input)
        let modeIndicator = mode.properties.modeIndicator
        let characterCountIndicator = mode.properties.characterCountIndicator
        let binaryString = Helpers().decimalToBinary(input.count)
        let characterCount = binaryString.leftPadded(size: binaryString.count, newSize: characterCountIndicator, fill: "0")
        
        var encoded = ""
        switch mode {
            case .numeric: encoded = modeIndicator + characterCount + "call method to encode numeric mode"
            case .alphaNumeric: encoded = modeIndicator + characterCount + AlphanumericMode().encode(input)
            case .byte: encoded = modeIndicator + characterCount + "call method to encode byte mode"
            case .kanji: encoded = modeIndicator + characterCount + "call method to encode kanji mode"
            case .unknown: break
        }
        encoded = addTerminator(input: encoded, codewords: 80)
        return encoded
    }
    
    private func addTerminator(input: String, codewords: Int) -> String {
        let newSize = codewords * 8
        let size = input.count
        let difference = newSize - size
        
        switch difference {
        case 1...3:
            let terminator = String(repeating: "0", count: difference)
            return input + terminator
        case 4...newSize:
            let terminator = String(repeating: "0", count: 4)
            return input + terminator
        default: return input
        }
    }
    
    private func splitBitStringByOffset(_ bitString: String, offset: Int) -> [String] {
        var result: [String] = []
        var currentIndex = bitString.startIndex

        while currentIndex < bitString.endIndex {
            let endIndex = bitString.index(currentIndex, offsetBy: offset,
                                           limitedBy: bitString.endIndex) ?? bitString.endIndex
            let substring = String(bitString[currentIndex..<endIndex])
            result.append(substring)
            currentIndex = endIndex
        }
        return result
    }
    
    private func addAlternatePatternToString(input: String,
                                             substring1: String,
                                             substring2: String,
                                             desiredSize: Int) -> String {
        var result = ""
        var currentIndex = 0
        while result.count < desiredSize {
            result += currentIndex % 2 == 0 ? substring1 : substring2
            currentIndex += 1
        }
        return result
    }
}
