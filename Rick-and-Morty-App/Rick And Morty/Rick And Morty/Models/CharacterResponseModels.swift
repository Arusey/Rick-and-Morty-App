//
//  CharacterResponseModels.swift
//  Rick And Morty
//
//  Created by Kevin Lagat on 22/08/2024.
//

import Foundation
struct CharacterResponse: Codable {
    let results: [RMCharacter]
}

struct RMCharacter: Codable {
    let id: Int
    let name: String
    let species: String
    let image: String
    let status: String
    let gender: String
}
