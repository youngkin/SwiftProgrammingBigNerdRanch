//
//  main.swift
//  MonsterTown
//
//  Created by Youngkin, Richard on 10/16/18.
//  Copyright © 2018 BigNerdRanch. All rights reserved.
//

/* Key points:
 *  1. Use of intializers - designated and convenience
 *  2. Automatic initializer inheritance, initializers inherited from a superclass.
 *      Occurs when a class specified default values for subclass specific properties but
 *      Doesn't have any designated initializers of its own. Can apply to convenience
 *      initializers as well. Both Zombie (Fred) and Vampire (Bela) need to be initialized
 *      using the inherited 'Monster' initializer.
 *  3. Convenience initializers (See fredTheZombie)
 *  4. Deinitialization (destruction) - requires that variables be defined as an optional
 *  5. Failable initializers - return nil if preconditions aren't met. Used this concept
 *      with 'Town' when population provided isn't > 0. Notice that all the Mayoral notifications
 *      regarding zombie attacks have stopped - there's no town to attack.
 */

import Foundation

// Use of a 'memberwise' initializer. Overrides default values specified in class definition.
// Use 'Town's property names to specify the variables and values. In the second version of
// the 'myTown' declaration a custom initializer is used.
// var myTown = Town(region: "West", population: 10_000, stoplights: 6)
var myTown = Town(population: 0, stoplights: 6)
if let myTown = myTown {
    myTown.printDescription()
}
//print("My town's size is \(myTown.townSize) and its population is \(myTown.population)")

myTown?.changePopulation(by: 1_000_000)
//print("My town's size is \(myTown.townSize) and its population is \(myTown.population)")

//let fredTheZombie = Zombie(limp: false, fallingApart: false, town: myTown, monsterName: "Fred")
// Use a convenience initializer instead.
var fredTheZombie: Zombie? = Zombie(limp: true, fallingApart: false)
fredTheZombie?.terrorizeTown()
fredTheZombie?.town?.printDescription()
print("Victim pool: \(fredTheZombie?.victimPool ?? 0)")
fredTheZombie?.victimPool = 500
print("Victim pool: \(fredTheZombie?.victimPool ?? 0); population: \(fredTheZombie?.town?.population ?? 0)")
print(Zombie.spookyNoise)
if Zombie.isTerrifying {
    print("Run away!!!!")
}

let Bela = Vampire(town: myTown, monsterName: "Bela")
Bela?.terrorizeTown()
Bela?.town?.printDescription()

// Explicitly deinitialize (destruct) fredTheZombie
fredTheZombie = nil
