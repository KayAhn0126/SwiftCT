# 3197 백조의 호수
- 구현
- 플러드 필

## 🍎 문제 접근
### 📖 처음에 접근 했던 방법
- 주난의 난 문제와 비슷해서 플러드 필 알고리즘으로 풀면 되겠다 생각했다.
- 시간초과 발생!
- 얼음을 물로 녹이고 백조가 서로 만나는지 탐색을 진행하는데 매번 탐색 할 때 마다 1500 * 1500 즉 , 220만번 연산을 해 시간초과의 원인이 된다.

### 📖 주의해야 할 점
- 현재 백조가 있는 위치도 물이다!
    - 백조는 물위에 떠 있다.
- 위에 설명할 것 처럼 시간초과를 방지하기 위해 백조가 탐색을 할 때 계속 처음부터 탐색하는 것이 아닌 백조도 마찬가지로 물에서 이동하다가 얼음을 마나면 얼음의 위치를 기억해 두었다가 한 턴(얼음이 물이되는 별개의 과정)이 끝나면 백조는 저장해 두었던 얼음의 위치부터 다시 다른 백조를 만나기 위한 탐색을 시작한다.
    - 백조가 다른 백조를 발견하면 flag를 올려 프레임 로직이 더 이상 작동하지 않게 해준다.
- 현재 얼음의 위치를 담은 큐 + 얼음을 만나면 다음에 녹이기 위해 담는 큐
- 백조 이동 큐 + 백조가 다른 백조를 찾기 위해서 탐색하다 발견한 얼음을 담을 큐.
    - 이 얼음들의 위치가 곧 다음 턴에 백조가 탐색을 시작할 부분.
    - **헷갈리지 말자. 백조의 BFS는 얼음을 녹이는것과 상관이 없다**
    - **얼음을 녹이는 로직은 따로 있고, 백조가 얼음을 만나 저장하는 이유는 단지 다음에 거기서 부터 시작해 이전에 탐색했던 부분들을 다시 탐색하는 행위를 막기 위해서다**

## 🍎 문제 풀이
```swift
import Foundation

let dy = [-1,0,1,0]
let dx = [0,1,0,-1]

let NM = readLine()!.split(separator: " ").map { Int(String($0))! }
let N = NM[0]
let M = NM[1]

var adjMatrix = [[Character]](repeating: [Character](), count: N)

for i in 0..<N {
    adjMatrix[i].append(contentsOf: readLine()!)
}

var waterLocation: [(Int, Int)] = []
var swanLocation: [(Int, Int)] = []

for i in 0..<N {
    for j in 0..<M {
        if adjMatrix[i][j] == "." {
            waterLocation.append((i,j))
        } else if adjMatrix[i][j] == "L" {
            swanLocation.append((i,j))
        }
    }
}

var found = false // 백조가 다른 백조를 찾았는지??

//MARK: 백조가 움직이는 것 관련
var swanQueue: [(Int,Int)] = [], swanIdx = 0
var nextSwanQueue: [(Int,Int)] = []
var swanVisited = [[Int]](repeating: [Int](repeating: 0, count: M), count: N)

swanQueue.append((swanLocation[0].0, swanLocation[0].1))
swanVisited[swanLocation[0].0][swanLocation[0].1] = 1

//MARK: 백조가 다른 백조를 찾는 로직 
func swanBFS() {
    while swanIdx < swanQueue.count {
        let swanLocation = swanQueue[swanIdx]; swanIdx += 1
        for i in 0..<4 {
            let ny = swanLocation.0 + dy[i]
            let nx = swanLocation.1 + dx[i]
            if ny < 0 || nx < 0 || ny >= N || nx >= M { continue }
            if swanVisited[ny][nx] != 0 { continue }
            
            swanVisited[ny][nx] = 1
            if adjMatrix[ny][nx] == "." {
                swanQueue.append((ny,nx))
            } else if adjMatrix[ny][nx] == "X" {
                nextSwanQueue.append((ny,nx))
            } else if adjMatrix[ny][nx] == "L" {
                found = true
                break
            }
        }
    }
}


//MARK: 물 주변의 얼음을 녹이는 과정
var waterLocationQueue: [(Int,Int)] = [], waterIdx = 0
var nextWaterLocationQueue: [(Int,Int)] = []

// 물의 위치 넣어주기
waterLocation.enumerated().forEach {
    waterLocationQueue.append(($0.element.0, $0.element.1))
}

// 백조가 있는곳(물 위)도 물 !
swanLocation.enumerated().forEach {
    waterLocationQueue.append(($0.element.0, $0.element.1))
}

//MARK: 얼음 녹이기 로직
func waterMeltsIceBFS() {
    while waterIdx < waterLocationQueue.count {
        let currentYX = waterLocationQueue[waterIdx]; waterIdx += 1
        for i in 0..<4 {
            let ny = currentYX.0 + dy[i]
            let nx = currentYX.1 + dx[i]
            if ny < 0 || nx < 0 || ny >= N || nx >= M { continue }
            if adjMatrix[ny][nx] == "X" {
                nextWaterLocationQueue.append((ny,nx))
                adjMatrix[ny][nx] = "."
            }
        }
    }
}

//MARK: 프레임 로직
var result = 0
while found == false {
    swanBFS()
    if found == false {
        waterMeltsIceBFS()
        swanQueue = nextSwanQueue
        swanIdx = 0
        waterLocationQueue = nextWaterLocationQueue
        waterIdx = 0
        nextSwanQueue = []
        nextWaterLocationQueue = []
        result += 1
    }
}
print(result)
```
