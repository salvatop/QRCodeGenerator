import Foundation

extension String {
    func leftPadded(size: Int, newSize: Int, fill character: Character) -> String {
        return String(repeating: String(character), count: newSize - size) + self
    }
}
