//
//  ThirdCharacterViewModelTest.swift
//  DungeonsForgeTests
//
//  Created by Nicole Scholtz on 2023/05/02.
//

@testable import DungeonsForge
import XCTest

final class ThirdCharacterViewModelTest: XCTestCase {
    
    var viewModelToTest: ThirdCharacterViewModel?

    override func setUpWithError() throws {
        class MockStorageController : AppDataStorable {
            
            init() {
                self.characters = []
            }
            
            var characters: [DungeonsForge.CharacterModel]
            
            func store(character: DungeonsForge.CharacterModel) {}
            
            func removeData() {}
            
            func remove(characterSelected: DungeonsForge.CharacterModel) {}
            
            func edit(characterSelected: DungeonsForge.CharacterModel) {
                self.characters.remove(at: 0)
                self.characters.append(characterSelected)
            }
        }
        
        class MockNetworkController : AppNetwordStorable {
            func makeRequest<Generic>(url: URL?, model: Generic.Type, completion: @escaping (Result<Generic, Error>) -> Void) where Generic : Decodable, Generic : Encodable {
                
            }
        }
        viewModelToTest = ThirdCharacterViewModel(delegate: self, appStorageController: MockStorageController(), appNetworkController: MockNetworkController())
        let character = CharacterModel(characterName: "Selda", characterRace: "Dwarf", characterClass: "Wizard", characterBackground: "Acolyte", characterAbilityStrength: "13", characterAbilityDexterity: "5", characterAbilityIntelligence: "19", characterAbilityConstitution: "25", characterAbilityWisdom: "23", characterAbilityCharisma: "2", characterProficiencies: "All armor", characterLanguage: "Dwarfish", characterEquipment: "Amulet", characterTraits: "Brave")
        viewModelToTest?.characterSheet = character
    }

    override func tearDownWithError() throws {}

    func testNewlyCreatedCharacter() throws {
        viewModelToTest?.updateCharacterTraits(characterProficiencies: "All armor", characterLanguage: "Dwarfish", characterEquipment: "Amulet", characterTraits: "Brave")
        XCTAssertTrue(viewModelToTest?.characterSheet?.characterProficiencies == "All armor", "Character proficiencies is incorrect")
        XCTAssertTrue(viewModelToTest?.characterSheet?.characterLanguage == "Dwarfish", "Character language is incorrect")
        XCTAssertTrue(viewModelToTest?.characterSheet?.characterEquipment == "Amulet", "Character equipment is incorrect")
        XCTAssertTrue(viewModelToTest?.characterSheet?.characterTraits == "Brave", "Character trait is incorrect")
    }
    
    func testCharacterStored() throws {
        XCTAssertTrue(viewModelToTest?.characterSheet != nil, "Character stored incorrect")
    }
    
    func testCharacterEdited() throws {
        viewModelToTest?.updateCharacterTraits(characterProficiencies: "No armor", characterLanguage: "Elfish", characterEquipment: "Stick", characterTraits: "Lucky")
        XCTAssertTrue(viewModelToTest?.characterSheet?.characterProficiencies == "No armor", "Character proficiencies is incorrect")
        XCTAssertTrue(viewModelToTest?.characterSheet?.characterLanguage == "Elfish", "Character language is incorrect")
        XCTAssertTrue(viewModelToTest?.characterSheet?.characterEquipment == "Stick", "Character equipment is incorrect")
        XCTAssertTrue(viewModelToTest?.characterSheet?.characterTraits == "Lucky", "Character trait is incorrect")
    }
    
    func testCallLanguageApi() throws {
        class MockDelegate: ThirdCharacterViewModelDelegate {
            func languagesReceived(languages: [String]) {
                XCTAssertTrue(languages.count == 2, "Languages are incorrect")
            }
            
            func equipmentReceived(equipment: [String]) {
                XCTAssertTrue(false, "Should not hit this delegate method")
            }
            
            func traitsReceived(traits: [String]) {
                XCTAssertTrue(false, "Should not hit this delegate method")
            }
        }
        
        class MockStorageController : AppDataStorable {
            
            init() {
                self.characters = []
            }
            
            var characters: [DungeonsForge.CharacterModel]
            
            func store(character: DungeonsForge.CharacterModel) {}
            
            func removeData() {}
            
            func remove(characterSelected: DungeonsForge.CharacterModel) {}
            
            func edit(characterSelected: DungeonsForge.CharacterModel) {}
        }
        
        class MockNetworkController : AppNetwordStorable {
            func makeRequest<Generic>(url: URL?, model: Generic.Type, completion: @escaping (Result<Generic, Error>) -> Void) where Generic : Decodable, Generic : Encodable {
                let response = "{\"results\": [{ \"name\": \"Abyssal\" }, { \"name\": \"Celestial\"}]}"
                let responseData = Data(response.utf8)
                do {
                    let result = try JSONDecoder().decode(model, from: responseData)
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        viewModelToTest = ThirdCharacterViewModel(delegate: self, appStorageController: MockStorageController(), appNetworkController: MockNetworkController())
        viewModelToTest?.callLanguageAPI()
    }
    
    func testCallEquipmentAPI() throws {
        class MockDelegate: ThirdCharacterViewModelDelegate {
            func languagesReceived(languages: [String]) {
                XCTAssertTrue(false, "Should not hit this delegate method")
            }
            
            func equipmentReceived(equipment: [String]) {
                XCTAssertTrue(equipment.count == 2, "Equipment are incorrect")
            }
            
            func traitsReceived(traits: [String]) {
                XCTAssertTrue(false, "Should not hit this delegate method")
            }
        }
        
        class MockStorageController : AppDataStorable {
            
            init() {
                self.characters = []
            }
            
            var characters: [DungeonsForge.CharacterModel]
            
            func store(character: DungeonsForge.CharacterModel) {}
            
            func removeData() {}
            
            func remove(characterSelected: DungeonsForge.CharacterModel) {}
            
            func edit(characterSelected: DungeonsForge.CharacterModel) {}
        }
        
        class MockNetworkController : AppNetwordStorable {
            func makeRequest<Generic>(url: URL?, model: Generic.Type, completion: @escaping (Result<Generic, Error>) -> Void) where Generic : Decodable, Generic : Encodable {
                let response = "{\"results\": [{ \"name\": \"Stick\" }, { \"name\": \"Amulet\"}]}"
                let responseData = Data(response.utf8)
                do{
                    let result = try JSONDecoder().decode(model, from: responseData)
                    completion(.success(result))
                }catch{
                    completion(.failure(error))
                }
            }
        }
        
        viewModelToTest = ThirdCharacterViewModel(delegate: self, appStorageController: MockStorageController(), appNetworkController: MockNetworkController())
        viewModelToTest?.callEquipmentAPI()
    }
    
    func testCallTraitAPI() throws {
        class MockDelegate: ThirdCharacterViewModelDelegate {
            func languagesReceived(languages: [String]) {
                XCTAssertTrue(false, "Should not hit this delegate method")
            }
            
            func equipmentReceived(equipment: [String]) {
                XCTAssertTrue(false, "Should not hit this delegate method")
            }
            
            func traitsReceived(traits: [String]) {
                XCTAssertTrue(traits.count == 2, "Traits are incorrect")
            }
        }
        
        class MockStorageController : AppDataStorable {
            
            init() {
                self.characters = []
            }
            
            var characters: [DungeonsForge.CharacterModel]
            
            func store(character: DungeonsForge.CharacterModel) {}
            
            func removeData() {}
            
            func remove(characterSelected: DungeonsForge.CharacterModel) {}
            
            func edit(characterSelected: DungeonsForge.CharacterModel) {}
        }
        
        class MockNetworkController : AppNetwordStorable {
            func makeRequest<Generic>(url: URL?, model: Generic.Type, completion: @escaping (Result<Generic, Error>) -> Void) where Generic : Decodable, Generic : Encodable {
                let response = "{\"results\": [{ \"name\": \"Brave\" }, { \"name\": \"Lucky\"}]}"
                let responseData = Data(response.utf8)
                do {
                    let result = try JSONDecoder().decode(model, from: responseData)
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        
        viewModelToTest = ThirdCharacterViewModel(delegate: self, appStorageController: MockStorageController(), appNetworkController: MockNetworkController())
        viewModelToTest?.callTraitAPI()
    }
}

extension ThirdCharacterViewModelTest: ThirdCharacterViewModelDelegate {
    func languagesReceived(languages: [String]) {}
    
    func equipmentReceived(equipment: [String]) {}
    
    func traitsReceived(traits: [String]) {}
}

