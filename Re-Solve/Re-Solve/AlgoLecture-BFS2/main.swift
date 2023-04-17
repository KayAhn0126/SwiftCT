import Foundation


let NMV = readLine()!.split(separator: " ").map { Int(String($0))! }

let N = NMV[0]
let M = NMV[1]
let V = NMV[2]

var adjList = [[Int]](repeating: [Int](), count: N + 1)
var visited = [Int](repeating: 0, count: N + 1)

for i in 0..<M {
    let ft = readLine()!.split(separator: " ").map { Int(String($0))! }
    let f = ft[0]
    let t = ft[1]
    adjList[f].append(t)
    adjList[t].append(f)
}

for i in 0...N {
    adjList[i].sort(by: >)
}

var queue = [Int](), idx = 0
var count = 2
func bfs() {
    while idx < queue.count {
        let current = queue[idx]; idx += 1
        for i in adjList[current] {
            if visited[i] != 0 { continue }
            visited[i] = count
            count += 1
            queue.append(i)
        }
    }
}

visited[V] = 1
queue.append(V)
bfs()

visited.enumerated().forEach {
    if $0.offset != 0 {
        print($0.element)
    }
}
