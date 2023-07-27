# 2665 미로만들기
- 그래프 BFS

## 🍎 문제 접근
- 처음에는 많이 헷갈렸다.
    - 지금까지 풀어왔던 문제들처럼 벽이 있어서 가지 말아야 하거나(일반 탐색 문제), 벽 부수고 이동하기 처럼 하나만 부수는 문제가 아닌 모든 노드를 탐색하면서 N-1, M-1 위치에 도달했을때 가장 적게 검은방을 부수고 오는 경우를 찾으면 되는 문제였다.

## 🍎 문제 풀이 및 전체 코드
- 자세한 설명은 주석에.
```swift
import Foundation

let dy = [-1,0,1,0]
let dx = [0,1,0,-1]

let x = Int(readLine()!)!
var adjMatrix = [[Int]](repeating: [Int](), count: x)
for i in 0..<x {
    adjMatrix[i].append(contentsOf: readLine()!.map { Int(String($0))! })
}

// 미리 모든 최소값을 max로 둬서 최소값으로 갱신이 가능 하게끔 해준다.
var visited = [[Int]](repeating: [Int](repeating: Int.max, count: x), count: x)

var bfsQueue: [(Int,Int)] = [], idx = 0
bfsQueue.append((0,0))
visited[0][0] = 0

func bfs() -> Int {
    while idx < bfsQueue.count {
        let current = bfsQueue[idx]; idx += 1

        let currentY = current.0
        let currentX = current.1

        // 현재 위치에서 4방향 탐색
        for i in 0..<4 {
            let ny = currentY + dy[i]
            let nx = currentX + dx[i]
            if ny < 0 || nx < 0 || ny >= x || nx >= x { continue }
            if adjMatrix[ny][nx] == 1 { // 다음 갈 곳이 흰색 방이라면, 현재 visited가 더 작은지 확인 후 갱신한다.
                if visited[ny][nx] > visited[currentY][currentX] {
                    visited[ny][nx] = visited[currentY][currentX]
                    bfsQueue.append((ny,nx))
                }
            } else {                    // 다음 갈 곳이 검은색 방이라면, 현재 visited에 1을 더한값이 더 작은지 확인 후 갱신한다.
                if visited[ny][nx] > visited[currentY][currentX] + 1 {
                    visited[ny][nx] = visited[currentY][currentX] + 1
                    bfsQueue.append((ny,nx))
                }
            }
        }
    }
    return visited[x-1][x-1]
}
print(bfs())
```

## 🍎 메인 로직 및 생각해야 할 점
- 검은방을 가장 적게 부수고 x-1, x-1에 도달하는 수를 구해야 하므로, visited를 모두 아주 크게 해놓고 다른 칸에 도달 할 때마다, 현재 가장 작게 도달하는 값으로 갱신한다.
- (x-1, x-1)위치에 나중에 들어오는값이 더 적을 수도 있다. 그렇기 때문에 큐를 다 뺄때까지 돌려야한다.
