//
//  SecondaryViewModel.swift
//  DungeonsForge
//
//  Created by Nicole Scholtz on 2023/05/02.
//

import Foundation

class SecondaryCharacterViewModel {
    
    var characterSheet: CharacterModel?
    
    func updateCharacterAbilityScores(characterAbilityStrenght: String, characterAbilityDexterity: String, characterAbilityIntelligence: String, characterAbilityConstitution: String, characterAbilityWisdom: String, characterAbilityCharisma: String) {
        characterSheet?.characterAbilityStrength = characterAbilityStrenght
        characterSheet?.characterAbilityDexterity = characterAbilityDexterity
        characterSheet?.characterAbilityIntelligence = characterAbilityIntelligence
        characterSheet?.characterAbilityConstitution = characterAbilityConstitution
        characterSheet?.characterAbilityWisdom = characterAbilityWisdom
        characterSheet?.characterAbilityCharisma = characterAbilityCharisma
    }
}
