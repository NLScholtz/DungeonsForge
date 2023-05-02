//
//  ExpandableCellContent.swift
//  DungeonsForge
//
//  Created by Nicole Scholtz on 2023/05/02.
//

import Foundation

class ExpandableCellContent {
    var libraryTitle: String?
    var libraryDescription: String?
    var isExpanded: Bool?
    
    init(libraryTitle: String, libraryDescription: String) {
        self.libraryTitle = libraryTitle
        self.libraryDescription = libraryDescription
        self.isExpanded = false
    }
    
    init() {
        self.libraryTitle = ""
        self.libraryDescription = ""
        self.isExpanded = false
    }
}
