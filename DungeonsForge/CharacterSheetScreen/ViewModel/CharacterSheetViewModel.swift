//
//  CharacterSheetViewModel.swift
//  DungeonsForge
//
//  Created by Nicole Scholtz on 2023/05/02.
//

import Foundation

protocol CharacterSheetViewDelegate: AnyObject {
    func characterRemoved()
}

class CharacterSheetViewModel {
    
    var character: CharacterModel?
    var appStorageController: AppDataStorable
    private weak var delegate: CharacterSheetViewDelegate?
    
    
    init(delegate: CharacterSheetViewDelegate, appStorageController: AppDataStorable, character: CharacterModel) {
        self.delegate = delegate
        self.appStorageController = appStorageController
        self.character = character
    }
    
    func displayCharacterDetails(characterName: String, characterRace: String, characterClass: String, characterBackground: String, characterProficiencies: String, characterEquipment: String, characterLanguage: String, characterTraits: String) {
        character = CharacterModel()
        character?.characterName = characterName
        character?.characterRace = characterRace
        character?.characterClass = characterClass
        character?.characterBackground = characterBackground
        character?.characterProficiencies = characterProficiencies
        character?.characterEquipment = characterEquipment
        character?.characterLanguage = characterLanguage
        character?.characterTraits = characterTraits
    }
    
    func displayCharacterAbilityScores(characterStrength: String, characterDexterity: String, characterIntelligence: String, characterConsitution: String, characterWisdom: String, characterCharisma: String) {
        character?.characterAbilityStrength = characterStrength
        character?.characterAbilityDexterity = characterDexterity
        character?.characterAbilityIntelligence = characterIntelligence
        character?.characterAbilityConstitution = characterConsitution
        character?.characterAbilityWisdom = characterWisdom
        character?.characterAbilityCharisma = characterCharisma
    }
    
    func removeCharacter() {
        guard let characterSelected = character else { return }
        appStorageController.remove(characterSelected: characterSelected)
        character = nil
        delegate?.characterRemoved()
    }
}
