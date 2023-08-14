/*
 지문 해석:
    수빈이가 동생을 찾는다.
    최단시간과 어떻게 동생을 찾았는지 경로도 같이 출력해라.
 
 문제 접근:
    각 1초이기 때문에 BFS
    tracking 배열 사용
    5 = 0
    10 = 5
    9 = 10
    18 = 9
    17 = 18
 */

import Foundation

let NK = readLine()!.split(separator: " ").map { Int(String($0))! }
let N = NK[0]
let K = NK[1]

var visited = [Int](repeating: 0, count: 200001)
var tracking = [Int](repeating: 0, count: 200001)

var bfsQueue = [Int](), idx = 0
bfsQueue.append(N)
visited[N] = 1
tracking[N] = N

while idx < bfsQueue.count {
    let current = bfsQueue[idx]; idx += 1
    
    if current == K {
        break
    }
    
    let temp = [current - 1, current + 1, current * 2]
    for i in 0..<3 {
        let next = temp[i]
        if next < 0 || next > 200000 { continue }
        if visited[next] != 0 { continue }
        if tracking[next] != 0 { continue }
        visited[next] = visited[current] + 1
        tracking[next] = current
        bfsQueue.append(next)
    }
}

print(visited[K] - 1)
var prev = K
var arr: [Int] = [prev]
if N != K {
    while true {
        let x = tracking[prev]
        if x == N {
            arr.append(N)
            break
        }
        arr.append(x)
        prev = x
    }
}
var strArr = arr.reversed().map { String($0) }
print(strArr.joined(separator: " "))
