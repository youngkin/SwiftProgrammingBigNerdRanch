import Cocoa

var bucketList: [String] = [] // Can initialize an array as an empty array
var bklist =  [String]() // Alternative initialization syntax


bucketList.append("Climb Mount Everest")
bucketList

var bucketList2: Array<String> = []
bucketList2.append("Hike to Machu Pichu")

let bucketList3 = ["Run with the bulls"]

bucketList.append(bucketList2[0])
bucketList.append(bucketList3[0])

bucketList3

let dleted = bucketList.remove(at: 1)
dleted
bucketList

// Bronze Challenge
print("Found \(bucketList.count) items in list. List contains \(bucketList[0...1])")

// Silver Challenge
var i = bucketList.count - 1
while i >= 0 {
    print("BucketList[\(i)]: \(bucketList[i])")
    i -= 1
}

for item in bucketList.reversed() {
    print("BucketList item: \(item)")
}

// Gold Challenge
if let idx = bucketList.firstIndex(of: "Climb Mount Everest") {
    print("Item offset by 1 of first element: \(bucketList[idx+1])")
}
