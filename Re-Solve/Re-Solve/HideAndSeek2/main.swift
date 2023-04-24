import Foundation

let NK = readLine()!.split(separator: " ").map { Int(String($0))! }
let N = NK[0]
let K = NK[1]

var visited = [Int](repeating: 0, count: 100001)
var waysToFind = [Int](repeating: 0, count: 100001)
visited[N] = 1
waysToFind[N] = 1

let walk = [-1,1,2]
var bfsQueue = [Int](), idx = 0
bfsQueue.append(N)

if N == K {
    print(0)
    print(1)
} else {
    while idx < bfsQueue.count {
        let current = bfsQueue[idx]; idx += 1
        var next = 0
        for i in 0..<3 {
            if i == 0 || i == 1 {
                next = current + walk[i]
            } else {
                next = current * walk[i]
            }
            if next < 0 || next > 100000 { continue }
            if visited[next] == 0 { // next에 현재 최단거리가 들어감
                visited[next] = visited[current] + 1
                waysToFind[next] += waysToFind[current]
                bfsQueue.append(next)
            } else if visited[next] == visited[current] + 1 {
                waysToFind[next] += waysToFind[current]
            }
        }
    }
    print(visited[K] - 1)
    print(waysToFind[K])
}

