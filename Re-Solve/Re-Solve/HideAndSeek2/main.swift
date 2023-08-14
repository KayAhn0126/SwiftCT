/*
 숨바꼭질 문제와 비슷, 다만 가장 빠른 시간이 몇 초인지 그리고 몇 가지 방법이 있는지 구해야한다.
 */

import Foundation

let NK = readLine()!.split(separator: " ").map { Int(String($0))! }
let N = NK[0]
let K = NK[1]

var visited = [Int](repeating: 0, count: 200001)
var waysToGetPoint = [Int](repeating: 0, count: 200001)

var bfsQueue = [Int](), idx = 0
bfsQueue.append(N)
visited[N] = 1
waysToGetPoint[N] = 1

while idx < bfsQueue.count {
    let current = bfsQueue[idx]; idx += 1

    let temp = [current - 1, current + 1, current * 2]
    for i in 0..<3 {
        let next = temp[i]
        if next < 0 || next > 200000 { continue }
        if visited[next] == 0 { // 처음 도달했다면
            visited[next] = visited[current] + 1
            waysToGetPoint[next] += waysToGetPoint[current]
            bfsQueue.append(next)
        } else if visited[next] == visited[current] + 1 {
            waysToGetPoint[next] += waysToGetPoint[current]
        }
    }
}
print(visited[K] - 1)
print(waysToGetPoint[K])
