//
//  CollectionViewCell.swift
//  DungeonsForge
//
//  Created by Nicole Scholtz on 2023/05/02.
//

import UIKit

class AdventuresCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var adventureImage: UIImageView!
    @IBOutlet weak var adventureTitle: UILabel!
    @IBOutlet weak var adventureDescription: UILabel!
    
    override func draw(_ rect: CGRect) {
        self.adventureImage.layer.cornerRadius = 30.0
        self.adventureImage.clipsToBounds = true
    }
    
    func populate(with adventureImage: UIImage?, adventureTitle: String, adventureDescription: String) {
        self.adventureImage.image = adventureImage
        self.adventureTitle.text = adventureTitle
        self.adventureDescription.text = adventureDescription
    }
}
