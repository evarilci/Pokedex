//
//  Pokemon.swift
//  PokeDex
//
//  Created by Eymen Varilci on 24.03.2023.
//
import Foundation

// MARK: - Pokemon

struct Pokemon: Codable {
    let count: Int?
    let next: String?
    let previous: String?
    let results: [Result]?
}

// MARK: - Result
struct Result: Codable {
    let name: String?
    let url: String?
}





// MARK: - Encode/decode helpers
//
//class JSONNull: Codable, Hashable {
//
//    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
//        return true
//    }
//
//    public var hashValue: Int {
//        return 0
//    }
//
//    public init() {}
//
//    public required init(from decoder: Decoder) throws {
//        let container = try decoder.singleValueContainer()
//        if !container.decodeNil() {
//            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
//        }
//    }
//
//    public func encode(to encoder: Encoder) throws {
//        var container = encoder.singleValueContainer()
//        try container.encodeNil()
//    }
//}
//@propertyWrapper public struct NilOnFail<T: Codable>: Codable {
//    
//    public let wrappedValue: T?
//    public init(from decoder: Decoder) throws {
//        wrappedValue = try? T(from: decoder)
//    }
//    public init(_ wrappedValue: T?) {
//        self.wrappedValue = wrappedValue
//    }
//}
