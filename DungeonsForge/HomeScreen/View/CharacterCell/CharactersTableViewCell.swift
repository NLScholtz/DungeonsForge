//
//  CharactersTableViewCell.swift
//  DungeonsForge
//
//  Created by Nicole Scholtz on 2023/05/02.
//

import UIKit

class CharactersTableViewCell: UITableViewCell {

    @IBOutlet weak var charactersImage: UIImageView!
    @IBOutlet weak var charactersName: UILabel!
    @IBOutlet weak var charactersRaceNClass: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
