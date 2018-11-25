import Cocoa

let volunteerCounts = [1,3,40,32,2,53,77,13]

// -----------------------------------------------------------------------------------//
//
// ------------------------ [Functions as arguments] ---------------------------------//
//
// -----------------------------------------------------------------------------------//
//
// Option 1, a named function (closure)
//
//func sortAscending(_ i: Int, _ j: Int) -> Bool {
//    return i < j
//}
//let volunteersSorted = volunteerCounts.sorted(by: sortAscending)
//print("Sorted list: \(volunteersSorted)")

//
//Option 2, an in-line closure
//
//let volunteersSorted = volunteerCounts.sorted(by: {
//    (i: Int, j: Int) -> Bool in
//    i < j
//})

//
// Option 3 - Using type inference ('by' is a function typed (Int:Int) -> Bool
// Note the absence of 'return'. It too can be inferred if the closure has only
// one expression
//
//let volunteersSorted = volunteerCounts.sorted(by: {i, j in i < j})

//
// Option 4 - Parameters can also be referenced directly as with shell scripts.
// There are positional aliases starting with $0 thru $n-1 where 'n' is the number
// of parameters.
//
//let volunteersSorted = volunteerCounts.sorted(by: {$0 < $1})

//
// Option 5 - If a closure is the last parameter of a function, it can be
// written in-line, outside of the parameter list. In this case there is only
// a single parameter so the parameter list can be entirely left out
let volunteersSorted = volunteerCounts.sorted {$0 < $1}


print("Sorted list: \(volunteersSorted)")



// -----------------------------------------------------------------------------------//
//
// ---------------------- [Functions as return Types] --------------------------------//
// ---------------------- [and parameters.          ] --------------------------------//
//
// -----------------------------------------------------------------------------------//
//
func makeTownGrand(withBudget: Int, condition: (Int) -> Bool) -> ((Int, Int) -> Int)? {
//    func buildRoads(byAddingLights lights: Int,
//                    toExistingLights existingLights: Int) -> Int {
//        return lights + existingLights
//    }
//    return buildRoads
    // Returning an anonymous closure/function
    if condition(withBudget) {
        return {(lights: Int, existingLights: Int) -> Int in
            return lights + existingLights
        }
    }
    
    return nil
}

func evaluate(budget: Int) -> Bool {
    return budget > 10_000
}

var stoplights = 4
if let townPlanByAddingLightsToExistingLights = makeTownGrand(withBudget: 9_000, condition: evaluate) {
    stoplights = townPlanByAddingLightsToExistingLights(4, stoplights)
}
print("Knowhere has \(stoplights) stoplights.")



// -----------------------------------------------------------------------------------//
//
// ------------------------ [Closures capture values] --------------------------------//
//
// -----------------------------------------------------------------------------------//
//
func makePopulationTracker(forInitialPopulation population: Int) -> (Int) -> Int {
    var totalPopulation = population
    return { (growth: Int) -> Int in
        // 'totalPopulation' continues to be in-scope as long as the returned function
        // is in-scope. That is, it will continue to track updates and be incremented
        // each time it's called.
        totalPopulation += growth
        return totalPopulation
    }
}

var currentPopulation = 5_422
let growBy = makePopulationTracker(forInitialPopulation: currentPopulation)
growBy(500)
growBy(500)
growBy(500)
currentPopulation = growBy(500) // currentPopulation is now 7422


// -----------------------------------------------------------------------------------//
//
// ------------------- [Closures are also Reference Types] ---------------------------//
// ----------------- [No examples, you know what this means] -------------------------//
//
// -----------------------------------------------------------------------------------//
//


// -----------------------------------------------------------------------------------//
//
// --------------------------- [Higher Order Functions] ------------------------------//
//
// -----------------------------------------------------------------------------------//
//

// 'map(_:) can be called on 'Array' types. Takes input and returns another array whose
// contents reflect the mapping function results. Notice the trailing closure syntax.
let precinctPopulations = [1244, 2021, 2157]
let projectedPopulations = precinctPopulations.map {
    (population: Int) -> Int in
    return population * 2
}
print("Projected populations after mapping 2x growth: \(projectedPopulations)")

// The mapping function can be of an arbitrary type (i.e., 'map(_:)' takes an
// unnamed argument of any type
let projectedPopReport = precinctPopulations.map {
    (population: Int) -> String in
    return "Projected population: " + String(population * 2)
}
for popRep in projectedPopReport {
    print("\t", popRep)
}

// 'filter(_:) is also called on 'Array' types. It filters the input based on the provided
// function, returning an array with only the original entries that match the filter
// criteria.
let bigProjections = projectedPopulations.filter {
    (projection: Int) -> Bool in
    return projection > 4000
}
print("Filter out precincts whose populations <= 4000: \(bigProjections)")

// 'reduce(_:)' takes an array input, applying a function to each element, and
// returns a single value (i.e., reduces the array contents to a single value).
// Parameter 1 is a starting value to use in the closure passed in the second
// parameter.

let totalProjection = projectedPopulations.reduce(0) {
    (accumulatedProjection: Int, precinctProjection: Int) -> Int in
    return accumulatedProjection + precinctProjection
}
print("Total population of Knowhere: \(totalProjection)")

// Use a more sophisticated closure. Apparently returning a 'String' isn't possible
//let totalProjectionReport = projectedPopulations.reduce(0) {
//    (accumulatedProjection: Int, precinctProjection: Int) -> String in
//    return "Knowhere's total population across all precincts: " + String(accumulatedProjection + precinctProjection)
//}
//print("Total population of Knowhere: \(totalProjectionReport)")


// -----------------------------------------------------------------------------------//
//
// ------------------------------- [Bronze Challenge] --------------------------------//
//
// -----------------------------------------------------------------------------------//
//
var unsorted: Array<Int> = [5, 1, 0, 22, 17]
unsorted.sort()
print("Unsorted array is sorted in-place: \(unsorted)")


// -----------------------------------------------------------------------------------//
//
// -------------------------------- [Gold Challenge] ---------------------------------//
//
// -----------------------------------------------------------------------------------//
//
// Implement a simpler, more concise version, of the reduce example above.
let totalProjectionGold = projectedPopulations.reduce(0) { return $0 + $1 }
print("Total population of Knowhere (Gold Challenge): \(totalProjectionGold)")

