//
//  CharacterResult.swift
//  RickAndMortyAPI
//
//  Created by Ecem Öztürk on 24.04.2023.
//

import Foundation

struct CharacterModel<T:Codable>: Codable {
    let info: T?
    let results: [Character]?
}


struct Character: Codable, Identifiable {
    let id: Int?
    let name: String?
    let status: Status?
    let species: Species?
    let type: String?
    let gender: Gender?
    let origin, location: Location?
    let image: String?
    let episode: [String]?
    let url: String?
    let created: String?
}

// MARK: - Status
enum Status: String, Codable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"
}

// MARK: - Species
enum Species: String, Codable {
    case alien = "Alien"
    case animal = "Animal"
    case cronenberg = "Cronenberg"
    case disease = "Disease"
    case human = "Human"
    case humanoid = "Humanoid"
    case mythologicalCreature = "Mythological Creature"
    case poopybutthole = "Poopybutthole"
    case robot = "Robot"
    case unknown = "unknown"
}

// MARK: - Gender
enum Gender: String, Codable {
    case female = "Female"
    case male = "Male"
    case genderless = "Genderless"
    case unknown = "unknown"
}

// MARK: - Location

struct Location: Codable {
    let name: String?
    let url: String?
}

// MARK: - EpisodeNumber
struct EpisodeModel {
    let episodeNumber: String
}

extension EpisodeModel {
    init?(episodeURL: String) {
        guard let lastComponent = episodeURL.components(separatedBy: "/").last else {
            return nil
        }
        self.episodeNumber = lastComponent
    }
}
