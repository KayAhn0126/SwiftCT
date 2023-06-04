import Foundation

// 이분 탐색이 필요한가?
let N = Int(readLine()!)!

var countArr = [Int](repeating: 0, count: 20000001)

let currentCards = readLine()!.split(separator: " ").map { Int(String($0))! }

for element in currentCards {
    countArr[element + 10000000] += 1
}

let findNum = Int(readLine()!)!
let findNumArr = readLine()!.split(separator: " ").map { Int(String($0))! }

findNumArr.enumerated().forEach {
    print(countArr[$0.element + 10000000], terminator: " ")
}
print("")
