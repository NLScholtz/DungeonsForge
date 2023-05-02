//
//  AppDataStore.swift
//  DungeonsForge
//
//  Created by Nicole Scholtz on 2023/05/02.
//

import Foundation

protocol AppDataStorable {
    var characters: [CharacterModel] { get }
    func store(character: CharacterModel)
    func removeData()
    func remove(characterSelected: CharacterModel)
    func edit(characterSelected: CharacterModel)
}

class AppDataStore: AppDataStorable {
    private var characterStorageKey: String { "DnDCharacters" }
    
    var characters: [CharacterModel] {
        do {
            if let data = UserDefaults.standard.data(forKey: characterStorageKey) {
                let characters = try JSONDecoder().decode([CharacterModel].self, from: data)
                //print(characters)
                return characters
            }
        } catch let error {
            print("Error decoding: \(error)")
        }
        return [CharacterModel]()
    }
    
    func store(character: CharacterModel) {
        var characterList = characters
        characterList.insert(character, at: 0)
        do {
            let data = try JSONEncoder().encode(characterList)
            UserDefaults.standard.set(data, forKey: characterStorageKey)
        } catch let error {
            print("Error encoding: \(error)")
        }
        UserDefaults.standard.synchronize()
    }
    
    func removeData() {
        let defaults = UserDefaults.standard
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            defaults.removeObject(forKey: key)
        }
    }
    
    func remove(characterSelected: CharacterModel) {
        var characterList = characters
        characterList.removeAll { $0.characterID == characterSelected.characterID }
        do {
            let data = try JSONEncoder().encode(characterList)
            UserDefaults.standard.set(data, forKey: characterStorageKey)
        } catch let error {
            print("Error encoding: \(error)")
        }
        UserDefaults.standard.synchronize()
    }
    
    func edit(characterSelected: CharacterModel) {
        self.remove(characterSelected: characterSelected)
        self.store(character: characterSelected)
    }
}
