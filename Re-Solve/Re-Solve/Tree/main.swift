import Foundation

// -1은 최상위 노드
// 현재 인덱스를 현재 값에 넣어준다.
let num = Int(readLine()!)!

var arr = readLine()!.split(separator: " ").map { Int(String($0))! }
let nodeToRemove = Int(readLine()!)!

var adjList = [[Int]](repeating: [Int](), count: num)
var root = 0

for i in 0..<arr.count {
    if arr[i] == -1 {
        root = i
    } else {
        if i == nodeToRemove { continue }
        adjList[arr[i]].append(i)
    }
}

var visited = [Bool](repeating: false, count: num)

var result = 0
func dfs(_ num: Int) {
    if adjList[num].count == 0 { result += 1; return }
    for i in adjList[num] {
        if visited[i] == true { continue }
        visited[i] = true
        dfs(i)
    }
}

if root == nodeToRemove {
    print(0)
} else {
    dfs(root)
    print(result)
}

