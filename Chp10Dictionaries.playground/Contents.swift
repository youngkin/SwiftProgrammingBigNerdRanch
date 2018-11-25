import Cocoa

func printMovies(movies: [String:Int]) {
    print("\nPrinting movies")
    for movie in movies {
        print("\tTitle: \(movie.key), Rating: \(movie.value)")
    }
}

var dict1: Dictionary<String, Double> = [:]
var dict2 = Dictionary<String, Double>()
var dict3: [String:Double] = [:]
var dict4 = [String:Double]()

var movieRatings = ["Donnie Darko": 4, "Chungking Express": 5, "DarkCity": 4]
print("I have rated \(movieRatings.count) movies.")

let darkoRating = movieRatings["Donnie Darko"]

movieRatings["Donnie Darko"] = 5
// Update dictionary entry and return previous value (as an Optional)
let oldRating: Int? = movieRatings.updateValue(5, forKey: "Donnie Darko")
// Note the Optional "let" notation for getting the currentRating. Dictionary accesses
// return Optional as the requested entry may not exist.
if let lastRating = oldRating, let currentRating = movieRatings["Donnie Darko"] {
    print("Old value: \(lastRating), New value: \(currentRating)")
}

printMovies(movies: movieRatings)
movieRatings["Dr. Claigari"] = 5
//movieRatings["DarkCity"] = nil
movieRatings.removeValue(forKey: "DarkCity")
printMovies(movies: movieRatings)

print("\n")
for (key, value) in movieRatings {
    print("Title: \(key), Rating: \(value)")
}

print("\n")
for key in movieRatings.keys {
    print("Title: \(key)")
}

// Silver & Gold Challenges
var coloradoZips: [String: Array<Int32>] = [:]
coloradoZips["Larimar"] = [30306, 30307, 30308, 30309, 30310]
coloradoZips["Teller"] = [30311, 30312, 30313, 30314, 30315]
coloradoZips["Grand"] = [30301, 30302, 30303, 30304, 30305]
coloradoZips["Arapaho"] = [80120, 80202, 80234, 80202, 80123]

var arrOfZips: Array<Int32> = []
for v in coloradoZips.values {
    arrOfZips.append(contentsOf: v)
}
let prefix = "Colorado has the following Zip Codes:"
print("\(prefix) \(arrOfZips)")

print("\nGold Challenge:")

