//
//  SecondaryCharacterViewModelTest.swift
//  DungeonsForgeTests
//
//  Created by Nicole Scholtz on 2023/05/02.
//

@testable import DungeonsForge
import XCTest

final class SecondaryCharacterViewModelTest: XCTestCase {
    
    var viewModelToTest: SecondaryCharacterViewModel?

    override func setUpWithError() throws {
        viewModelToTest = SecondaryCharacterViewModel()
        let character = CharacterModel(characterName: "Selda", characterRace: "Dwarf", characterClass: "Wizard", characterBackground: "Acolyte", characterAbilityStrength: "13", characterAbilityDexterity: "5", characterAbilityIntelligence: "19", characterAbilityConstitution: "25", characterAbilityWisdom: "23", characterAbilityCharisma: "2", characterProficiencies: "All armor", characterLanguage: "Dwarfish", characterEquipment: "Amulet", characterTraits: "Brave")
        viewModelToTest?.characterSheet = character
    }

    override func tearDownWithError() throws {}

    func testNewlyCreatedCharacter() throws {
        viewModelToTest?.updateCharacterAbilityScores(characterAbilityStrenght: "13", characterAbilityDexterity: "5", characterAbilityIntelligence: "19", characterAbilityConstitution: "25", characterAbilityWisdom: "23", characterAbilityCharisma: "2")
        XCTAssertTrue(viewModelToTest?.characterSheet?.characterAbilityStrength == "13", "Character strength ability is incorrect")
        XCTAssertTrue(viewModelToTest?.characterSheet?.characterAbilityDexterity == "5", "Character dexterity ability is incorrect")
        XCTAssertTrue(viewModelToTest?.characterSheet?.characterAbilityIntelligence == "19", "Character intelligence is incorrect")
        XCTAssertTrue(viewModelToTest?.characterSheet?.characterAbilityConstitution == "25", "Character constitution ability is incorrect")
        XCTAssertTrue(viewModelToTest?.characterSheet?.characterAbilityWisdom == "23", "Character wisdom ability is incorrect")
        XCTAssertTrue(viewModelToTest?.characterSheet?.characterAbilityCharisma == "2", "Character charisma ability is incorrect")
    }
}
