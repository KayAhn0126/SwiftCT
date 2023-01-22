# 4179 불!

## 🍎 키워드
- bfs
- 구현

## 🍎 문제 정리
1. 불(F)가 여러곳에 있을 수 있다. or 불이 하나도 없을 수 있다.
2. 불은 4방향으로 확산된다.
3. 지훈이는 가장자리에서 탈출할 수 있다.
4. 지훈이가 탈출할 수 없는 경우는 IMPOSSIBLE 출력.
 
## 🍎 탈출 조건
1. 지훈이가 가려는곳이 불 보다 빠른경우.
2. 지훈이가 가장자리에 위치.
 
## 🍎 문제 접근
1. 맵에서 F의 위치를 모두 찾고 BFS + 최단거리 구하기
2. 맵에서 J(지훈)의 위치에서 BFS + 최단거리 구하면서 불 피하기

## 🍎 코드 해석

### 📖 문제 해결에 필요한 배열 만들기
```swift
let INF = 987654321

var adjMatrix = [[Character]](repeating: [Character](), count: R)
var fireVisited = [[Int]](repeating: [Int](repeating: INF, count: C), count: R)
var jihoonVisited = [[Int]](repeating: [Int](repeating: 0, count: C), count: R)
```
- 보통은 배열을 선언하면 0으로 초기화 하는데 왜 fireVisited는 INF로 초기화 했을까?
    - 지훈이는 불이 번지는 시간(fire의 최단거리)보다 작은곳으로만 움직일 수 있다. 만약 0으로 초기화 하면 F(fire)가 하나도 없는 경우, fireVisited의 모든 요소는 0이므로 지훈이는 움직일 수 있는 상황임에도 움직일 수 없다.

### 📖 입력 받은 배열에서 불, 지훈의 위치 확인하기
```swift
for i in 0..<R {
    for j in 0..<C {
        if adjMatrix[i][j] == "F" {
            fireVisited[i][j] = 1
            fireLocationQueue.enqueue((i,j))
        } else if adjMatrix[i][j] == "J" {
            jihoonVisited[i][j] = 1
            jihoonLocationQueue.enqueue((i,j))
        }
    }
}
```
### 📖 fireVisited 배열에 불을 확산시키는 코드
```swift
while !fireLocationQueue.isEmpty {
    let location = fireLocationQueue.dequeue()!
    let locY = location.0
    let locX = location.1
    for i in 0..<4 {
        let ny = locY + dy[i]
        let nx = locX + dx[i]
        if checkInRange(ny, nx) { continue }
        if fireVisited[ny][nx] != INF || adjMatrix[ny][nx] == "#" { continue } // 이미 방문했거나 벽이라면 continue
        fireVisited[ny][nx] = fireVisited[locY][locX] + 1
        fireLocationQueue.enqueue((ny,nx))
    }
}
```

### 📖 지훈이가 다닐수 있는 경로를 구하면서 불이 퍼지는 속도와 비교하기
```swift
var result = 0
while !jihoonLocationQueue.isEmpty {
    let location = jihoonLocationQueue.dequeue()!
    let locY = location.0
    let locX = location.1
    if escapeCheck(locY, locX) { // 맵의 가장자리로 나오면 빠져나갈수 있도록 만든 코드.
        result = jihoonVisited[locY][locX]
        break
    }
    for i in 0..<4 {
        let ny = locY + dy[i]
        let nx = locX + dx[i]
        if checkInRange(ny, nx) { continue }
        if jihoonVisited[ny][nx] != 0 || adjMatrix[ny][nx] == "#" { continue }
        if jihoonVisited[locY][locX] + 1 >= fireVisited[ny][nx] { continue }
        jihoonVisited[ny][nx] = jihoonVisited[locY][locX] + 1
        jihoonLocationQueue.enqueue((ny,nx))
    }
}
```
- 지훈이가 다음으로 갈 곳의 불 속도가 지훈이의 속도보다 느려야 하는데, 만약
- if jihoonVisited[ny][nx] >= fireVisited[ny][nx] { continue } 와 같은 코드를 사용 한다면 눈으로 읽을때는 맞다고 생각할 수 있지만, jihoonVisited[ny][nx]가 값을 설정해 주기 전인 0으로 설정되어 있으므로 현재 상태인 jihoonVisited[locY][locX] + 1과 비교해야한다.
- 어차피 jihoonVisited[locY][locX] + 1은 jihoonVisited[ny][nx]와 같다.

## 🍎 다시 생각해볼것.
- 불이 하나도 없는 상황(예외 케이스)도 생각하는 연습
- 
