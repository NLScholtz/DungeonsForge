//
//  AdventuresViewController.swift
//  DungeonsForge
//
//  Created by Nicole Scholtz on 2023/05/02.
//

import UIKit

class AdventuresViewController: NotificationViewController {
    
    @IBOutlet weak var adventuresCollectionView: UICollectionView!
    @IBOutlet weak var searchTextField: UITextField!
        
    private lazy var viewModel = AdventuresViewModel(delegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpAdventuresCollectionView()
        (UIApplication.shared.delegate as! AppDelegate).restrictRotation = .portrait
        self.adventuresCollectionView.contentInsetAdjustmentBehavior = .never
        self.adventuresCollectionView.automaticallyAdjustsScrollIndicatorInsets = false
        self.adventuresCollectionView.contentInset = UIEdgeInsets(top: -350, left: 0, bottom: 0, right: 0 )
        navigationController?.isNavigationBarHidden = true
    }
    
    @IBAction func textFieldChanged(_ sender: Any) {
        guard let textField = sender as? UITextField else {
            return
        }
        let searchText = textField.text
        print(searchText ?? "")
        viewModel.adventureSearched(searchString: searchText ?? "")
    }
}

extension AdventuresViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfAdventures
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //let selectedRow = indexPath.row
        self.performSegue(withIdentifier: "showAdventure", sender: self)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellAdventures = collectionView.dequeueReusableCell(withReuseIdentifier: "AdventuresCell", for: indexPath) as! AdventuresCollectionViewCell
        cellAdventures.populate(with: viewModel.searchedAdventures[indexPath.row].adventureImage, adventureTitle: viewModel.searchedAdventures[indexPath.row].adventureTitle, adventureDescription: viewModel.searchedAdventures[indexPath.row].adventureDescription)
        return cellAdventures
    }
    
    func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "showAdventure") {
            //var adventureInformationViewController = segue.destination as! AdventureInformationViewController
            //adventureInformationViewController.adventureTitle.text = viewModel.adventureTitle(at: indexPath.row)
            let adentureInfoViewController = segue.destination as! AdventureInformationViewController
            adentureInfoViewController.adventure = viewModel.selectedAdventure
        }
    }
    
    func setUpViewModel(viewModel: AdventuresViewModel) {
        self.viewModel = viewModel
    }
    
    func setUpAdventuresCollectionView() {
        let flowLayout = FlowLayout()
        let itemWidth = adventuresCollectionView.frame.width - 100
        let itemHeight = adventuresCollectionView.frame.height - 400
        flowLayout.minimumLineSpacing = 80
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        adventuresCollectionView.collectionViewLayout = flowLayout
        adventuresCollectionView.reloadData()
    }
}

extension AdventuresViewController: AdventuresViewModelDelegate {
    func updateFilteredSearch() {
        adventuresCollectionView.reloadData()
    }
}

extension AdventuresViewController: UITextViewDelegate, UITextFieldDelegate {
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}


