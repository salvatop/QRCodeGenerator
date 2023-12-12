import Foundation

public enum ErrorCorrectionLevelPercentage: Int, Decodable {
    case low = 7
    case medium = 15
    case quartile = 25
    case high = 30
    case errorDetectionOnly = 0
}

struct QRCodeDataCapacity: Equatable, Codable {
    let numeric: Int
    let alphanumeric: Int
    let byte: Int
    let kanji: Int
}

struct QRCodeVersion: Decodable {
    let version: [String: [String: QRCodeDataCapacity] ]

    enum CodingKeys: String, CodingKey {
        case version = "qr_code_version"
    }
}

final class QRCodeDatasetMaker: ObservableObject {
    @Published var dataset: QRCodeVersion?

    init() {
        dataset = loadJson(filename: "QRCodeDataset")
    }

    func loadJson(filename: String) -> QRCodeVersion? {
        do {
            if let path = Bundle.main.path(forResource: filename, ofType: "json") {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                return try JSONDecoder().decode(QRCodeVersion.self, from: data)
            } else {
                print("Error: JSON file not found.")
                return nil
            }
        } catch {
            print("Error loading QR code data from JSON: \(error)")
            return nil
        }
    }
}
