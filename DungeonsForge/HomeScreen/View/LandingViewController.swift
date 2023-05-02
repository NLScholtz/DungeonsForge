//
//  LandingViewController.swift
//  DungeonsForge
//
//  Created by Nicole Scholtz on 2023/05/02.
//

import UIKit

class LandingViewController: NotificationViewController {
    
    @IBOutlet weak var charactersTableView: UITableView!
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var userPicture: UIImageView!
    
    private lazy var viewModel = LandingViewModel(delegate: self, appStorageController: AppDataStore())

    var username: String?
            
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        (UIApplication.shared.delegate as! AppDelegate).restrictRotation = .portrait
        usernameLabel.text = (self.tabBarController as! TabBarViewController).username
        
        charactersTableView.estimatedRowHeight = 80
        charactersTableView.rowHeight = UITableView.automaticDimension
        charactersTableView.reloadData()
        charactersTableView.layer.cornerRadius = 10
        
        userPicture.layer.cornerRadius = userPicture.frame.width / 2.0
        userPicture.clipsToBounds = true
        userPicture.layer.masksToBounds = true
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchCharacters()
    }
    
}

extension LandingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfCharacters
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CharactersCell", for: indexPath) as! CharactersTableViewCell
        
        cell.charactersName.text = viewModel.characterName(at: indexPath.row)
        cell.charactersRaceNClass.text = viewModel.characterRace(at: indexPath.row)
        cell.charactersImage.image = UIImage(named: "\(cell.charactersRaceNClass.text ?? "Human")")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.selectCharacter(at: indexPath.row)
        performSegue(withIdentifier: "characterSheet", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "characterSheet") {
            let characterSheet = segue.destination as! CharacterSheetViewController
            characterSheet.character = viewModel.selectedCharacter
        }
    }
}

extension LandingViewController: LandingViewModelDelegate{
    func charactersFetched() {
        charactersTableView.reloadData()
    }
}
