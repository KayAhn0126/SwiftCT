import Foundation

// 무방향 -> 양방향
// 인접 정점은 오름차순으로 방문한다.

let NMV = readLine()!.split(separator: " ").map { Int(String($0))! }
let N = NMV[0]
let M = NMV[1]
let V = NMV[2]

var adjList = [[Int]](repeating: [Int](), count: N + 1)
var visited = [Int](repeating: 0, count: N + 1)

for _ in 0..<M {
    let ft = readLine()!.split(separator: " ").map { Int(String($0))! }
    let f = ft[0]
    let t = ft[1]
    adjList[f].append(t)
    adjList[t].append(f)
}

for i in 0..<N+1 {
    adjList[i].sort()
}

var count = 2
func dfs(_ num: Int) {
    for i in adjList[num] {
        if visited[i] != 0 { continue }
        visited[i] = count
        count += 1
        dfs(i)
    }
}

visited[V] = 1
dfs(V)
visited.enumerated().forEach {
    if $0.offset != 0 {
        print($0.element)
    }
}

