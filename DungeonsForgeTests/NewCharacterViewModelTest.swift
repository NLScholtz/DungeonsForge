//
//  NewCharacterViewModelTest.swift
//  DungeonsForgeTests
//
//  Created by Nicole Scholtz on 2023/05/02.
//

@testable import DungeonsForge
import XCTest

final class NewCharacterViewModelTest: XCTestCase {
    
    var viewModelToTest: NewCharacterScreenViewModel?

    override func setUpWithError() throws {
        viewModelToTest = NewCharacterScreenViewModel(delegate: self, appNetworkController: AppNetworkStore())
    }

    override func tearDownWithError() throws {}

    func testNewlyCreatedCharacter() throws {
        viewModelToTest?.createNewCharacterFirst(characterName: "Selda", characterRace: "Dwarf", characterClass: "Wizard", characterBackground: "Acolyte")
        XCTAssertTrue(viewModelToTest?.characterSheet.characterName == "Selda", "Character name is incorrect")
        XCTAssertTrue(viewModelToTest?.characterSheet.characterRace == "Dwarf", "Character race is incorrect")
        XCTAssertTrue(viewModelToTest?.characterSheet.characterClass == "Wizard", "Character class is incorrect")
        XCTAssertTrue(viewModelToTest?.characterSheet.characterBackground == "Acolyte", "Character background is incorrect")
    }
    
    func testUpdatedCharacter() throws {
        viewModelToTest?.updateCharacter(character: CharacterModel(), characterName: "Selda", characterRace: "Dwarf", characterClass: "Wizard", characterBackground: "Acolyte")
        XCTAssertTrue(viewModelToTest?.characterSheet.characterName == "Selda", "Character name is incorrect")
        XCTAssertTrue(viewModelToTest?.characterSheet.characterRace == "Dwarf", "Character race is incorrect")
        XCTAssertTrue(viewModelToTest?.characterSheet.characterClass == "Wizard", "Character class is incorrect")
        XCTAssertTrue(viewModelToTest?.characterSheet.characterBackground == "Acolyte", "Character background is incorrect")
    }
    
    func testCallRaceAPI() {
        class MockDelegate: NewCharacterScreenViewModelDelegate {
            func racesReceived(races: [String]) {
                XCTAssertTrue(races.count == 2, "Races are incorrect")
            }
            
            func classesReceived(classes: [String]) {
                XCTAssertTrue(false, "Should not hit this delegate method")
            }
        }
        
        class MockNetworkController : AppNetwordStorable {
            func makeRequest<Generic>(url: URL?, model: Generic.Type, completion: @escaping (Result<Generic, Error>) -> Void) where Generic : Decodable, Generic : Encodable {
                let response = "{\"results\": [{ \"name\": \"Dragonborn\" }, { \"name\": \"Tiefling\"}]}"
                let responseData = Data(response.utf8)
                do {
                    let result = try JSONDecoder().decode(model, from: responseData)
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        viewModelToTest = NewCharacterScreenViewModel(delegate: self, appNetworkController: MockNetworkController())
        viewModelToTest?.callRaceAPI()
    }
    
    func testCallClassAPI() {
        class MockDelegate: NewCharacterScreenViewModelDelegate {
            func racesReceived(races: [String]) {
                XCTAssertTrue(false, "Should not hit this delegate method")
            }
            
            func classesReceived(classes: [String]) {
                XCTAssertTrue(classes.count == 2, "Classes are incorrect")
            }
        }
        
        class MockNetworkController : AppNetwordStorable {
            func makeRequest<Generic>(url: URL?, model: Generic.Type, completion: @escaping (Result<Generic, Error>) -> Void) where Generic : Decodable, Generic : Encodable {
                let response = "{\"results\": [{ \"name\": \"Paladin\" }, { \"name\": \"Barbarian\"}]}"
                let responseData = Data(response.utf8)
                do{
                    let result = try JSONDecoder().decode(model, from: responseData)
                    completion(.success(result))
                }catch{
                    completion(.failure(error))
                }
            }
        }
        viewModelToTest = NewCharacterScreenViewModel(delegate: self, appNetworkController: MockNetworkController())
        viewModelToTest?.callClassAPI()
    }
}

extension NewCharacterViewModelTest: NewCharacterScreenViewModelDelegate {
    func racesReceived(races: [String]) {}
    
    func classesReceived(classes: [String]) {}
}

