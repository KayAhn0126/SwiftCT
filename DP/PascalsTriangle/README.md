# 16395 파스칼의 삼각형

## 🍎 문제 접근
- DP(bottom up) 문제
- 파스칼의 삼각형 특징
    - N번째 행에는 N개의 수가 있다.
    - 첫 번째 행은 1이다.
    - 두 번째 행부터, 각 행의 양 끝의 값은 1이고, 나머지 수의 값은 바로 위 행의 인접한 두 수의 합이다.
- 범위
    - 1 <= K <= N <= 30
    - 즉 2차원 배열을 만들고 행 31개 만들기
- 예외처리
    - 코드를 본 후 다루겠다!

## 🍎 문제 풀이
```swift
import Foundation

let NK = readLine()!.split(separator: " ").map { Int(String($0))! }
let N = NK[0]
let K = NK[1]

var arr = [[Int]](repeating: [Int](repeating: 0, count: 31), count: 31)

arr[1][1] = 1
arr[2][1] = 1
arr[2][2] = 1

if N < 3 {
    print(arr[N][K])
} else {
    for i in 3...N {
        arr[i][1] = 1
        arr[i][i] = 1
        for j in 2..<i {
            arr[i][j] = arr[i-1][j-1] + arr[i-1][j]
        }
    }
    print(arr[N][K])
}
```

## 🍎 런타임 에러 발생!
- 예외처리를 안해주었다.
- if문 없이 그냥 for문만 있었는데, 문제는 입력으로 N = 2, K = 1이 들어와도 for문을 실행하는게 문제였다.
- 안전하게 처리!
- 예제 돌려보고 맞다고 바로 제출하는 습관을 버리자. 
    - 극한의 값(최소, 최대)을 생각하는 습관을 들이자!
