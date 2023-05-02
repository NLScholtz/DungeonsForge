//
//  LandingViewModelTest.swift
//  DungeonsForgeTests
//
//  Created by Nicole Scholtz on 2023/05/02.
//

@testable import DungeonsForge
import XCTest

final class LandingViewModelTest: XCTestCase {
    
    var viewModelToTest: LandingViewModel?

    override func setUpWithError() throws {
        
        class MockStorageController : AppDataStorable {
            
            init() {
                self.characters = [CharacterModel(characterName: "Selda", characterRace: "Dwarf", characterClass: "Wizard", characterBackground: "Acolyte", characterAbilityStrength: "13", characterAbilityDexterity: "5", characterAbilityIntelligence: "19", characterAbilityConstitution: "25", characterAbilityWisdom: "23", characterAbilityCharisma: "2", characterProficiencies: "All armor", characterLanguage: "Dwarfish", characterEquipment: "Amulet", characterTraits: "Brave"),
                                   CharacterModel(characterName: "Delgato", characterRace: "Dragonborn", characterClass: "Wizard", characterBackground: "Acolyte", characterAbilityStrength: "12", characterAbilityDexterity: "23", characterAbilityIntelligence: "18", characterAbilityConstitution: "20", characterAbilityWisdom: "13", characterAbilityCharisma: "1", characterProficiencies: "All armor", characterLanguage: "Dwarfish", characterEquipment: "Blade", characterTraits: "Charming")]
            }
            
            var characters: [DungeonsForge.CharacterModel]
            
            func store(character: DungeonsForge.CharacterModel) {}
            
            func removeData() {
                self.characters = []
            }
            
            func remove(characterSelected: DungeonsForge.CharacterModel) {}
            
            func edit(characterSelected: DungeonsForge.CharacterModel) {}
        }
        
        viewModelToTest = LandingViewModel(delegate: self, appStorageController: MockStorageController())
        viewModelToTest?.fetchCharacters()
    }

    override func tearDownWithError() throws {}

    func testNumberOfCharacters() throws {
        XCTAssertTrue(viewModelToTest?.numberOfCharacters == 2, "Number of characters is incorrect")
    }
    
    func testNameOfCharacters() throws {
        XCTAssertTrue(viewModelToTest?.characterName(at: 0) == "Selda", "Character name is incorrect")
        XCTAssertTrue(viewModelToTest?.characterName(at: 1) == "Delgato", "Character name is incorrect")
    }
    
    func testRaceOfCharacter() throws {
        XCTAssertTrue(viewModelToTest?.characterRace(at: 0) == "Dwarf", "Character race is incorrect")
        XCTAssertTrue(viewModelToTest?.characterRace(at: 1) == "Dragonborn", "Character race is incorrect")
    }
    
    func testSelectedCharacter() throws {
        viewModelToTest?.selectCharacter(at: 1)
        XCTAssertTrue(viewModelToTest?.selectedCharacter?.characterName == viewModelToTest?.characters[1].characterName, "Character is not selected")
    }
    
    func testFetchedCharacters() throws {
        XCTAssertTrue(viewModelToTest?.numberOfCharacters == 2, "Number of characters is incorrect")
    }
}

extension LandingViewModelTest: LandingViewModelDelegate {
    func charactersFetched() {}
}
