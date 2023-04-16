import Foundation

let NEV = readLine()!.split(separator: " ").map { Int(String($0))! }
let N = NEV[0]
let E = NEV[1]
let V = NEV[2]

var adjList = [[Int]](repeating: [Int](), count: N + 1)

for i in 0..<E {
    let fromTo = readLine()!.split(separator: " ").map { Int(String($0))! }
    let from = fromTo[0]
    let to = fromTo[1]
    adjList[from].append(to)
    adjList[to].append(from)
}

for i in 0..<N + 1 {
    adjList[i].sort()
}

var visited = [Int](repeating: 0, count: N + 1)

func clearVisited() {
    visited = [Int](repeating: 0, count: N + 1)
}

var resultDFS = [Int]()
var resultBFS = [Int]()

// recursion
func dfs(_ num: Int) {
    visited[num] = 1
    resultDFS.append(num)
    for i in adjList[num] {
        if visited[i] == 1 { continue }
        dfs(i)
    }
}

// Queue
var queue = [Int](), idx = 0
func bfs(_ num: Int) {
    while idx < queue.count {
        let currentNode = queue[idx]; idx += 1
        for i in adjList[currentNode] {
            if visited[i] == 1 { continue }
            visited[i] = 1
            queue.append(i)
            resultBFS.append(i)
        }
    }
}

dfs(V)
clearVisited()
queue.append(V)
visited[V] = 1
resultBFS.append(V)
bfs(V)

resultDFS.enumerated().forEach {
    print($0.element, terminator: " ")
}
print("")
resultBFS.enumerated().forEach {
    print($0.element, terminator: " ")
}
