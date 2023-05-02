//
//  LandingViewModel.swift
//  DungeonsForge
//
//  Created by Nicole Scholtz on 2023/05/02.
//

import Foundation

protocol LandingViewModelDelegate: AnyObject {
    func charactersFetched()
}

class LandingViewModel {
    var characters = [CharacterModel]()
    private weak var delegate: LandingViewModelDelegate?
    var numberOfCharacters : Int { return characters.count }
    var selectedCharacter : CharacterModel?
    var appStorageController: AppDataStorable
    
    init(delegate: LandingViewModelDelegate, appStorageController: AppDataStorable) {
        self.delegate = delegate
        self.appStorageController = appStorageController
    }
    
    func fetchCharacters() {
        characters = appStorageController.characters
        delegate?.charactersFetched()
    }
    
    func characterName(at index : Int) -> String {
        return characters[index].characterName
    }
    
    func characterRace(at index : Int) -> String {
        return characters[index].characterRace
    }
    
    func selectCharacter(at index: Int) {
        return selectedCharacter = characters[index]
    }
}
