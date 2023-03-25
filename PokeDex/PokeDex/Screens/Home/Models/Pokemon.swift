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
