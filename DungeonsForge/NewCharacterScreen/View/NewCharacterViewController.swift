//
//  NewCharacterViewController.swift
//  DungeonsForge
//
//  Created by Nicole Scholtz on 2023/05/02.
//

import UIKit

class NewCharacterViewController: BaseViewController {
    
    @IBOutlet weak var characterName: UITextField!
    @IBOutlet weak var raceMenu: UIButton!
    @IBOutlet weak var classMenu: UIButton!
    @IBOutlet weak var backgroundName: UITextField!
    
    private lazy var viewModel = NewCharacterScreenViewModel(delegate: self, appNetworkController: AppNetworkStore())
    
    var characterToEdit : CharacterModel?
    private var optionMenu = UIMenu()
    private var raceActions: [UIAction]?
    private var classActions: [UIAction]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        (UIApplication.shared.delegate as! AppDelegate).restrictRotation = .portrait
        self.blockInterface()
        viewModel.callClassAPI()
        viewModel.callRaceAPI()
        
        if (characterToEdit?.characterCreated == true) {
            guard let character = characterToEdit else { return }
            DispatchQueue.main.async {
                self.characterName.text = character.characterName
                self.raceMenu.titleLabel?.text = character.characterRace
                //self.raceMenu.setTitle(character.characterRace, for: .normal)
                self.classMenu.titleLabel?.text = character.characterClass
                self.backgroundName.text = character.characterBackground
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "secondaryCharacterSheet") {
            let characterSheet = viewModel.characterSheet
            let secondaryCharacterSheet = segue.destination as! SecondaryCharacterViewController
            secondaryCharacterSheet.characterSheet = characterSheet
        }
    }
    
    @IBAction func continueAction(_ sender: UIButton) {
        if let character = characterToEdit {
            viewModel.updateCharacter(character: character, characterName: characterName.text ?? "", characterRace: raceMenu.titleLabel?.text ?? "", characterClass: classMenu.titleLabel?.text ?? "", characterBackground: backgroundName.text ?? "")
        } else {
            viewModel.createNewCharacterFirst(characterName: characterName.text ?? "", characterRace: raceMenu.titleLabel?.text ?? "", characterClass: classMenu.titleLabel?.text ?? "", characterBackground: backgroundName.text ?? "")
        }
        self.performSegue(withIdentifier: "secondaryCharacterSheet", sender: self)
    }
}

extension NewCharacterViewController: NewCharacterScreenViewModelDelegate {
    func classesReceived(classes: [String]) {
        self.classActions = classes.map( { characterClass in
            return UIAction(title: "\(characterClass)", attributes: [], state: .off) { action in print("\(characterClass)")}
        })
        guard let classesActionsList = self.classActions else {
            return
        }
        self.optionMenu = UIMenu(title: "", children: classesActionsList)
        self.classMenu.menu = self.optionMenu
        self.unblockInterface()
    }
    
    func racesReceived(races: [String]) {
        self.raceActions = races.map( { characterRaces in
            return UIAction(title: "\(characterRaces)", attributes: [], state: .off) { action in print("\(characterRaces)")}
        })
        guard let raceActionsList = self.raceActions else {
            return
        }
        self.optionMenu = UIMenu(title: "", children: raceActionsList)
        self.raceMenu.menu = self.optionMenu
        self.unblockInterface()
        
    }
}


