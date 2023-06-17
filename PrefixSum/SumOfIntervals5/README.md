# 11659 구간 합 구하기5
## 🍎 문제 접근
- 배열에서 누적합을 어떻게 만들어 줄지 생각했다.
```bash
1 2
2 3 일때,
누적합 2차원 배열은 아래와 같다.
1 3
3 8
이 누적합은 어떻게 구했을까??
```

## 🍎 문제 풀이
- 1. DP로 배열 다 채우기
    - 처음에 0,0에서 십자 모양으로 채워주기
    - 1-1.
        - y가 0일때
            - visited[0][x] = visited[0][x-1] + adjMatrix[0][x]
        - x가 0일때
            - visited[y][0] = visited[y-1][0] + adjMatrix[y][0]
    - 1-2. (2,2) 좌표부터는 아래와 같이 한다.
        - 문제에서는 0,0이 1,1로 주어진다. 그렇기 때문에 2,2인 좌표는 1,1로 생각해야 한다.
        - visited[1][1] = visited[0][1] + visited[1][0] - visited[0][0] + adjMatrix[1][1]
- 2. 주어지는 범위로 값 얻기
    - 2-1. 
        - 주어지는 좌표 두개 중 시작 좌표를 tempStartLocation, 뒤의 좌표를 tempEndLocation이라고 하자
    - 2-2.
        - tempEndLocation의 마지막 좌표에 들어있는 누적합을 tempResult라고 하자
    - 2-3.
        - tempEndLocation의 y좌표는 그대로 x좌표는 -1한 좌표를 tempLeft라고 하자
    - 2-4.
        - tempEndLocation의 y좌표를 -1 x좌표는 그대로 한 좌표를 tempUp이라고 하자.
    - 2-5.
        - tempStartLocation의 y좌표를 -1, x좌표를 -1한 좌표를 common이라고 하자.
    - 2-6.
        - 정답은 tempResult - (tempLeft + tempUp - common) 이 된다.
### 📖 이미지로 각 자리의 누적합 구하는 로직 이해하기
- 0,0을 문제에서는 1,1로 표현한다는 점을 기억하자.
![](https://hackmd.io/_uploads/rJts6RcP3.png)
- 빨간색 자리의 누적합을 구하기 위해서는 빨간색 자리의 상측, 좌측에 있는 초록색 위치의 누적합이 필요하다.
- 그리고 초록색 누적합들에 공통으로 더해져 있는 보라색 누적합을 빼주면 된다.
- 즉, 2,2 위치의 누적합 p(2,2)를 구하기 위해서는 (p(2,1) + p(1,2)) - p(1,1) + 현재 2,2에 있는 값이라는 공식이 나온다.
- 이를 이용해 현재 2차원 배열을 2차원 누적합 배열로 만들어주고 위의 로직을 활용해 특정 구간의 누적합을 구하면 된다.

### 📖 이미지로 특정 구간의 총 합 구하기 로직 이해하기 
![](https://hackmd.io/_uploads/r1m2RR9Dn.png)
- **2,2에서 3,4구간의 총 합을 구하는 로직을 살펴보자!**
- 빨간색 구간의 총 합을 구하면 되는 문제다.
- 빨간색 끝(3,4)의 누적합 - (왼쪽 초록색 끝(3,1) + 위쪽 초록색 끝(1,4)) - 공통으로 누적합에 더해진 보라색(1,1)을 빼주면 된다.

## 🍎 전체 코드
```swift
import Foundation

let NM = readLine()!.split(separator: " ").map { Int(String($0))! }
let N = NM[0]
let M = NM[1]

var adjMatrix = [[Int]](repeating: [Int](), count: N)
var visited = [[Int]](repeating: [Int](repeating: 0, count: N), count: N)

for i in 0..<N {
    adjMatrix[i].append(contentsOf: readLine()!.split(separator: " ").map { Int(String($0))! })
}

var locations = [[Int]](repeating: [Int](), count: M)
for i in 0..<M {
    locations[i].append(contentsOf: readLine()!.split(separator: " ").map { Int(String($0))! })
}

visited[0][0] = adjMatrix[0][0]
for i in 1..<N {
    visited[0][i] = visited[0][i-1] + adjMatrix[0][i]
}
for i in 1..<N {
    visited[i][0] = visited[i-1][0] + adjMatrix[i][0]
}

for i in 1..<N {
    for j in 1..<N {
        visited[i][j] = visited[i-1][j] + visited[i][j-1] - visited[i-1][j-1] + adjMatrix[i][j]
    }
}

for i in 0..<M {
    let startLocationY = locations[i][0] - 1
    let startLocationX = locations[i][1] - 1
    let endLocationY = locations[i][2] - 1
    let endLocationX = locations[i][3] - 1
    if startLocationY == endLocationY && startLocationX == endLocationX {
        print(adjMatrix[startLocationY][startLocationX])
    } else {
        var tempLeft = 0
        var tempUp = 0
        var common = 0
        if startLocationY != 0 {
            tempUp = visited[startLocationY - 1][endLocationX]
        }
        if startLocationX != 0 {
            tempLeft = visited[endLocationY][startLocationX - 1]
        }
        if startLocationY != 0 && startLocationX != 0 {
            common = visited[startLocationY - 1][startLocationX - 1]
        }
        let tempResult = visited[endLocationY][endLocationX]
        print(tempResult - (tempLeft + tempUp - common))
    }
}
```

## 🍎 게시판에서 발견한 반례
- 처음 시도했던 방법
```swift
...
...
for i in 0..<M {
    let startLocationY = locations[i][0] - 1
    let startLocationX = locations[i][1] - 1
    let endLocationY = locations[i][2] - 1
    let endLocationX = locations[i][3] - 1
    if startLocationY == endLocationY && startLocationX == endLocationX {
        print(adjMatrix[startLocationY][startLocationX])
    } else {
        var tempLeft = 0
        var tempUp = 0
        var common = 0
        if startLocationY != 0 && startLocationX != 0 {
            tempLeft = visited[endLocationY][startLocationX - 1]
            tempUp = visited[startLocationY - 1][endLocationX]
            common = visited[startLocationY - 1][startLocationX - 1]
        }
        let tempResult = visited[endLocationY][endLocationX]
        print(tempResult - (tempLeft + tempUp - common))
    }
}
```
```bash
입력값
4 1
1 2 3 4
2 3 4 5
3 4 5 6
4 5 6 7
3 1 3 4

답
18
```
