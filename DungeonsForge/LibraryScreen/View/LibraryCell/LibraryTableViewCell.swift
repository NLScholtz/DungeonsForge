//
//  LibraryTableViewCell.swift
//  DungeonsForge
//
//  Created by Nicole Scholtz on 2023/05/02.
//

import UIKit

class LibraryTableViewCell: UITableViewCell {

    @IBOutlet weak var libraryTitle: UILabel!
    @IBOutlet weak var libraryDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func set(title: String, describtion: String, isExpanded: Bool) {
        self.libraryTitle.text = title
        self.libraryDescription.text = isExpanded ? describtion : ""
    }
}

