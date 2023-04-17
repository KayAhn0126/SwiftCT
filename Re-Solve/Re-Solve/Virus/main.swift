import Foundation

let node = Int(readLine()!)!
let edge = Int(readLine()!)!

var adjList = [[Int]](repeating: [Int](), count: node + 1)
var visited = [Bool](repeating: false, count: node + 1)

for i in 0..<edge {
    let ft = readLine()!.split(separator: " ").map { Int(String($0))! }
    let from = ft[0]
    let to = ft[1]
    adjList[from].append(to)
    adjList[to].append(from)
}

var result = 0
func dfs(_ num: Int) {
    for i in adjList[num] {
        if visited[i] == true { continue }
        visited[i] = true
        result += 1
        dfs(i)
    }
}

visited[1] = true
dfs(1)
print(result)
