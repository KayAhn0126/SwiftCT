# 2583 영역 구하기

## 🍎 키워드
- 연결된 컴포넌트
- 문제를 나에 기준에 맞춰보기
    - 인접행렬 초기화시 반전

## 🍎 문제 풀이
- 전체적으로는 일반 dfs였지만 색칠한 부분을 어떻게 건드리지 않고 연결된 컴포넌트를 구하는지 요구하는 문제.
```swift
var adjMatrix = [[Int]](repeating: [Int](repeating: 1, count: M), count: N)
var visited = [[Int]](repeating: [Int](repeating: 0, count: M), count: N)

var result = 0
var resultArr = [Int]()

var area = 0

for _ in 0..<K {
    let xyPoint = readLine()!.split(separator: " ").map { Int($0)! }
    let x1 = xyPoint[0]
    let y1 = xyPoint[1]
    let x2 = xyPoint[2]
    let y2 = xyPoint[3]
    for i in x1..<x2 {
        for j in y1..<y2 {
            adjMatrix[j][i] = 0
            visited[j][i] = 1
        }
    }
}
```
- 보통 adjMatrix를 0으로 초기화 하고 입력을 받을 때 1로 바꿔주는데 이 문제는 반대로 처음에 모든 adjMatrix를 1로 설정하고 색칠한 부분을 0으로 설정한다.
- 또, visited 배열은 일반적으로 생성 후 0으로 초기화만 하고 나중에 dfs함수에서 방문 처리를 하는데 색칠한 부분도 방문했다고 처리해 2중으로 갈 수 없도록 만들었다.

## 🍎 느낀점
- 헷갈리는 부분도 많지만 1일차에 이정도면 잘하고 있다.
