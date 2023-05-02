//
//  AdventuresViewModel.swift
//  DungeonsForge
//
//  Created by Nicole Scholtz on 2023/05/02.
//

import Foundation
import UIKit

protocol AdventuresViewModelDelegate: AnyObject {
    func updateFilteredSearch()
}

class AdventuresViewModel {
    
    private weak var delegate: AdventuresViewModelDelegate?
    var selectedAdventure: AdventuresModel?
    var searchedAdventures = [AdventuresModel]()
    var adventureList = [AdventuresModel(adventureImage: UIImage(named: "GreatUpheal"), adventureTitle: "A Great Upheal",
adventureDescription: "This chapter is designed to advance party of 1st-level characters to 5th level. The characters gain levels by accomplish- ing various goals, which are summarized in the Character Advancement sidebar at the end of the chapter. If the characters are already 5th level, skip ahead to chapter 2, “Rumblings,” using the information in appendix A if the characters are transitioning from another published adventure to this one. Nightston is a fortified settlement located a few miles south of the Ardeep Forest, in the untamed hills between Waterdeep and Daggerford. A lonely wooden signpost, standing where the trail to Nightstone meets the High Road, points the way to the settlement. Nightstone’s closest neighbors are the elves of the Ardeep Forest. Hunters from Nightstone have incurred the elves’ wrath on multiple occasions. However, elves heroes who come to Nightstone in search of adventure quickl discover. The characters are traveling to Nightstone for one or more of the following reasons: The characters have heard rumors of goblins terrorizing the settlement. The High Steward of Nightstone, Lady Velrosa Nandar, is a Waterdhavian noble. She able to deal with the goblin threat. Nightstone is a popular retreat for wealthy nobles who wish to hunt in the Ardeep Forest. Adventurers can earn good money by offering their services as guards on a hunt."),
              AdventuresModel(adventureImage: UIImage(named: "BarberofSilverymoon"), adventureTitle: "The Barber Of Silverymoon", adventureDescription: "People have been disappearing at night in the city of Silverymoon. Some vanish entirely, leaving behind whispered rumors of fiends or other evil creatures have spirited them away. Others return strangely altered, with their memories of having been kidnapped wiped clean and their minds strangely dulled - and always with remarkable haircuts. Jooge Nopsmoth, a talented barber, has long lived... See more."),
              AdventuresModel(adventureImage: UIImage(named: "CavesofShadows"), adventureTitle: "Caves Of Shadow", adventureDescription: "You’ve made your way through dark woodlands. The clear summer sky is obscured by the clawing branches. A light breeze stirs the undergrowth. Up ahead you see the rocky crags that hide the Caves of Shadow. As you approach, you can see the mouth of the cave, but there seems to be some sort of activity in front of it. As you watch, two large, bestial figures..."),
              AdventuresModel(adventureImage: UIImage(named: "CryptOfShadowDragon"), adventureTitle: "Crypt Of The Smoke Dragon", adventureDescription: "Each of you has a hero—a fighter, rogue, wizard, or priest. These valiant adventurers are devoted to ridding the world of evil. It’s a long time ago, in an ancient world filled with fantastic monsters, great treasure, and high adventure. If your heroes do well, they’ll win the day and survive to gain power and experience. And together, we’ll tell an exciting story. I’m going to be the Dungeon Master for this adventure. I’ll describe what your characters see, and you’ll tell me what your heroes will do based on those descriptions. Ready? Let’s begin."),
              AdventuresModel(adventureImage: UIImage(named: "BeautyAndBeast"), adventureTitle: "Beauty And Beast", adventureDescription: "The people of Elsaz spoke in hushed tones of the Beast who stalked them in the night, and who harbored a particular appetite for Beauties of marrying age; attractive maidens locked themselves away at night with all the terror of Barovian peasants. Their troubles began some years back when the village eccentric arrived in town raving that the Beast had stolen his daughter and locked her away in a dungeon; they laughed at the time, but when young Belle returned with a similiar tale, they launched a daring attack to kill the Beast and bring back its head..."),
              AdventuresModel(adventureImage: UIImage(named: "LureOfTheArchlitch"), adventureTitle: "Lure Of The Archlitch", adventureDescription: "The characters are hired by a mysterious patron who claims to know the location of a hidden treasure in the Tomb of Horrors, a legendary dungeon created by the archlich Acererak. The patron provides them with a map and some clues, but warns them that the tomb is full of deadly traps and secrets. The characters enter the tomb and face various challenges, such as false doors, pit traps, illusions, undead guardians, and puzzles..."),
              AdventuresModel(adventureImage: UIImage(named: "CastleRavenloft"), adventureTitle: "Castle Ravenloft", adventureDescription: "In an ancient time and place, magic permeates the land and monsters stalk the shadows that gather along the edges of civi- lization. In this age of dungeons and dragons, the world needs Heroes. Encased in varied types of armor and armed with swords, bows, staves, and spells, these Heroes explore ancient ruins, take on daring quests, and challenge the most fearsome monsters. One such quest takes Heroes to a dark and mysteri- ous place called Castle Ravenloft..."),
              AdventuresModel(adventureImage: UIImage(named: "WrathAshardalon"), adventureTitle: "Wrath Ashardalon", adventureDescription: "In another world where magic is real, the forces of evil gather to destroy the few remaining settlements of humans, dwarves, and elves. To fight back the raiders, brave Heroes arm them- selves with swords and spells and attack the evil hiding in the dark corners of the world. In the lands around Firestorm Peak, the Heroes fight on despite incurring the wrath of the red dragon Ashardalon...")]
    
    init(delegate: AdventuresViewModelDelegate) {
        self.delegate = delegate
        self.searchedAdventures = adventureList
        self.selectedAdventure = adventureList[0]
    }
    
    func adventureSearched(searchString: String) {
        if !searchString.isEmpty {
            searchedAdventures = [AdventuresModel]()
            for adventure in adventureList {
                if adventure.adventureTitle.lowercased().contains(searchString.lowercased()) {
                    searchedAdventures.append(adventure)
                }
            }
        } else {
            searchedAdventures = adventureList
        }
        delegate?.updateFilteredSearch()
    }
    
    func selectAdventure(at index: Int) {
        self.selectedAdventure = adventureList[index]
    }
    
    var numberOfAdventures: Int { return searchedAdventures.count}
    
    func adventureImage(at index: Int) -> UIImage? {
        return searchedAdventures[index].adventureImage
    }
    
    func adventureTitle(at index: Int) -> String {
        return searchedAdventures[index].adventureTitle
    }
    
    func adventureDescription(at index: Int) -> String {
        return searchedAdventures[index].adventureDescription
    }
    
}
