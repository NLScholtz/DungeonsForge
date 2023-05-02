//
//  LibraryViewModel.swift
//  DungeonsForge
//
//  Created by Nicole Scholtz on 2023/05/02.
//

import Foundation
import UIKit

protocol LibraryViewModelDelegate: AnyObject {
    func updateFilteredSearch()
}

class LibraryViewModel {
    
    private weak var delegate: LibraryViewModelDelegate?
    var selectedLibrary : LibraryModel?
    var searchedLibrary = [LibraryModel]()
    var libraryList = [LibraryModel(libraryTitle: "Races", libraryDescription: "Race or species is a rule in Dungeons & Dragons referring to the fantasy ancestry of a character. The term is primarily used to refer to those species intended to represent player characters, as opposed to monsters. Popular races include human, elf, dwarf and halfling."),
                     LibraryModel(libraryTitle: "Classes", libraryDescription: "A character class is a fundamental part of the identity and nature of characters in the Dungeons & Dragons role-playing game. A character's capabilities, strengths, and weaknesses are largely defined by their class; choosing a class is one of the first steps a player takes to create a Dungeons & Dragons player character. Some popular ones include barbarian, bard, cleric, paladin, druid."),
                     LibraryModel(libraryTitle: "Backgrounds", libraryDescription: "Your background is meant to represent your character's life before they became an adventurer. All characters must select a background when the character is first created. Each background gives an assortment of skill and tool proficiencies, alongside some extra starting equipment at 1st level. Popular backgrounds include Acolyte, Charlatan, Criminal, Entertainer, Noble."),
                     LibraryModel(libraryTitle: "Proficiencies", libraryDescription: "Simply put: the proficiency bonus in Dungeons and Dragons is a bonus added to skill checks, saving throws, or attacks for skills that a character is proficient in. At first glance, it might not be obvious how this bonus differs from the ability modifiers a character has. Some popular proficiensies include alchemist supplies, blowguns, daggers, greataxes, hand crossbows."),
                     LibraryModel(libraryTitle: "Languages", libraryDescription: "Languages in D&D 5E are a fantastic way to flesh out the world of your adventures - and, as complex as they may potentially be, it’s still meant to be playable at the end of the day. There are over 60 languages all-in-all in the current iteration of D&D 5E. You don’t need to know every single one, but it’s important to know why language is important and which ones to choose depending on your campaign. Most common languages include Common, Dwarvish, Elvish, Giant."),
                     LibraryModel(libraryTitle: "Equipment", libraryDescription: "When you create your character, you receive equipment based on a combination of your class and background. Alternatively, you can start with a number of gold pieces based on your class and spend them on items from the lists in this section. See the Starting Wealth by Class table to determine how much gold you have to spend. You decide how your character came by this starting equipment. It might have been an inheritance, or goods that the character purchased during his or her upbringing. You might have been equipped with a weapon, armor, and a backpack as part of military service. You might even have stolen your gear. A weapon could be a family heirloom, passed down from generation to generation until your character finally took up the mantle and followed in an ancestor’s adventurous footsteps. This includes, abacus, alms box, arrow, backpack."),
                     LibraryModel(libraryTitle: "Traits", libraryDescription: "Traits are aspects of a character's personality, background, or physique that make him better at some activities and worse at others. In many ways, traits resemble feats: A character can have only a limited number of traits, and each trait provides some benefit. Polpular ones include artificers lore, brave, breath weapon, trance, naturally stealthy."),
                     LibraryModel(libraryTitle: "Ability", libraryDescription: "Ability scores are your D&D character's primary statistics and pretty much determine how good they are at doing anything. These stats consist of strength, constitution, intelligence, wisdom, charisma and dexterity, and can be generated into two very distinct ways."),
                       LibraryModel(libraryTitle: "Alignment", libraryDescription: "A typical creature in the game world has an alignment, which broadly describes its moral and personal attitudes. Alignment is a combination of two factors: one identifies morality (good, evil, or neutral), and the other describes attitudes toward society and order (lawful, chaotic, or neutral). Thus, nine distinct alignments define the possible combinations."),
                       LibraryModel(libraryTitle: "Skills", libraryDescription: "Skills are the talents your D&D character is proficient in, meaning that when you're asked to roll ability checks you will be able to add a bonus modifier to your result (thereby increasing the likelihood that you'll pass the check). Each ability covers a broad range of capabilities, including skills that a character or a monster can be proficient in. A skill represents a specific aspect of an ability score, and an individual's proficiency in a skill demonstrates a focus on that aspect."),
                       LibraryModel(libraryTitle: "Conditions", libraryDescription: "A condition alters a creature’s capabilities in a variety of ways and can arise as a result of a spell, a class feature, a monster’s attack, or other effect. Most conditions, such as blinded, are impairments, but a few, such as invisible, can be advantageous."),
                       LibraryModel(libraryTitle: "Damage Types", libraryDescription: "Different attacks, damaging spells, and other harmful effects deal different types of damage. Damage types have no rules of their own, but other rules, such as damage resistance, rely on the types."),
                       LibraryModel(libraryTitle: "Magic Items", libraryDescription: "A magic item is any object that is imbued with magic powers. These items may act on their own or be the tools of the character possessing them. These are the various magic items you can find in the game."),
                       LibraryModel(libraryTitle: "Monsters", libraryDescription: "The term monster refers to a variety of creatures, some adapted from folk myths and legends and others invented specifically for the game. Included are traditional monsters such as dragons, supernatural creatures such as ghosts, and mundane or fantastic animals.[1] Monsters are typically used as obstacles which the players must overcome to progress through the game.")]
    
    var numberOfLibraries: Int { return libraryList.count }
    init(delegate: LibraryViewModelDelegate) {
        self.delegate = delegate
        self.searchedLibrary = libraryList
        self.selectedLibrary = libraryList[0]
    }
    
    func librarySearched(searchString: String) {
        if searchString == "" {
            searchedLibrary = libraryList
        } else {
            searchedLibrary = []
            searchedLibrary = libraryList.filter{
                $0.libraryTitle.lowercased().contains(searchString.lowercased())
            }
        }
        delegate?.updateFilteredSearch()
    }
    
    func libraryTitle(at index : Int) -> String {
        return libraryList[index].libraryTitle
    }
    
    func libraryDescription(at index : Int) -> String {
        return libraryList[index].libraryDescription
    }
    
    func selectLibrary(at index : Int) {
        selectedLibrary = libraryList[index]
    }
}
