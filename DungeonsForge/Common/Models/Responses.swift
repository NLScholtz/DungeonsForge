//
//  Responses.swift
//  DungeonsForge
//
//  Created by Nicole Scholtz on 2023/05/02.
//

import Foundation

struct RaceResponse: Codable {
    let results: [Results]
}

struct ClassResponse: Codable {
    let results: [Results]
}

struct Results: Codable {
    let name: String
}

struct BackgroundResponse: Codable {
    let starting_equipment: [StartingEquipment]
    let starting_equipment_options: [StartingEquipmentOptions]
}

struct ProficiencesResponse: Codable {
    let results: [Results]
}

struct LanguageResponse: Codable {
    let results: [Results]
}

struct StartingEquipment: Codable {
    let results: [Results]
}

struct StartingEquipmentOptions: Codable {
    let feature: Feature?
}

struct Feature: Codable {
    let name: String
    let desc: [String]
}

struct TraitsResponse: Codable {
    let results: [Results]
}
