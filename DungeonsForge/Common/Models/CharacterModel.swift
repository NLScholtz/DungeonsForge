//
//  CharacterModel.swift
//  DungeonsForge
//
//  Created by Nicole Scholtz on 2023/05/02.
//

import Foundation
import UIKit

struct CharacterModel: Codable {
    
//    TODO: NS - use correct types...not all String
    
    var characterName: String = ""
    var characterRace: String = ""
    var characterClass: String = ""
    var characterBackground: String = ""
    var characterAbilityStrength: String = ""
    var characterAbilityDexterity: String = ""
    var characterAbilityIntelligence: String = ""
    var characterAbilityConstitution: String = ""
    var characterAbilityWisdom: String = ""
    var characterAbilityCharisma: String = ""
    var characterProficiencies: String = ""
    var characterLanguage: String = ""
    var characterEquipment: String = ""
    var characterTraits: String = ""
    var characterID: String = ""
    var characterCreated: Bool = false
    //var characterRace: CharacterRace = CharacterRace(characterRace: "Dragonborn")
    //var characterAbilityStrenght: Int = 0
}

//struct CharacterRace: Codable {
//    var characterRace: String
//}
