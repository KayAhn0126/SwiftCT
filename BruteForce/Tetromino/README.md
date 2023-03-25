# 14500 테트로미노
- 브루트포스 (내가 접근한 방식)
- DFS (DFS로도 풀 수 있다)

## 🍎 전처리
- 최대값을 구하는 문제이므로 최대값이 나오지 못하게 아래와 같이 N ~ N+3되는 부분은 -1000으로 채워준다.
    - 예를 들어, 아래의 맵(4,4)위치에서 도형의 크기를 탐색 할 때 최대값이 나올수 없도록한다.
```bash
[1, 2, 3, 4, 5, -1000, -1000, -1000]
[5, 4, 3, 2, 1, -1000, -1000, -1000]
[2, 3, 4, 5, 6, -1000, -1000, -1000]
[6, 5, 4, 3, 2, -1000, -1000, -1000]
[1, 2, 1, 2, 1, -1000, -1000, -1000]
[-1000, -1000, -1000, -1000, -1000, -1000, -1000, -1000]
[-1000, -1000, -1000, -1000, -1000, -1000, -1000, -1000]
[-1000, -1000, -1000, -1000, -1000, -1000, -1000, -1000]
```
- 위와 같은 식으로 전처리
## 🍎 문제 접근
- 주어지는 5가지의 모형을 대칭, 회전하게되면 총 19가지의 경우의 수가 나온다.
    - 2차원 배열로 미리 만들어 놓는다.
- 입력으로 주어진 배열과 19가지 모형을 배열을 브루트포스 방식으로 체크하면서 모형 배열에서 1인 부분의 숫자를 더해 total을 구한다.

## 🍎 문제 풀이
- 메인 로직
```swift
// 여기서 tetrominoCollection은 19가지의 모형을 2차원 배열로 모아놓은 배열이다.

func checkAndGetCurrentResult(_ y: Int, _ x: Int, _ k: Int) -> Int {
    var result = 0
    for i in 0..<4 {
        for j in 0..<4 {
            // 메인 포인트 tetrominoCollection의 요소에서 1인 부분만 result에 더하는 로직
            // 만약 tetrominoCollection의 요소가 1이라면 adjMatrix의 요소와 곱해서 값을 얻고,
            //     예) 1 * 6
            // 만약 tetrominoCollection의 요소가 0이라면 0이라면 0 * x = 0이므로 0이되어 더해져도 아무 의미 없다.
            result += tetrominoCollection[k][i][j] * adjMatrix[y+i][x+j]
        }
    }
    return result
}

var result = -100000
var tempResult = 0
for i in 0..<N {
    for j in 0..<M {
        for k in 0..<tetrominoCollection.count {
            tempResult = checkAndGetCurrentResult(i, j, k) // (i,j)는 현재 위치
            result = tempResult > result ? tempResult : result
        }
    }
}
```

## 🍎 다른 방식으로 풀어보기
- 그래프 탐색으로 풀 수 있다고 한다.
