//
//  Vampire.swift
//  MonsterTown
//
//  Created by Youngkin, Richard on 10/16/18.
//  Copyright © 2018 BigNerdRanch. All rights reserved.
//

/* Key points:
 *  1. XXX
 */

import Foundation

class Vampire: Monster {
    var thrall: Array<Vampire?> = []
    
    override func terrorizeTown() {
        thrall.append(Vampire(town: nil, monsterName: "NA"))
        town?.changePopulation(by: -1)
        super.terrorizeTown()
    }
}
