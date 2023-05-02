//
//  LibraryViewModelTest.swift
//  DungeonsForgeTests
//
//  Created by Nicole Scholtz on 2023/05/02.
//

@testable import DungeonsForge
import XCTest

final class LibraryViewModelTest: XCTestCase {
    
    var viewModelToTest: LibraryViewModel?

    override func setUpWithError() throws {
        
        viewModelToTest = LibraryViewModel(delegate: self)
        viewModelToTest?.libraryList = [LibraryModel(libraryTitle: "Races", libraryDescription: "Race or species is a rule in Dungeons & Dragons referring to the fantasy ancestry of a character. The term is primarily used to refer to those species intended to represent player characters, as opposed to monsters. Popular races include human, elf, dwarf and halfling."),
                                      LibraryModel(libraryTitle: "Classes", libraryDescription: "A character class is a fundamental part of the identity and nature of characters in the Dungeons & Dragons role-playing game. A character's capabilities, strengths, and weaknesses are largely defined by their class; choosing a class is one of the first steps a player takes to create a Dungeons & Dragons player character. Some popular ones include barbarian, bard, cleric, paladin, druid.")]
    }

    override func tearDownWithError() throws {}

    func testNumberOfLibraries() throws {
        XCTAssertTrue(viewModelToTest?.numberOfLibraries == 2, "Number of libraries is incorrect")
    }
    
    func testLibraryTitles() throws {
        XCTAssertTrue(viewModelToTest?.libraryTitle(at: 0) == "Races", "Title for library is incorrect")
        XCTAssertTrue(viewModelToTest?.libraryTitle(at: 1) == "Classes", "Title for library is incorrect")
    }
    
    func testLibraryDescription() throws {
        XCTAssertTrue(viewModelToTest?.libraryDescription(at: 0) == "Race or species is a rule in Dungeons & Dragons referring to the fantasy ancestry of a character. The term is primarily used to refer to those species intended to represent player characters, as opposed to monsters. Popular races include human, elf, dwarf and halfling.", "Description for library is incorrect")
        XCTAssertTrue(viewModelToTest?.libraryDescription(at: 1) == "A character class is a fundamental part of the identity and nature of characters in the Dungeons & Dragons role-playing game. A character's capabilities, strengths, and weaknesses are largely defined by their class; choosing a class is one of the first steps a player takes to create a Dungeons & Dragons player character. Some popular ones include barbarian, bard, cleric, paladin, druid.", "Description for library is incorrect")
    }
    
    func testSelectedLibrary() throws {
        viewModelToTest?.selectLibrary(at: 1)
        XCTAssertTrue(viewModelToTest?.selectedLibrary?.libraryTitle == viewModelToTest?.libraryList[1].libraryTitle, "Selected library is incorrect")
    }
    
    func testSearchedLibrary() throws {
        viewModelToTest?.librarySearched(searchString: "Ra")
        XCTAssertTrue(viewModelToTest?.searchedLibrary.count == 1, "Searched Library is incorrect")
    }
    
    func testSearchedLibraryWithEmptyString() throws {
        viewModelToTest?.librarySearched(searchString: "")
        XCTAssertTrue(viewModelToTest?.searchedLibrary.count == 2, "Searched Library is incorrect")
    }
}

extension LibraryViewModelTest: LibraryViewModelDelegate {
    func updateFilteredSearch() {}
}

