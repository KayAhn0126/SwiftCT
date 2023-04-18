import Foundation

let total = Int(readLine()!)!
let fromTo = readLine()!.split(separator: " ").map { Int(String($0))! }

let from = fromTo[0]
let to = fromTo[1]

let edge = Int(readLine()!)!
var adjList = [[Int]](repeating: [Int](), count: total + 1)
var visited = [Int](repeating: 0, count: total + 1)

for i in 0..<edge {
    let xy = readLine()!.split(separator: " ").map { Int(String($0))! }
    let x = xy[0]
    let y = xy[1]
    adjList[x].append(y)
    adjList[y].append(x)
}

var queue = [Int](), idx = 0

func bfs() {
    while idx < queue.count {
        let current = queue[idx]; idx += 1
        for i in adjList[current] {
            if visited[i] != 0 { continue }
            visited[i] = visited[current] + 1
            queue.append(i)
        }
    }
}

queue.append(from)
visited[from] = 1
bfs()
if visited[to] == 0 {
    print(-1)
} else {
    print(visited[to] - 1)
}
