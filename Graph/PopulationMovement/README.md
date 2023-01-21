# 16234 인구이동

## 🍎 키워드
- 구현
- 특정 상황까지 dfs 탐색
- 브루트포스

## 🍎 문제 접근
- 2차원 배열 전체를 탐색하면서 특정 상황(L과 R사이에 있는 경우)에는 특정 동작을 수행하게 만들면된다.
- 사용된 변수 설명
    - totalList
        - 특정 범위안에 들어오는 위치 저장 배열
    - sum
        - dfs 탐색을 했을때 총 합을 관리할 변수
    - result
        - 총 몇번 인구이동을 하는지 관리할 변수

## 🍎 문제 풀이
- 메인 로직
```swift
while true {
    var flag: Bool = false
    visited = [[Int]](repeating: [Int](repeating: 0, count: N), count: N)
    for i in 0..<N {
        for j in 0..<N {
            if visited[i][j] == 0 {
                totalList.removeAll()
                visited[i][j] = 1
                totalList.append((i,j))
                sum = adjMatrix[i][j]
                dfs(i,j)
                if totalList.count == 1 { continue }
                for i in 0..<totalList.count {
                    adjMatrix[totalList[i].0][totalList[i].1] = sum / totalList.count
                    flag = true
                }
            }
        }
    }
    if flag == false { // 모두 체크(방문)해서 더 이상 체크할게 없다면 무한 루프를 빠져 나온다.
        break
    }
    result += 1
}
```
- 서브 메인 로직
```swift
func dfs(_ y: Int, _ x: Int) {
    for i in 0..<4 {
        let ny = y + dy[i]
        let nx = x + dx[i]
        if ny < 0 || nx < 0 || ny >= N || nx >= N { continue }
        if visited[ny][nx] == 1 { continue }
        if L <= (abs(adjMatrix[ny][nx] - adjMatrix[y][x])) && (abs(adjMatrix[ny][nx] - adjMatrix[y][x])) <= R { // 특정 조건에 맞다면 상하좌우 살피기
            visited[ny][nx] = 1
            totalList.append((ny,nx))
            sum += adjMatrix[ny][nx]
            dfs(ny,nx)
        }
    }
}
```

## 🍎 느낀점
- 이 문제는 도저히 구현 방법이 떠오르지 않아 C++로 된 답지를 보고 이해했다.
- 막상보면 이해 못할 코드는 없는데 경험이 많지 않아 그런것 같다, 문제를 많이 풀어보자!
