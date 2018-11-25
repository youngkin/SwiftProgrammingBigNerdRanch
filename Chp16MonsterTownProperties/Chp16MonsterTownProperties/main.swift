//
//  main.swift
//  MonsterTown
//
//  Created by Youngkin, Richard on 10/16/18.
//  Copyright © 2018 BigNerdRanch. All rights reserved.
//

/* Key points:
 *  1. Use of classes & structs
 *  2. Value vs. Reference types ('Town' is a value type - struct -, 'Zombie's and 'Vampire's
 *      reference types - classes - )
 *  2. Nice real world use of Optionals (printing town description, town may not be assigned)
 */

import Foundation

// Note: 'Town' is a struct and hence a value type. Fred & Bela each get
// their own instance of 'myTown'.
var myTown = Town()
//print("My town's size is \(myTown.townSize) and its population is \(myTown.population)")

myTown.changePopulation(by: 1_000_000)
//print("My town's size is \(myTown.townSize) and its population is \(myTown.population)")

let fredTheZombie = Zombie()
fredTheZombie.town = myTown
fredTheZombie.terrorizeTown()
fredTheZombie.town?.printDescription()
print("Victim pool: \(fredTheZombie.victimPool)")
fredTheZombie.victimPool = 500
print("Victim pool: \(fredTheZombie.victimPool); population: \(fredTheZombie.town?.population)")
print(Zombie.spookyNoise)
if Zombie.isTerrifying {
    print("Run away!!!!")
}

let Bela = Vampire()
Bela.town = myTown
Bela.terrorizeTown()
Bela.town?.printDescription()
