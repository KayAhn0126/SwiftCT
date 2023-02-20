# 14502 연구소

## 🍎 키워드
- 시간복잡도 계산하기
- 설계
- dfs
- 조합

## 🍎 시간 복잡도 계산
- N,M <= 8
    - 기둥 세개 세우기 -> 64C3
        - 정확히는 (64 - 바이러스 숫자 - 원래 기둥 숫자) C 3 이다.
    - 맵 탐색 64
    - 영역 카운팅 64
    - 64C3 * (64 + 64)
    - (64 * 63 * 62) / (3 * 2) * 128 =~ 4320000
    - 최대 연산 횟수가 1000만

## 🍎 문제 풀이 설계
- 지문에서 주어진 조건
    - 0 바이러스 또는 벽이 생길수 있는 칸
    - 1 벽
    - 2 바이러스
- 3개의 벽을 어떻게 세울것인지?
    - 64C3 조합으로 세움
- 바이러스는 어떻게 퍼뜨릴 것인지?
    - dfs
- 안전지역 탐색은 어떻게 할것인지?
    - 2중 for문

## 🍎 문제 해결을 위한 세분화 과정
- 1. 입력받은 2차원 배열에서 바이러스(2)와 공백(0)의 위치를 각각 저장한다.
- 2. 3개의 벽을 세울때 공백들의 위치를 참고해서 조합 만들기
- 3. 만들어진 조합을 가지고 벽 세워주기
- 4. 벽이 세워진 맵으로 바이러스 퍼뜨리기
- 5. 세팅된 맵에서 퍼뜨려진 바이러스가 없는 칸의 갯수 세기

## 🍎 전체 코드
```swift
import Foundation

let dy = [-1,0,1,0]
let dx = [0,1,0,-1]

let NM = readLine()!.split(separator: " ").map { Int(String($0))! }
let N = NM[0]
let M = NM[1]

var adjMatrix = [[Int]](repeating: [Int](), count: N)
var visited = [[Int]](repeating: [Int](repeating: 0, count: M), count: N)

var virusListFromGiven: [(Int, Int)] = [] // 현재 바이러스가 있는 위치 리스트
var wallPossibleListFromGiven: [(Int, Int)] = [] // 벽을 세울 수 있는 공간을 가진 리스트 (맵에서 0인곳)

var biggestNumber = -10000000 // 최대값을 갱신하기 위한 변수

for i in 0..<N {
    adjMatrix[i].append(contentsOf: readLine()!.split(separator: " ").map { Int(String($0))! })
}

// MARK: - 바이러스와 벽이 어느 위치에 있는지 각각의 리스트에 넣기
func fillListsFromMatrix() {
    for i in 0..<N {
        for j in 0..<M {
            if adjMatrix[i][j] == 2 { // 바이러스의 위치 넣기
                virusListFromGiven.append((i,j))
            } else if adjMatrix[i][j] == 0 { // 빈칸의 위치 넣기
                wallPossibleListFromGiven.append((i,j))
            }
        }
    }
}

// MARK: - 3 개의 벽 세우고 오염된 지역을 제외한 칸의 갯수까지 반환하기
func buildRandomWallAndCheck() {
    let currentlyZeroCount = wallPossibleListFromGiven.count
    for i in 0..<currentlyZeroCount {
        for j in i + 1 ..< currentlyZeroCount {
            for k in j + 1 ..< currentlyZeroCount {
                adjMatrix[wallPossibleListFromGiven[i].0][wallPossibleListFromGiven[i].1] = 1
                adjMatrix[wallPossibleListFromGiven[j].0][wallPossibleListFromGiven[j].1] = 1
                adjMatrix[wallPossibleListFromGiven[k].0][wallPossibleListFromGiven[k].1] = 1
                let result = afterSpreadVirusCheckWhichIsAvailable()
                biggestNumber = result > biggestNumber ? result : biggestNumber
                adjMatrix[wallPossibleListFromGiven[i].0][wallPossibleListFromGiven[i].1] = 0
                adjMatrix[wallPossibleListFromGiven[j].0][wallPossibleListFromGiven[j].1] = 0
                adjMatrix[wallPossibleListFromGiven[k].0][wallPossibleListFromGiven[k].1] = 0
            }
        }
    }
}


// MARK: - 바이러스 퍼뜨리기
func spreadVirusDFS(_ y: Int, _ x: Int) {
    visited[y][x] = 2
    for i in 0..<4 {
        let ny = y + dy[i]
        let nx = x + dx[i]
        if ny < 0 || nx < 0 || ny >= N || nx >= M || adjMatrix[ny][nx] == 1 || visited[ny][nx] == 2 { continue }
        spreadVirusDFS(ny,nx)
    }
}

// MARK: - 방문 배열 초기화
func emptyVisitedArr() {
    for i in 0..<N {
        for j in 0..<M {
            visited[i][j] = 0
        }
    }
}

// MARK: - 바이러스 퍼뜨리고 몇 군데가 안전한지 체크하기
func afterSpreadVirusCheckWhichIsAvailable() -> Int {
    var counter = 0
    
    emptyVisitedArr()
    virusListFromGiven.enumerated().forEach { // 바이러스의 위치마다 dfs
        spreadVirusDFS($0.element.0,$0.element.1)
    }
    
    for i in 0..<N {
        for j in 0..<M {
            if visited[i][j] == 0 && adjMatrix[i][j] == 0 { // 안전 지역 카운트
                counter += 1
            }
        }
    }
    return counter
}

fillListsFromMatrix()
buildRandomWallAndCheck()
print(biggestNumber)
```

## 🍎 느낀점
- 어떻게 벽을 세울지 + 조합을 어떻게 만들지가 가장 어려웠다
- 나머지 바이러스를 퍼뜨리는것과 카운트하는것은 나쁘지 않았다.
