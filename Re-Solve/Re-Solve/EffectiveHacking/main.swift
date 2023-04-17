import Foundation
let NM = readLine()!.split(separator: " ").map { Int(String($0))! }
let N = NM[0]
let M = NM[1]

var adjList = [[Int]](repeating: [Int](), count : N + 1)

for i in 0..<M {
    let byTrusted = readLine()!.split(separator: " ").map { Int(String($0))! }
    let by = byTrusted[0]
    let trusted = byTrusted[1]
    adjList[trusted].append(by)
}

var biggestArr = [Int](repeating: 0, count: N + 1)

var max = Int.min
func dfs(_ adjList: inout [[Int]], _ num: Int, _ visited: inout [Bool], _ tempResult: inout Int) {
    visited[num] = true
    for i in adjList[num] {
        if visited[i] == true { continue }
        tempResult += 1
        dfs(&adjList, i, &visited, &tempResult)
    }
}

var result = 0
for i in 1...N {
    var tempResult = 0
    var visited = [Bool](repeating: false, count: N + 1)
    dfs(&adjList, i, &visited, &tempResult)
    biggestArr[i] = tempResult
    max = tempResult > max ? tempResult : max
}

var resultArr = [Int]()
for i in 1...N {
    if biggestArr[i] == max {
        resultArr.append(i)
    }
}

resultArr.enumerated().forEach {
    print($0.element, terminator: " ")
}
print("")
