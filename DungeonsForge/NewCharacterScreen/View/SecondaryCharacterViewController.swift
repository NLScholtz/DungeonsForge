//
//  SecondaryCharacterViewController.swift
//  DungeonsForge
//
//  Created by Nicole Scholtz on 2023/05/02.
//

import UIKit

class SecondaryCharacterViewController: UIViewController {
    
    @IBOutlet weak var strenghtDigit: UILabel!
    @IBOutlet weak var dexterityDigit: UILabel!
    @IBOutlet weak var intelligenceDigit: UILabel!
    @IBOutlet weak var consitutionDigit: UILabel!
    @IBOutlet weak var wisdomDigit: UILabel!
    @IBOutlet weak var charismaDigit: UILabel!
    
    private lazy var viewModel = SecondaryCharacterViewModel()
    
    var characterSheet: CharacterModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (characterSheet?.characterCreated == true) {
            self.strenghtDigit.text = characterSheet?.characterAbilityStrength
            self.dexterityDigit.text = characterSheet?.characterAbilityDexterity
            self.intelligenceDigit.text = characterSheet?.characterAbilityIntelligence
            self.consitutionDigit.text = characterSheet?.characterAbilityConstitution
            self.wisdomDigit.text = characterSheet?.characterAbilityWisdom
            self.charismaDigit.text = characterSheet?.characterAbilityCharisma
        }
    }
    
    @IBAction func rollDiceAction(_ sender: UIButton) {
        strenghtDigit.text = String(Int.randomInt(max: 20))
        dexterityDigit.text = String(Int.randomInt(max: 20))
        intelligenceDigit.text = String(Int.randomInt(max: 20))
        consitutionDigit.text = String(Int.randomInt(max: 20))
        wisdomDigit.text = String(Int.randomInt(max: 20))
        charismaDigit.text = String(Int.randomInt(max: 20))
    }
    
    
    @IBAction func continueAction(_ sender: UIButton) {
        viewModel.characterSheet = characterSheet
        viewModel.updateCharacterAbilityScores(characterAbilityStrenght: strenghtDigit.text ?? "", characterAbilityDexterity: dexterityDigit.text ?? "", characterAbilityIntelligence: intelligenceDigit.text ?? "", characterAbilityConstitution: consitutionDigit.text ?? "", characterAbilityWisdom: wisdomDigit.text ?? "", characterAbilityCharisma: charismaDigit.text ?? "")
        
        performSegue(withIdentifier: "thirdCharacterSheet", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "thirdCharacterSheet") {
            let thirdCharacterSheet = segue.destination as! ThirdCharacterViewController
            guard let character = viewModel.characterSheet else {
                return
            }
            thirdCharacterSheet.characterSheet = character
        }
    }
}

extension Int {
    static func randomInt(max: Int) -> Int {
        return Int(arc4random_uniform(UInt32(max)) + 1)
    }
}
