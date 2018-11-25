//
//  main.swift
//  MonsterTown
//
//  Created by Youngkin, Richard on 10/16/18.
//  Copyright © 2018 BigNerdRanch. All rights reserved.
//

import Foundation

// Note: 'Town' is a struct and hence a value type. Fred & Bela each get
// their own instance of 'myTown'.
var myTown = Town()
myTown.printDescription()

myTown.changePopulation(by: 500)
let fredTheZombie = Zombie()
fredTheZombie.town = myTown
fredTheZombie.terrorizeTown()
fredTheZombie.town?.printDescription()

let Bela = Vampire()
Bela.town = myTown
Bela.terrorizeTown()
Bela.town?.printDescription()
