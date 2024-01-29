final class QRCodeDataEncoder {

    func encode(_ input: String) -> String {
        let mode = ModeDetector().detect(input: input)
        let modeIndicator = mode.properties.modeIndicator
        let characterCountIndicator = mode.properties.characterCountIndicator
        let binaryString = Helpers().decimalToBinary(input.count)
        let characterCount = binaryString.leftPadded(size: binaryString.count, newSize: characterCountIndicator, fill: "0")

        switch mode {
            case .numeric: return modeIndicator + characterCount + "call method to encode numeric mode"
            case .alphaNumeric: return modeIndicator + characterCount + AlphanumericMode().encode(input)
            case .byte: return modeIndicator + characterCount + "call method to encode byte mode"
            case .kanji: return modeIndicator + characterCount + "call method to encode kanji mode"
            case .unknown: return ""
        }
    }
}
