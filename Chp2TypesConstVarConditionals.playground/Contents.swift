//: Playground - noun: a place where people can play

import Cocoa

// Compiler complains, but the app still runs, if the definition of 'printTownInfo()'
// occurs after it's first usage.
func printTownInfo(population: Int) {
    var message: String
    
    if population < 10000 {
        message = "\(population) is a small town"
    } else if population < 100000 {
        message = "\(population) is a medium sized town"
    } else {
        message = "\(population) is a large town"
    }
    print(message)
}

func printTownInfoTernary(pop: Int) {
    var message: String
    
    message = pop < 10000 ? "\(pop) is a small town" : "\(pop) is medium or large town"
    print(message)
}

// I don't particularly care for the term "let" to indicate a const
let numberOfStoplights: Int = 4
var population: Int = 5422
let townName = "Knowwhere"
var message: String
var unemployment: Int = 27 // percent

// This is annoyingly verbose, but it reads better/easier
let townDescription = "\(townName) has a population of \(population), an unemployment rate of \(unemployment)% and \(numberOfStoplights) stoplights."

// "population" above must be initiaized or assigned to prior to using.
// Otherwise you'll get a compiler error - WTF?
print(townDescription)

printTownInfo(population: population)
population += 10000
printTownInfo(population: population)
population += 100000
printTownInfo(population: population)

printTownInfoTernary(pop: population)
