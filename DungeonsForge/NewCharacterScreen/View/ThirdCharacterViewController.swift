//
//  ThirdCharacterViewController.swift
//  DungeonsForge
//
//  Created by Nicole Scholtz on 2023/05/02.
//

import UIKit

class ThirdCharacterViewController: BaseViewController {
    
    @IBOutlet weak var proficienciesText: UITextField!
    @IBOutlet weak var languageMenu: UIButton!
    @IBOutlet weak var equipmentMenu: UIButton!
    @IBOutlet weak var traitsMenu: UIButton!
    
    var characterSheet: CharacterModel?
    private lazy var viewModel = ThirdCharacterViewModel(delegate: self, appStorageController: AppDataStore(), appNetworkController: AppNetworkStore())
    
    private var optionMenu = UIMenu()
    private var languageActions: [UIAction]?
    private var equipmentActions: [UIAction]?
    private var traitsActions: [UIAction]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.blockInterface()
        viewModel.callLanguageAPI()
        viewModel.callEquipmentAPI()
        viewModel.callTraitAPI()
        viewModel.characterSheet = characterSheet
        if (characterSheet?.characterCreated == true) {
            self.proficienciesText.text = characterSheet?.characterProficiencies
            self.languageMenu.titleLabel?.text = characterSheet?.characterLanguage
            self.equipmentMenu.titleLabel?.text = characterSheet?.characterEquipment
            self.traitsMenu.titleLabel?.text = characterSheet?.characterTraits
        }
    }
    
    @IBAction func addCharacterAction(_ sender: UIButton) {
        viewModel.updateCharacterTraits(characterProficiencies: proficienciesText.text ?? "", characterLanguage: languageMenu.titleLabel?.text ?? "", characterEquipment: equipmentMenu.titleLabel?.text ?? "", characterTraits: traitsMenu.titleLabel?.text ?? "")
        
        guard let character = viewModel.characterSheet else {
            return
        }
        
        if character.characterCreated {
            viewModel.appStorageController.edit(characterSelected: character)
        } else {
            viewModel.appStorageController.store(character: character)
        }
        self.tabBarController?.selectedIndex = 3
        self.navigationController?.popToRootViewController(animated: true)
    }
}

extension ThirdCharacterViewController: ThirdCharacterViewModelDelegate {
    func languagesReceived(languages: [String]) {
        self.languageActions = languages.map( { characterLanguages in
            return UIAction(title: "\(characterLanguages)",attributes: [], state: .off) { action in print("\(characterLanguages)")}
        })
        guard let languageActionsList = self.languageActions else {
            return
        }
        self.optionMenu = UIMenu(title: "", children: languageActionsList)
        self.languageMenu.menu = self.optionMenu
        self.unblockInterface()
    }
    
    func equipmentReceived(equipment: [String]) {
        self.equipmentActions = equipment.map( { characterEquipment in
            return UIAction(title: "\(characterEquipment)",attributes: [], state: .off) { action in print("\(characterEquipment)")}
        })
        guard let equipmentActionsList = self.equipmentActions else {
            return
        }
        self.optionMenu = UIMenu(title: "", children: equipmentActionsList)
        self.equipmentMenu.menu = self.optionMenu
        self.unblockInterface()
    }
    
    func traitsReceived(traits: [String]) {
        self.traitsActions = traits.map( { characterTraits in
            return UIAction(title: "\(characterTraits)",attributes: [], state: .off) { action in print("\(characterTraits)")}
        })
        guard let traitsActionsList = self.traitsActions else {
            return
        }
        self.optionMenu = UIMenu(title: "", children: traitsActionsList)
        self.traitsMenu.menu = self.optionMenu
        self.unblockInterface()
    }
    

}
