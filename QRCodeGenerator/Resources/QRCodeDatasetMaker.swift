import Foundation

public enum ErrorCorrectionLevelPercentage: Int, Decodable {
    case low = 7
    case medium = 15
    case quartile = 25
    case high = 30
    case errorDetectionOnly = 0
}

public enum ErrorCorrectionLevelSelector: String, Decodable {
    case low = "L"
    case medium = "M"
    case quartile = "Q"
    case high = "H"
    case errorDetectionOnly = "errorDetectionOnly"
}

struct QRCodeDataCapacity: Equatable, Codable {
    let numeric: Int
    let alphanumeric: Int
    let byte: Int
    let kanji: Int
}

struct QRCodeVersionDataset: Decodable {
    let version: [String: [String: QRCodeDataCapacity] ]

    enum CodingKeys: String, CodingKey {
        case version = "qr_code_version"
    }
}

final class QRCodeDatasetMaker: ObservableObject {
    @Published var dataset: QRCodeVersionDataset?

    init() {
        dataset = loadJson(filename: "QRCodeDataset")
    }

    func loadJson(filename: String) -> QRCodeVersionDataset? {
        do {
            if let path = Bundle.main.path(forResource: filename, ofType: "json") {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                return try JSONDecoder().decode(QRCodeVersionDataset.self, from: data)
            } else {
                print("Error: JSON file not found.")
                return nil
            }
        } catch {
            print("Error loading QR code data from JSON: \(error).")
            return nil
        }
    }
}
