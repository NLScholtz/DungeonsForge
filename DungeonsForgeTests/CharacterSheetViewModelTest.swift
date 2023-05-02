//
//  CharacterSheetViewModelTest.swift
//  DungeonsForgeTests
//
//  Created by Nicole Scholtz on 2023/05/02.
//

@testable import DungeonsForge
import XCTest

final class CharacterSheetViewModelTest: XCTestCase {

    var viewModelToTest: CharacterSheetViewModel?

    override func setUpWithError() throws {
        
        class MockStorageController : AppDataStorable {
            
            init() {
                self.characters = [CharacterModel(characterName: "Selda", characterRace: "Dwarf", characterClass: "Wizard", characterBackground: "Acolyte", characterAbilityStrength: "13", characterAbilityDexterity: "5", characterAbilityIntelligence: "19", characterAbilityConstitution: "25", characterAbilityWisdom: "23", characterAbilityCharisma: "2", characterProficiencies: "All armor", characterLanguage: "Dwarfish", characterEquipment: "Amulet", characterTraits: "Brave")]
            }
            
            var characters: [DungeonsForge.CharacterModel]
            
            func store(character: DungeonsForge.CharacterModel) {}
            
            func removeData() {}
            
            func remove(characterSelected: DungeonsForge.CharacterModel) {
                self.characters = []
            }
            
            func edit(characterSelected: DungeonsForge.CharacterModel) {}
        }
            viewModelToTest = CharacterSheetViewModel(delegate: self, appStorageController: MockStorageController(), character: CharacterModel())
    }

    override func tearDownWithError() throws {}

    func testCreatedCharacter() throws {
        viewModelToTest?.displayCharacterDetails(characterName: "Selda", characterRace: "Dwarf", characterClass: "Wizard", characterBackground: "Acolyte", characterProficiencies: "All armor", characterEquipment: "Amulet", characterLanguage: "Dwarfish", characterTraits: "Brave")
        viewModelToTest?.displayCharacterAbilityScores(characterStrength: "13", characterDexterity: "5", characterIntelligence: "19", characterConsitution: "25", characterWisdom: "23", characterCharisma: "2")
        XCTAssertTrue(viewModelToTest?.character?.characterName == "Selda", "Character name is incorrect")
        XCTAssertTrue(viewModelToTest?.character?.characterRace == "Dwarf", "Character race is incorrect")
        XCTAssertTrue(viewModelToTest?.character?.characterClass == "Wizard", "Character class is incorrect")
        XCTAssertTrue(viewModelToTest?.character?.characterBackground == "Acolyte", "Character background is incorrect")
        XCTAssertTrue(viewModelToTest?.character?.characterAbilityStrength == "13", "Character strength ability is incorrect")
        XCTAssertTrue(viewModelToTest?.character?.characterAbilityDexterity == "5", "Character dexterity ability is incorrect")
        XCTAssertTrue(viewModelToTest?.character?.characterAbilityIntelligence == "19", "Character intelligence ability is incorrect")
        XCTAssertTrue(viewModelToTest?.character?.characterAbilityConstitution == "25", "Character constitution ability is incorrect")
        XCTAssertTrue(viewModelToTest?.character?.characterAbilityWisdom == "23", "Character wisdom ability is incorrect")
        XCTAssertTrue(viewModelToTest?.character?.characterAbilityCharisma == "2", "Character charisma ability is incorrect")
        XCTAssertTrue(viewModelToTest?.character?.characterProficiencies == "All armor", "Character proficiencies is incorrect")
        XCTAssertTrue(viewModelToTest?.character?.characterLanguage == "Dwarfish", "Character language is incorrect")
        XCTAssertTrue(viewModelToTest?.character?.characterEquipment == "Amulet", "Character equipment is incorrect")
        XCTAssertTrue(viewModelToTest?.character?.characterTraits == "Brave", "Character traits is incorrect")
    }
    
    func testCharacterRemoval() throws {
        viewModelToTest?.removeCharacter()
        XCTAssertTrue(viewModelToTest?.character == nil, "Character not removed")
    }
    
    func testCharacterRemovalDelegate() throws {
        class MockDelegate: CharacterSheetViewDelegate {
            func characterRemoved() {
                XCTAssertTrue(true, "Delegate is incorrect")
            }
        }
        
        class MockStorageController : AppDataStorable {
            
            init() {
                self.characters = [CharacterModel(characterName: "Selda", characterRace: "Dwarf", characterClass: "Wizard", characterBackground: "Acolyte", characterAbilityStrength: "13", characterAbilityDexterity: "5", characterAbilityIntelligence: "19", characterAbilityConstitution: "25", characterAbilityWisdom: "23", characterAbilityCharisma: "2", characterProficiencies: "All armor", characterLanguage: "Dwarfish", characterEquipment: "Amulet", characterTraits: "Brave")]
            }
            
            var characters: [DungeonsForge.CharacterModel]
            
            func store(character: DungeonsForge.CharacterModel) {}
            
            func removeData() {}
            
            func remove(characterSelected: DungeonsForge.CharacterModel) {
                self.characters = []
            }
            
            func edit(characterSelected: DungeonsForge.CharacterModel) {}
        }
        let viewModel = CharacterSheetViewModel(delegate: MockDelegate(), appStorageController: MockStorageController(), character: CharacterModel())
        viewModel.removeCharacter()
    }
}

extension CharacterSheetViewModelTest: CharacterSheetViewDelegate {
    func characterRemoved() {
    }
}

