# 2468 안전 영역

## 🍎 키워드
- Connected Component
- DFS
- 예외처리(제일 중요)

## 🍎 문제 설명
- 표가 주어졌을때 비에 잠기지 않는 '연결된 컴포넌트'의 숫자를 구하는 문제이다.
- 비에 잠긴다는 것은 비의 레벨과 같거나 작으면 잠기는것이다.

## 🍎 문제 풀이
### 📖 지문 해석
![](https://i.imgur.com/gbiZHwY.png)
- 예외처리를 잘못해줘서 오래 걸렸다.
    - 문제를 꼼꼼하게 읽자!
- 입력을 보면 비의 레벨이 딱 나와있지 않았다.
    - 지문: 첫째 줄에는 어떤 지역을 나타내는 2차원 배열의 행과 열의 개수를 나타내는 수 N이 입력된다. N은 2 이상 100 이하의 정수이다. 둘째 줄부터 N개의 각 줄에는 2차원 배열의 첫 번째 행부터 N번째 행까지 순서대로 한 행씩 높이 정보가 입력된다. 각 줄에는 각 행의 첫 번째 열부터 N번째 열까지 N개의 높이 정보를 나타내는 자연수가 빈 칸을 사이에 두고 입력된다. 높이는 1이상 100 이하의 정수이다
- 마지막 줄에 각각의 칸에 들어가는 지역의 높이는 1이상 100이하의 정수라고 나와있다. 즉, 비의 높이는 1~100이하가 된다.

### 📖 문제에서 원하는것
- **각각의 비의 레벨에 따라 비의 레벨보다 높은 연결된 컴포넌트의 갯수를 구하고 최대 컴포넌트 갯수를 구하면 된다.**
```swift
for rainLevel in 1...100 { // 비의 레벨만큼 반복
    var counter = 0
    visited = [[Bool]](repeating: [Bool](repeating: false, count: N), count: N) // 비의 레벨이 바뀔때마다 초기화
    for i in 0..<N {
        for j in 0..<N {
            if visited[i][j] == true { continue } // 지역을 이미 방문했다면 continue
            if rainLevel >= adjMatrix[i][j] { continue } // 지역의 높이가 비의 높이와 같거나 낮으면 continue
            // 이 코드가 없다면 비의 레벨이 무엇이 되었든 방문만 하지 않았다면 dfs 함수를 실행하므로 정확한 문제 해결을 할 수 없다.
            // 예를 들어 rainLevel이 5이고 adjMatrix[i][j]의 값이 1이라고 해보자. 문제에서 원하는 답은 비의 레벨마다 rainLevel 보다 높은지역들로 이루어진 연결된 컴포넌트의 갯수인데, 비의 레벨 5보다 훨씬 작은 1이 통과가 되면 counter를 올려주는 의미가 없어진다.
            dfs(i, j, rainLevel)
            counter += 1
        }
    }
    result = counter > result ? counter : result
}
```
- 이제 메인 로직인 dfs함수를 보자.
```swift
func dfs(_ y: Int, _ x: Int, _ depth: Int) {
    visited[y][x] = true
    for i in 0..<4 {
        let ny = y + dy[i]
        let nx = x + dx[i]
        if ny < 0 || nx < 0 || ny >= N || nx >= N { continue }
        if visited[ny][nx] == true { continue }
        if depth >= adjMatrix[ny][nx] { continue }
        dfs(ny, nx, depth)
    }
}
```
- 일반적인 dfs함수이지만 재귀함수 위 코드를 보면 '다음으로 탐색하려는 지점이 레벨보다 낮으면 건너뛴다'라는 점을 꼭 기억해야 한다.

## 🍎 문제 풀고 느낀점
- 지문을 꼼꼼히 읽는것과 시간복잡도에 중요성이 굉장히 중요하다는것을 느꼈다!
