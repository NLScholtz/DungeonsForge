//
//  ThirdCharacterViewModel.swift
//  DungeonsForge
//
//  Created by Nicole Scholtz on 2023/05/02.
//

import Foundation

protocol ThirdCharacterViewModelDelegate: AnyObject {
    func languagesReceived(languages: [String])
    func equipmentReceived(equipment: [String])
    func traitsReceived(traits: [String])
}

class ThirdCharacterViewModel {
    
    var characterSheet: CharacterModel?
    private var languageResponses: LanguageResponse?
    private var startingEquipment: StartingEquipment?
    private var traitsResponses: TraitsResponse?
    private weak var delegate: ThirdCharacterViewModelDelegate?
    var appStorageController: AppDataStorable
    var appNetworkController: AppNetwordStorable
    
    
    init(delegate: ThirdCharacterViewModelDelegate, appStorageController: AppDataStorable, appNetworkController: AppNetwordStorable) {
        self.delegate = delegate
        self.appStorageController = appStorageController
        self.appNetworkController = appNetworkController
        callLanguageAPI()
        callEquipmentAPI()
        callTraitAPI()
    }
    
    func updateCharacterTraits(characterProficiencies: String, characterLanguage: String, characterEquipment: String, characterTraits: String) {
        //characterSheet = CharacterModel()
        characterSheet?.characterProficiencies = characterProficiencies
        characterSheet?.characterLanguage = characterLanguage
        characterSheet?.characterEquipment = characterEquipment
        characterSheet?.characterTraits = characterTraits
        if characterSheet?.characterCreated != true {
            characterSheet?.characterID = UUID().uuidString
            characterSheet?.characterCreated = true
        }
    }
    
    func callLanguageAPI() {
        appNetworkController.makeRequest(url: Constants.dndlanguagesURL, model: LanguageResponse.self) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let languageArray):
                    self.languageResponses = languageArray
                    let languageActions = languageArray.results.map( {languages in
                        return languages.name
                    })
                    self.delegate?.languagesReceived(languages: languageActions)
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    func callEquipmentAPI() {
        appNetworkController.makeRequest(url: Constants.dndequipmentURL, model: StartingEquipment.self) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let equipmentArray):
                    self.startingEquipment = equipmentArray
                    let equipmentActions = equipmentArray.results.map( {equipment in
                        return equipment.name
                    })
                    self.delegate?.equipmentReceived(equipment: equipmentActions)
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    func callTraitAPI() {
        appNetworkController.makeRequest(url: Constants.dndtraitURL, model: TraitsResponse.self) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let traitArray):
                    self.traitsResponses = traitArray
                    let traitActions = traitArray.results.map( {traits in
                        return traits.name
                    })
                    self.delegate?.traitsReceived(traits: traitActions)
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    func editCharacter() {
        guard let character = characterSheet else { return }
        appStorageController.edit(characterSelected: character)
    }
    
    func storedCharacters() {
        guard let character = characterSheet else { return }
        appStorageController.store(character: character)
    }
    
}
