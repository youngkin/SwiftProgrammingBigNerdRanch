import Cocoa

print("First 'for' loop")
var myFirstInt: Int = 0

for _ in 1...5 {
    myFirstInt += 1
    print("\t" + String(myFirstInt))
}

print("\n\n'for' loops with 'where' clauses")
for i in 1...10 where i % 3 == 0 {
    print("\t\(i): FIZZ")
}

print("\n\nSilver Challenge - FIZZ-BUZZ")
for i in 1...25 {
    if i % 3 == 0 && i % 5 == 0 {
        print("\tFIZZ-BUZZ")
    } else if i % 3 == 0 {
        print("\tFIZZ")
    } else if i % 5 == 0 {
        print("\tBUZZ")
    } else {
        print("\t\(i)")
    }
}

print("\n\nSilver Challenge with 'switch'")
for i in 1...25 {
    switch i {
    case _ where i % 3 == 0 && i % 5 == 0:
        print("\tFIZZ-BUZZ")
    case _ where i % 3 == 0:
        print("\tFIZZ")
    case _ where i % 5 == 0:
        print("\tBUZZ")
    default:
        print("\t\(i)")
    }
}
