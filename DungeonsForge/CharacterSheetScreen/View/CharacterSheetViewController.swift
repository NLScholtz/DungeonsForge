//
//  CharacterSheetViewController.swift
//  DungeonsForge
//
//  Created by Nicole Scholtz on 2023/05/02.
//

import UIKit

class CharacterSheetViewController: UIViewController {
    var character : CharacterModel?
    private lazy var viewModel = CharacterSheetViewModel(delegate: self, appStorageController: AppDataStore(), character: character!)
    
    @IBOutlet weak var characterName: UILabel!
    @IBOutlet weak var characterRace: UILabel!
    @IBOutlet weak var characterClass: UILabel!
    @IBOutlet weak var characterBackground: UILabel!
    @IBOutlet weak var characterProficiencies: UILabel!
    @IBOutlet weak var characterEquipment: UILabel!
    @IBOutlet weak var characterLanguage: UILabel!
    @IBOutlet weak var characterTrait: UILabel!
    @IBOutlet weak var characterImage: UIImageView!
    
    @IBOutlet weak var characterStrenght: UILabel!
    @IBOutlet weak var characterDexterity: UILabel!
    @IBOutlet weak var characterIntelligence: UILabel!
    @IBOutlet weak var characterConsitution: UILabel!
    @IBOutlet weak var characterWisdom: UILabel!
    @IBOutlet weak var characterCharisma: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        characterName.text = viewModel.character?.characterName
        characterRace.text = viewModel.character?.characterRace
        characterImage.image = UIImage(named: "\(characterRace.text ?? "Human")")
        characterClass.text = viewModel.character?.characterClass
        characterBackground.text = viewModel.character?.characterBackground
        characterProficiencies.text = viewModel.character?.characterProficiencies
        characterEquipment.text = viewModel.character?.characterEquipment
        characterLanguage.text = viewModel.character?.characterLanguage
        characterTrait.text = viewModel.character?.characterTraits
        
        characterStrenght.text = viewModel.character?.characterAbilityStrength
        characterDexterity.text = viewModel.character?.characterAbilityDexterity
        characterIntelligence.text = viewModel.character?.characterAbilityIntelligence
        characterConsitution.text = viewModel.character?.characterAbilityConstitution
        characterWisdom.text = viewModel.character?.characterAbilityWisdom
        characterCharisma.text = viewModel.character?.characterAbilityCharisma
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "EditCharacter") {
            let character = character
            let characterSheet = segue.destination as! NewCharacterViewController
            characterSheet.characterToEdit = character
        }
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func removeCharacter(_ sender: UIButton) {
        showTextFieldAlert()
    }
}

extension CharacterSheetViewController: CharacterSheetViewDelegate {
    func characterRemoved() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    func showTextFieldAlert() {
        let alertController = UIAlertController(title: "Remove \(characterName.text ?? "")", message: "Are you sure you want to remove this character? There is no going back.", preferredStyle: .alert)
        let removeAction = UIAlertAction(title: "Remove", style: .default) { (_) in
            if (alertController.textFields?.first?.text) != nil {
                self.viewModel.removeCharacter()
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
        alertController.addTextField { (textField) in
            textField.placeholder = "Type '\(self.characterName.text ?? "remove") to continue"
        }
        
        alertController.addAction(removeAction)
        alertController.addAction(cancelAction)
        DispatchQueue.main.async {
            self.present(alertController, animated: true, completion: nil)
        }
    }
}
