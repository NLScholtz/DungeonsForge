//
//  AdventuresInformationViewController.swift
//  DungeonsForge
//
//  Created by Nicole Scholtz on 2023/05/02.
//

import UIKit

class AdventureInformationViewController: UIViewController {
    
    @IBOutlet weak var adventureImage: UIImageView!
    @IBOutlet weak var adventureTitle: UILabel!
    @IBOutlet weak var adventureDescription: UILabel!
    
    var adventure: AdventuresModel?
    private lazy var viewModel = AdventuresViewModel(delegate: self)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        adventureImage.image = viewModel.selectedAdventure?.adventureImage
        adventureTitle.text = viewModel.selectedAdventure?.adventureTitle
        adventureDescription.text = viewModel.selectedAdventure?.adventureDescription
    }

}

extension AdventureInformationViewController: AdventuresViewModelDelegate {
    func updateFilteredSearch() {}
}
