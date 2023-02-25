# 7562 나이트의 이동
- 비슷한 문제로
    - [뮤탈리스크](https://www.acmicpc.net/problem/12869)
    - [숨바꼭질](https://www.acmicpc.net/problem/1697)

## 🍎 문제 접근
- 뮤탈리스크와 숨바꼭질 문제처럼 "현재 위치에서 나이트가 이동할 수 있는 위치로 가면서 최단거리"를 구하면 된다.
    - 물론 이미 방문 했거나 갈 수 없는 곳이라면 continue

## 🍎 전체 코드
```swift
import Foundation

let testCase = Int(readLine()!)!
let possibleLocation: [(Int,Int)] = [(-1,-2),(-2,-1),(-2,1),(-1,2),(1,2),(2,1),(2,-1),(1,-2)]


for _ in 0..<testCase {
    let N = Int(readLine()!)!
    var visited = [[Int]](repeating: [Int](repeating: 0, count: N), count: N)
    let fromLocation = readLine()!.split(separator: " ").map { Int(String($0))! }
    let fromY = fromLocation[0]
    let fromX = fromLocation[1]
    let toLocation = readLine()!.split(separator: " ").map { Int(String($0))! }
    let toY = toLocation[0]
    let toX = toLocation[1]
    
    var bfsQueue = [(Int,Int)](), idx = 0
    
    visited[fromY][fromX] = 1
    bfsQueue.append((fromY, fromX))
    // bfs
    while idx < bfsQueue.count {
        let currentLocation = bfsQueue[idx]; idx += 1
        let currentY = currentLocation.0
        let currentX = currentLocation.1
        if currentY == toY && currentX == toX {
            print(visited[currentY][currentX] - 1)
            break
        }
        for i in possibleLocation {
            let ny = currentY + i.0
            let nx = currentX + i.1
            if ny < 0 || nx < 0 || ny >= N || nx >= N { continue }
            if visited[ny][nx] > 0 { continue }
            visited[ny][nx] = visited[currentY][currentX] + 1
            bfsQueue.append((ny,nx))
        }
    }
}
```
- 일반적으로 그래프 탐색에서 사용하는
- dy = [-1,0,1,0]
- dx = [0,1,0,-1] 처럼
- let possibleLocation: [(Int,Int)] = [(-1,-2),(-2,-1),(-2,1),(-1,2),(1,2),(2,1),(2,-1),(1,-2)]을 만들어서 현재 위치에서 옮기면서 최단거리를 구하면 된다.
