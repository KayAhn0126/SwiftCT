# 14497 주난의 난
- 플러드 필 알고리즘

## 🍎 문제 접근
### 📖 처음에 접근한 방법
- 탐색하다 만나는 값이 0일때는 이전 visted[ny][nx] = visited[y][x]. 즉, 그대로 두고..
- 만약 1을 만나게 되면 visited[ny][nx] = visited[y][x] + 1을 해줬다.₩
- 일반 BFS + 최단거리를 사용해 "#"을 만나면 종료하는 방식으로 풀었는데 3%에서 틀렸다고 나온다.

### 📖 Flood - Fill 알고리즘
- 다차원 배열에서 어떤 칸과 연결된 영역을 찾는 알고리즘
    - 그림판의 채우기 기능
    - 지뢰 찾기에서 지뢰를 클릭했을 때 퍼지는 것

## 🍎 Flood - Fill 알고리즘을 이용한 풀이
- **1을 만나던 #을 만나던 만나면 0으로 바꿀것이다.**
- 0만을 담을 Queue 생성 -> 여기서는 zeroQueue라고 사용할 것
- 1만을 담을 Queue 생성 -> 여기서는 oneQueue라고 사용할 것
- 먼저 0이 담긴 zeroQueue를 통해 BFS 탐색을 시작한다.
- 도중 1을 만나면 일단! oneQueue에 담아둔다.
    - zeroQueue에 있는 위치들을 다 탐색하면 oneQueue를 zeroQueue에 담아준다.
- 더 자세한 설명은 코드를 통해 알아보자

## 🍎 전체 코드
```swift
import Foundation

let NM = readLine()!.split(separator: " ").map { Int(String($0))! }
let N = NM[0]
let M = NM[1]

let locations = readLine()!.split(separator: " ").map { Int(String($0))! }
// 주난의 위치
let junanLocationY = locations[0] - 1
let junanLocationX = locations[1] - 1

// 도둑의 위치
let theftLocationY = locations[2] - 1
let theftLocationX = locations[3] - 1

var adjMatrix = [[Character]](repeating: [Character](), count: N)

for i in 0..<N {
    adjMatrix[i].append(contentsOf: readLine()!)
}

var visited = [[Int]](repeating: [Int](repeating: 0, count: M), count: N)

// 방향
let dy = [-1,0,1,0]
let dx = [0,1,0,-1]

// 0의 위치를 담아두었다가 먼저 탐색하는 큐
var zeroBfsQueue = [(Int,Int)](), zeroIndex = 0
visited[junanLocationY][junanLocationX] = 1
zeroBfsQueue.append((junanLocationY, junanLocationX))

var result = 0
// 도둑의 위치가 "0"이 아닐때 까지
while adjMatrix[theftLocationY][theftLocationX] != "0" {
    result += 1 // 1을 만날때마다 올라간다. -> 만약 나중에 다시 이 설명을 본다면 이해가 안될수 있으니 
    var oneBfsQueue = [(Int,Int)]()
    while zeroIndex < zeroBfsQueue.count { // zeroQueue가 빌 때까지 진행된다.
        let currentLocation = zeroBfsQueue[zeroIndex]; zeroIndex += 1
        let currentLocationY = currentLocation.0
        let currentLocationX = currentLocation.1
        for i in 0..<4 {
            let ny = currentLocationY + dy[i]
            let nx = currentLocationX + dx[i]
            if ny < 0 || nx < 0 || ny >= N || nx >= M { continue }
            if visited[ny][nx] != 0 { continue } // 이미 방문한 적이 있다면 continue
            visited[ny][nx] = result
            if adjMatrix[ny][nx] != "0" { // 1을 만나게 되면
                adjMatrix[ny][nx] = "0" // 해당 adjMatrix[ny][nx]를 0으로 바꾼 후,
                oneBfsQueue.append((ny,nx)) // oneBfsQueue에 넣는다.
                                            // oneBfsQueue는 zeroBfsQueue가 모두 종료되면 zeroBfsQueue에 대입한다.
            } else {
                zeroBfsQueue.append((ny,nx))
            }
        }
    }
    // 0의 위치들만 들어있는 zeroBfsQueue를 다 탐색하고 나면 oneBfsQueue의 위치들을 탐색하기 시작한다.
    zeroBfsQueue = oneBfsQueue
    zeroIndex = 0 // index를 통한 Queue 구현이므로 zeroIndex 또한 마찬가지로 0으로 초기화 해주어야 한다.
}
print(visited[theftLocationY][theftLocationX])
```
