# 14719 빗물
- 구현
- 2차원 배열

## 🍎 문제 접근
- 문제의 힌트에서 1번,2번과 달리 3번을 보면, 비가 내려도 벽이 하나 밖에 없어서 담을 공간을 만들어내지 못한것을 알 수 있다.
    - 즉, 벽이 있어야 한다.
    - 같은 높이의 벽 사이 간격이 적어도 1칸 떨어져있어야 비가 담길 수 있다. 예를 들어, 0부터 2 사이에 공간이라면 빗물을 담을 수 있는 공간이 1칸이 생긴다.
    - 즉 end - start >= 2일때, 
        - result += end - start - 1 이다.
    - 위의 예제를 대입해 적용해보면.. 
    - (end)(2) - (start)(0) >= 2
        - result += (end)(2) - (start)(0) - 1

## 🍎 문제 풀이 및 전체 코드
- 0으로 채워진 N * M 사이즈의 2차원 배열 adjMatrix을 생성한다.
    - 이 2차원 배열에 백준에서 주어지는 값들에 따라 1로 색칠할 것이다.
- 각 row를 순회하면서 색칠 되어있는 값의 사이가 2 이상이면 결과를 출력할 result 변수에 더한 후 갱신할 것이다.
```swift
import Foundation

let NM = readLine()!.split(separator: " ").map { Int(String($0))! }
let N = NM[0]
let M = NM[1]

var adjMatrix = [[Int]](repeating: [Int](repeating: 0, count: M), count: N)

let given = readLine()!.split(separator: " ").map { Int(String($0))! }
for i in 0..<M {
    for j in stride(from: N-1, through: N - given[i], by: -1) {
        adjMatrix[j][i] = 1
    }
}

var result = 0
// 두 값의 차이가 2이상인 경우 찾기
for i in 0..<N {
    var prev = -1
    for j in 0..<M {
        if prev != -1 && adjMatrix[i][j] == 1 {
            if j - prev >= 2 {
                result += j - prev - 1
            }
            prev = j
        } else if prev == -1 && adjMatrix[i][j] == 1 {
            prev = j
        }
    }
}
print(result)
```

## 🍎 주의 할 점
### 📖 정상적으로 작동하지 않은 코드
- 처음엔 var prev = 0 으로 초기화 했었다. 하지만 제대로 작동하지 않는것을 확인했고, 반례를 찾을 수 있었다.
```swift
var result = 0
// 두 값의 차이가 2이상인 경우 찾기
for i in 0..<N {
    var prev = 0
    for j in 0..<M {
        if prev != 0 && adjMatrix[i][j] == 1 {
            if j - prev >= 2 {
                result += j - prev - 1
            }
            prev = j
        } else if prev == 0 && adjMatrix[i][j] == 1 {
            prev = j
        }
    }
}
print(result)
```
- 위의 코드에 예제 1번을 실행시키면
```bash
4 4
3 0 1 4
```
- 아래와 같은 결과를 얻는다.
```bash
[0, 0, 0, 1]
[1, 0, 0, 1]
[1, 0, 0, 1]
[1, 0, 1, 1]
```
- 각 row를 돌면서 prev를 재 설정하는데 1번째 row를 보면 0번째 인덱스에서 prev == 0 && adjMatrix[1][0] == 1 조건을 만족시켜 prev = 0으로 갱신된다.
- 이후 adjMatrix[1][3]을 만났을때, 여전히 prev는 0이고 adjMatrix[1][3]은 1이 되어, 다시 else if문을 수행한다.
- 이러한 로직 오류로 인해 원래 정상적으로 실행되었을때의 값 2를 얻지 못하고 이는 곧 오답을 출력하는 원인이된다.

### 📖 해결 방법
- prev 변수를 초기화할때 -1로 초기화 해주면 0도 유효한 숫자로 사용할 수 있어서 원하는 로직으로 정답을 얻을 수 있다.
