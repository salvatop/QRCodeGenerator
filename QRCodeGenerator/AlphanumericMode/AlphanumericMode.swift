final class AlphanumericMode {
    func encode(_ input: String) -> String {
        var encodedString = ""
        var lastPair = ""
        let characterSetSize = 45
        var pairs = splitStringIntoPairs(input: input)
        let helpers = Helpers()

        // If the input string has an odd length, process the final character separately
        if input.count % 2 != 0 {
            extractedFunc(&pairs, helpers, &lastPair)
        }

        for pair in pairs {
            if let firstValue = pair.first,
               let first = AlphanumericTable.values[firstValue],
               let secondValue = pair.last,
               let second = AlphanumericTable.values[secondValue] {

                let conversionFormula = (first * characterSetSize) + second
                let binary = helpers.decimalToBinary(conversionFormula)
                encodedString += binary.leftPadded(size: binary.count, newSize: 11, fill: "0")
            }
        }
        return encodedString + lastPair
    }

    private func extractedFunc(_ pairs: inout [String], _ helpers: Helpers, _ lastPair: inout String) {
        if let lastCharacter = pairs[pairs.count - 1].first,
           let value = AlphanumericTable.values[lastCharacter] {
            let binary = helpers.decimalToBinary(value)
            lastPair += binary.leftPadded(size: binary.count, newSize: 6, fill: "0")
            pairs.removeLast()
        }
    }

    func splitStringIntoPairs(input: String) -> [String] {
        var pairsList = [String]()
        for char in input {
            if let lastPair = pairsList.last, lastPair.count == 1 {
                pairsList[pairsList.count - 1] += String(char)
            } else {
                pairsList.append(String(char))
            }
        }
        return pairsList
    }
}
