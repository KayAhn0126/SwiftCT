import Foundation

let num = Int(readLine()!)!
let arr = readLine()!.split(separator: " ").map { Int(String($0))! }
var resultArr = [[Int]](repeating: [Int](), count: num)

func go(_ from: Int, _ to: Int, _ level: Int) {
    if from == to || level == num {
        resultArr[level].append(arr[from])
        return
    }
    let midIndex = (from + to) / 2
    resultArr[level].append(arr[midIndex])
    go(from, midIndex - 1, level + 1)
    go(midIndex + 1, to, level + 1)
}

go(0, arr.count - 1, 0)
resultArr.enumerated().forEach {
    $0.element.enumerated().forEach {
        print($0.element, terminator: " ")
    }
    print("")
}
