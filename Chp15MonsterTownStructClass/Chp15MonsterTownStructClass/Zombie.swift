//
//  Zombie.swift
//  MonsterTown
//
//  Created by Youngkin, Richard on 10/16/18.
//  Copyright © 2018 BigNerdRanch. All rights reserved.
//

import Foundation

class Zombie: Monster {
    var walksWithLimp = true
    
    // 'final' prevents subclasses from overriding like Zombie did with
    // 'Monster.terrorizeTown()'
    final override func terrorizeTown() {
        let killNPeople = -10
        if let pop = town?.population {
            if pop >= killNPeople {
                town?.changePopulation(by: killNPeople)
            }
        }
        super.terrorizeTown()
    }
}
