//
//  AdventuresViewModelTest.swift
//  DungeonsForgeTests
//
//  Created by Nicole Scholtz on 2023/05/02.
//

@testable import DungeonsForge
import XCTest

final class AdventuresViewModelTest: XCTestCase {
    
    var viewModelToTest: AdventuresViewModel?

    override func setUpWithError() throws {
        viewModelToTest = AdventuresViewModel(delegate: self)
        viewModelToTest?.adventureList = [AdventuresModel(adventureImage: UIImage(named: "CharacterSheetIcon"), adventureTitle: "Chronicles", adventureDescription: "Deep in the forest you go..."),
                                                 AdventuresModel(adventureImage: UIImage(named: "CharacterSheetIcon"), adventureTitle: "Far Far Away", adventureDescription: "On the top of a mountaint...")]
        
        
        guard let adventureLists = viewModelToTest?.adventureList else { return }
        viewModelToTest?.searchedAdventures = adventureLists
    }

    override func tearDownWithError() throws {}

    func testNumberOfAdventures() throws {
        XCTAssertTrue(viewModelToTest?.numberOfAdventures == 2, "Number of characters is incorrect")
    }
    
    func testAdventureImage() throws {
        XCTAssertTrue(viewModelToTest?.adventureImage(at: 0) == UIImage(named: "CharacterSheetIcon"), "Image of character is incorrect")
        XCTAssertTrue(viewModelToTest?.adventureImage(at: 1) == UIImage(named: "CharacterSheetIcon"), "Image of character is incorrect")
    }
    
    func testAdventureTitle() throws {
        XCTAssertTrue(viewModelToTest?.adventureTitle(at: 0) == "Chronicles", "Adventure title is incorrect")
        XCTAssertTrue(viewModelToTest?.adventureTitle(at: 1) == "Far Far Away", "Adventure title is incorrect")
    }
    
    func testAdventureDescription() throws {
        XCTAssertTrue(viewModelToTest?.adventureDescription(at: 0) == "Deep in the forest you go...", "Adventure description is incorrect")
        XCTAssertTrue(viewModelToTest?.adventureDescription(at: 1) == "On the top of a mountaint...", "Adventure description is incorrect")
    }
    
    func testSelectedAdventure() throws {
        viewModelToTest?.selectAdventure(at: 1)
        XCTAssertTrue(viewModelToTest?.selectedAdventure?.adventureTitle == viewModelToTest?.adventureList[1].adventureTitle, "Selected character is incorrect")
    }
    
    func testSearchedAdventure() throws {
        viewModelToTest?.adventureSearched(searchString: "Ch")
        XCTAssertTrue(viewModelToTest?.searchedAdventures.count == 1, "Searched Adventure is incorrect")
    }
    
    func testSearchedAdventureWithEmptyString() throws {
        viewModelToTest?.adventureSearched(searchString: "")
        XCTAssertTrue(viewModelToTest?.searchedAdventures.count == 2, "Searched Adventure is incorrect")
    }
}

extension AdventuresViewModelTest: AdventuresViewModelDelegate {
    func updateFilteredSearch() {}
}

