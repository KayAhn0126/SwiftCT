import Foundation

let totalPickNumber = readLine()!.split(separator: " ").map { Int(String($0))! }
let total = totalPickNumber[0]
let pick = totalPickNumber[1]

var nameNum: [String: Int] = [:]
var numName: [Int: String] = [:]

for i in 1...total {
    let temp = readLine()!
    nameNum[temp] = i
    numName[i] = temp
}

for i in 0..<pick {
    let temp = readLine()!
    if Int(temp) == nil {
        print(nameNum[temp]!)
    } else {
        print(numName[Int(temp)!]!)
    }
}
