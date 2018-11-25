//
//  Vampire.swift
//  MonsterTown
//
//  Created by Youngkin, Richard on 10/16/18.
//  Copyright © 2018 BigNerdRanch. All rights reserved.
//

import Foundation

class Vampire: Monster {
    var thrall: Array<Vampire> = []
    
    override func terrorizeTown() {
        thrall.append(Vampire())
        town?.changePopulation(by: -1)
        super.terrorizeTown()
    }
}
