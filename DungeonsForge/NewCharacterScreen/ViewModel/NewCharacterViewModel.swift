//
//  NewCharacterViewModel.swift
//  DungeonsForge
//
//  Created by Nicole Scholtz on 2023/05/02.
//

import Foundation

protocol NewCharacterScreenViewModelDelegate: AnyObject {
    func racesReceived(races: [String])
    func classesReceived(classes: [String])
}

class NewCharacterScreenViewModel {
    
    var characterSheet = CharacterModel()
    private var raceResponses: RaceResponse?
    private var classResponses: ClassResponse?
    private weak var delegate : NewCharacterScreenViewModelDelegate?
    private var appNetworkController: AppNetwordStorable
    
    init(delegate: NewCharacterScreenViewModelDelegate, appNetworkController: AppNetwordStorable) {
        self.delegate = delegate
        self.appNetworkController = appNetworkController
        callRaceAPI()
        callClassAPI()
    }
    
    func createNewCharacterFirst(characterName: String, characterRace: String, characterClass: String, characterBackground: String) {
        characterSheet = CharacterModel()
        characterSheet.characterName = characterName
        characterSheet.characterRace = characterRace
        characterSheet.characterClass = characterClass
        characterSheet.characterBackground = characterBackground
    }
    
    func updateCharacter(character: CharacterModel, characterName: String, characterRace: String, characterClass: String, characterBackground: String) {
        characterSheet = character
        characterSheet.characterName = characterName
        characterSheet.characterRace = characterRace
        characterSheet.characterClass = characterClass
        characterSheet.characterBackground = characterBackground
    }
    
    func callRaceAPI() {
        appNetworkController.makeRequest(url: Constants.dndRaceURL, model: RaceResponse.self) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let raceArray):
                    self.raceResponses = raceArray
                    let raceActions = raceArray.results.map( {race in
                        return race.name
                    })
                    self.delegate?.racesReceived(races: raceActions)
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
        
        func callClassAPI() {
            appNetworkController.makeRequest(url: Constants.dndClassURL, model: ClassResponse.self) { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let classArray):
                        self.classResponses = classArray
                        let classActions = classArray.results.map( {classes in
                            return classes.name
                        })
                        self.delegate?.classesReceived(classes: classActions)
                    case .failure(let error):
                        print(error)
                    }
                }
            }
        }
    }
