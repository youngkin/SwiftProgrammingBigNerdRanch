import Cocoa

let playground = "Hello, playground"
var mutablePlayground = "Hello, mutable playground"
mutablePlayground += "!"

for c: Character in mutablePlayground {
    print("'\(c)'", terminator:"")
}
print("\n")

let oneCoolDude = "\u{1F60E}"
let aAcute = "\u{0061}\u{0301}"
let aAcutePrecomposed = "\u{00E1}"

mutablePlayground += aAcute
for scalar in mutablePlayground.unicodeScalars {
    print("\(scalar.value) ", terminator:"")
}

let b = (aAcute == aAcutePrecomposed)
print("\n\nCharacter count: aAcute: \(aAcute.count); aAcutePrecomposed: \(aAcutePrecomposed.count)")

let start = playground.startIndex
let end = playground.index(start, offsetBy: 4)
let fifthCharacter = playground[end] // "o"
print(fifthCharacter)

let range = start...end
let firstFive = playground[range] // "Hello"
print(firstFive)

// Bronze challenge
var empty: String = ""
let emptyStart = empty.startIndex
let emptyEnd = empty.endIndex
if emptyStart == emptyEnd {
    print("\t'empty' has no characters")
}
if empty.count == 0 {
    print("\t'empty' still has no characters")
}
if empty.isEmpty {
    print("\t'empty' isEmpty")
}

// Silver challenge ('hello' in unicode scalars)
print("\u{0068}\u{0065}\u{006c}\u{006c}\u{006f}")
