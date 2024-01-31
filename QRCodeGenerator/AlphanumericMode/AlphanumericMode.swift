final class AlphanumericMode {
    func encode(_ input: String) -> String {
        var encodedString = ""
        var lastPair = ""
        let characterSetSize = 45
        var pairs = splitStringIntoPairs(input: input)

        // If the input string has an odd length, process the final character separately
        if input.count % 2 != 0 {
            lastPair = computeLastPairTo6Bits(&pairs)
        }

        for pair in pairs {
            if let firstValue = pair.first,
               let first = AlphanumericTable.values[firstValue],
               let secondValue = pair.last,
               let second = AlphanumericTable.values[secondValue] {

                let conversionFormula = (first * characterSetSize) + second
                let binary = Helpers().decimalToBinary(conversionFormula)
                encodedString += binary.leftPadded(size: binary.count, newSize: 11, fill: "0")
            }
        }
        return encodedString + lastPair
    }

    private func computeLastPairTo6Bits(_ pairs: inout [String]) -> String {
        var lastPair = ""
        if let lastCharacter = pairs[pairs.count - 1].first,
           let value = AlphanumericTable.values[lastCharacter] {
            let binary = Helpers().decimalToBinary(value)
            lastPair += binary.leftPadded(size: binary.count, newSize: 6, fill: "0")
            pairs.removeLast()
        }
        return lastPair
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
