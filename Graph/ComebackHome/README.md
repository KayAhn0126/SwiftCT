# 1189 컴백홈
- 백트래킹 + 가지치기
- BFS + 최단거리

## 🍎 문제 접근
- N행 M열이 주어진다고 한다
    - 시작점은 (N-1, 0)
    - 종료점은 (0, M-1)
- T는 가지 못한다.

## 🍎 문제 풀이
- 위 예제는 한수가 집에 돌아갈 수 있는 모든 경우를 나타낸 것이다. T로 표시된 부분은 가지 못하는 부분이다. 문제는 R x C 맵에 못가는 부분이 주어지고 **- 위 예제는 한수가 집에 돌아갈 수 있는 모든 경우를 나타낸 것이다. T로 표시된 부분은 가지 못하는 부분이다. 문제는 R x C 맵에 못가는 부분이 주어지고 거리 K가 주어지면 한수가 집까지도 도착하는 경우 중 거리가 K인 가짓수를 구하는 것이다.**
- 다음 방문할 곳이 visited 배열에서 방문한 곳이 아니면 방문하고 원상태로 돌리기

## 🍎 전체 코드
```swift
import Foundation

// 4방향 설정
let dy = [-1,0,1,0]
let dx = [0,1,0,-1]

// 유저 입력
let RCK = readLine()!.split(separator: " ").map { Int(String($0))! }
let R = RCK[0]
let C = RCK[1]
let K = RCK[2]

/*
 재귀를 이용한 백트래킹
 5x5에서 각 위치에서 전체 탐색 -> 시간복잡도는 5 * 5 * 25 = 625
 */

var map = [[Character]](repeating: [Character](), count: R)
var visited = [[Int]](repeating: [Int](repeating: 0, count: C), count: R)


for i in 0..<R {
    map[i].append(contentsOf: readLine()!.map { Character(String($0)) })
}

// 재귀함수를 통한 백트래킹
func search(_ y: Int, _ x: Int) -> Int {
    // 종료점에 도달했을 때, 
    if y == 0 && x == C-1 {
        // 문제에서 요구한 가짓수와 같다면 도달하는 수를 하나 추가
        if K == visited[y][x] {
            return 1
        }
        return 0
    }
    var result = 0
    for i in 0..<4 {
        let ny = y + dy[i]
        let nx = x + dx[i]
        if ny < 0 || nx < 0 || ny >= R || nx >= C || visited[ny][nx] > 0 || map[ny][nx] == "T" { continue }
        // 방문처리
        visited[ny][nx] = visited[y][x] + 1
        // 탐색 후 반환 받은 값을 result에 넣어줌
        result += search(ny,nx)
        // 동시에 실행중인 BFS가 탐색할 수 있도록 미방문 처리
        visited[ny][nx] = 0
    }
    return result
}
visited[R-1][0] = 1
print(search(R-1, 0))

```
