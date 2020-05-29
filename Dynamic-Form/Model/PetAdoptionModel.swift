import Foundation

struct PetAdoptionModel: Decodable {
    let id: String?
    let name: String?
    let pages: [Pages]?
}

struct Pages: Decodable {
    let label: String?
    let sections: [Sections]?
}

struct Sections: Decodable {
    let label: String?
    let elements: [Elements]?
}

struct Elements: Decodable {
    let type: String?
    let file: String?
    let mode: String?
    let label: String?
    let keyboard: String?
    let formattedNumeric: String?
    let isMandatory: Bool?
    let unique_id: String?
    let rules: [Rules]?
}

struct Rules: Decodable {
    let condition: String?
    let value: String?
    let action: String?
    let otherwise: String?
    let targets: [String]?
}
