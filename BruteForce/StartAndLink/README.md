# 14889 스타트와 링크
- 백트래킹

## 🍎 지문 해석
- 팀을 딱 반으로 나눠서 가장 차이가 안나도록 하는 경우가 어떤 경우인지 찾는 문제
- 즉, 차이의 최솟값을 찾으면 된다.

## 🍎 문제 접근
- 처음엔 모든 조합을 구해서 풀려고 했는데 시간초과가 발생해서 다시 생각했다.
- [0,1,2,3]과 [3,2,1,0]은 같은 결과를 가져온다. 이러한 경우를 제외하는것이 이 문제의 포인트다.

## 🍎 문제 풀이 및 전체 코드
### 📖 내가 푼 방식
```swift
import Foundation

let N = Int(readLine()!)!
var adjMatrix = [[Int]](repeating: [Int](), count: N)
for i in 0..<N {
    adjMatrix[i].append(contentsOf: readLine()!.split(separator: " ").map { Int(String($0))! })
}

func calculate(_ arr: [Int]) -> Int {
    let total = Set(0..<N)
    var teamA = 0
    var teamB = 0
    let opponent = Array(total.subtracting(Set(arr)))
    for i in arr { // teamA
        for j in arr {
            if i == j { continue }
            teamA += adjMatrix[i][j]
        }
    }
    for i in opponent { // teamB
        for j in opponent {
            if i == j { continue }
            teamB += adjMatrix[i][j]
        }
    }
    return abs(teamA - teamB)
}

var result = Int.max
var visited = [Int](repeating: 0, count: N)
var filterSet = Set<Set<Int>>()
func dfs(_ depth: Int, _ currentArr: [Int], _ index: Int) {
    if depth == N/2 {
        let temp = calculate(currentArr)
        result = result > temp ? temp : result
        return
    }
    for i in index..<N {
        if visited[i] == 1 { continue }
        visited[i] = 1
        dfs(depth + 1, currentArr + [i], i)
        visited[i] = 0
    }
}

dfs(0, [], 0)
print(result)
```

### 📖 조금 더 빠른 방식
- 다른분들은 이렇게 풀었다.
- 방문 배열인 visited를 백트래킹 + 연산에 이용한다. (조금 더 빠르다)
```swift
import Foundation

let n = Int(readLine()!)!
var arr = [[Int]]()
var visited = [Bool](repeating: false, count: n)
var minResult = Int.max

for _ in 0..<n {
    arr.append(readLine()!.split(separator: " ").map{ Int($0)! })
}

private func dfs(depth: Int, start: Int) {
    if depth == n/2 {
        var teamStart = 0
        var teamLink = 0

        for i in 0..<n {
            for j in 0..<n {
                if visited[i], visited[j] {
                    teamStart += arr[i][j]
                }

                if !visited[i], !visited[j] {
                    teamLink += arr[i][j]
                }
            }
        }
        minResult = min(minResult, abs(teamLink - teamStart))
        return
    }

    for i in start..<n {
        if !visited[i] {
            visited[i] = true
            dfs(depth: depth + 1, start: i)
            visited[i] = false
        }
    }
}

dfs(depth: 0, start: 0)
print(minResult)
```
