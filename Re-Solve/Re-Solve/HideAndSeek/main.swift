import Foundation

// 범위 0부터 100,000까지

let NK = readLine()!.split(separator: " ").map { Int(String($0))! }
let N = NK[0]
let K = NK[1]

var visited = [Int](repeating: 0, count: 100001)
visited[N] = 1

var walk = [-1,1,2]

var bfsQueue = [Int](), idx = 0
bfsQueue.append(N)

while idx < bfsQueue.count {
    let current = bfsQueue[idx]; idx += 1
    if current == K {
        print(visited[current] - 1)
        break
    }
    for i in 0..<3 {
        var next = 0
        if i == 0 || i == 1 {
            next = current + walk[i]
        } else {
            next = current * walk[i]
        }
        if next < 0 || next > 100000 { continue }
        if visited[next] != 0 { continue }
        visited[next] = visited[current] + 1
        bfsQueue.append(next)
    }
}
