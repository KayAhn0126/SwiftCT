# 2573 빙산
- 그래프 탐색
- 치즈와 비슷한 문제

## 🍎 문제 접근
- 이런 문제가 나오면 항상 "무엇이 기준이 되는가?" 를 생각해야 한다.
- 기준에 따라 달라지는 풀이
    - 물의 위치를 기반으로 빙산을 녹여 풀어가는 과정(내가 푼 방식)
    - 빙산의 위치를 기반으로 빙산의 상우하좌 탐색으로 빙산을 녹여 풀어가는 과정
- 치즈 문제처럼 한번의 사이클이 흘러가고 나면 맵에서 Connected Component가 총 몇개 존재하는지 구한다.
- 문제에서는 빙산이 최초로 분리되는 시간을 출력하면 되는데 이 말은 곧, getConnectedComponent의 반환값이 2 이상일때 프로그램의 작동을 멈추면 된다.

## 🍎 문제 풀이
- 초기에 물의 위치를 가지는 리스트를 bfsQueue에 넣어준다.
- 이 bfsQueue에서 나온 물의 위치를 4방향 탐색하면서 다음 위치가 0이 아닌 어떤 수(빙산)를 만나면 해당 수를 (해당 수 - 1)로 바꿔준다.
    - 그리고 현재 물의 위치를 새로운 water 리스트에 넣어준다. 왜? -> 다시 빙산을 만날수 있다.
### 📖 전체 코드
```swift
import Foundation

let dy = [-1,0,1,0]
let dx = [0,1,0,-1]

let NM = readLine()!.split(separator: " ").map { Int(String($0))! }
let N = NM[0]
let M = NM[1]

var adjMatrix = [[Int]](repeating: [Int](), count: N)
for i in 0..<N {
    adjMatrix[i].append(contentsOf: readLine()!.split(separator: " ").map { Int(String($0))! })
}

var visited = [[Bool]](repeating: [Bool](repeating: false, count: M), count: N)

func visitedClear() {
    for i in 0..<N {
        for j in 0..<M {
            visited[i][j] = false
        }
    }
}

// 실제 CC 구하는 함수
func connectedComponentDFS(_ y: Int, _ x: Int) {
    for i in 0..<4 {
        let ny = y + dy[i]
        let nx = x + dx[i]
        if ny < 0 || nx < 0 || ny >= N || nx >= M { continue }
        if visited[ny][nx] == true { continue }
        if adjMatrix[ny][nx] == 0 { continue }
        visited[ny][nx] = true
        connectedComponentDFS(ny,nx)
    }
}

// CC의 총 갯수를 반환하는 함수
func getConnectedComponent() -> Int {
    var result = 0
    for i in 0..<N {
        for j in 0..<M {
            if adjMatrix[i][j] == 0 || visited[i][j] == true { continue }
            connectedComponentDFS(i,j)
            result += 1
        }
    }
    visitedClear()
    return result
}

var bfsQueue = [Location](), idx = 0
var result = 0

//MARK: 초기 얼음위치 넣어주기
for i in 0..<N {
    for j in 0..<M {
        if adjMatrix[i][j] == 0 {
            bfsQueue.append(Location(y: i, x: j))
        }
    }
}

// 아래 while문에서 Set의 타입으로 사용하기 위한 Hashable 프로토콜 준수
struct Location: Hashable {
    var y: Int
    var x: Int
}

while true {
    // 중복 방지를 위한 Set 컨테이너 사용 아래에서 자세하게 설명
    var nextIceList = Set<Location>()
    while idx < bfsQueue.count {
        let currentLocation = bfsQueue[idx]; idx += 1
        for i in 0..<4 {
            let ny = currentLocation.y + dy[i]
            let nx = currentLocation.x + dx[i]
            if ny < 0 || nx < 0 || ny >= N || nx >= M { continue }
            let nextLocationNumber = adjMatrix[ny][nx]
            if nextLocationNumber == 0 { continue }
            if nextLocationNumber >= 1 {
                nextIceList.insert(Location(y: currentLocation.y, x: currentLocation.x))
                adjMatrix[ny][nx] = nextLocationNumber - 1
                if nextLocationNumber - 1 == 0 {
                    nextIceList.insert(Location(y: ny, x: nx))
                }
            }
        }
    }
    bfsQueue = Array(nextIceList)
    idx = 0
    result += 1
    let connectedComponent = getConnectedComponent()
    if connectedComponent >= 2 {
        break
    } else if connectedComponent == 0 {
        result = 0
        break
    }
}
print(result)  
```

### 📖 중복 방지 로직
```bash
0 0 0 0 0 0 0
0 2 4 5 3 0 0
0 3 0 2 5 2 0
0 7 6 2 4 0 0
0 0 0 0 0 0 0
```
- 2,2를 보면 4방향 모두 빙산이라서 다음 water 리스트에 2,2가 총 4번 들어간다.
- 이것을 막기 위해서 먼저 Set에 집어넣고 다시 bfsQueue에 대입 할때는 Array로 강제 형변환 후 대입.
- 만약 (해당 수 - 1)의 값이 0으로 도달하면 water 리스트에 넣어준다.

### 📖 빙산이 녹아서 CC를 구할수 없는 상황
- getConnectedComponent의 리턴값이 2 이상이면 break 후 result 출력
- 아래와 같은 상황에서는 빙산이 녹아서 커넥티드 컴포넌트를 구할 수 없으므로 result를 0으로 대입 후 break
```bash
 0 0 0 0
 0 1 1 0
 0 1 1 0
 0 0 0 0
```

## 🍎 생각해봤던점
- 비트마스킹으로 풀 수 있을까?
    - 방문배열이 2차원이라 불가능!
- 기준이 만약 물이 아닌 빙산이였다면..?
     - 빙산 위치를 리스트에 넣어놓고, 리스트를 요소가 0을 만나면 현재 값을 -1한다. 만약 4방향 모두 0 이라면 connected component라는 뜻이니 connected component의 갯수를 늘려준다. + 이후 처리..
     - 빙산을 녹이는것과 cc까지 한번에 처리할 수 있을것 같다.
