# 2295 세 수의 합
- 이분탐색
- 수학

## 🍎 지문 해석
- 배열에서 세개의 수를 합한 수 가 배열에 있고, 그 중 가장 큰 값을 출력하는 문제
    - 즉, a + b + c = d일때 d를 가장 크게 만들면 된다.
    - 그리고 a, b, c는 서로 같아도 된다. (중요)
- 숫자의 총 개수 N은 최대 1000
- 원소의 최대 범위는 2억 이하의 자연수
- [2,3,5,10,18] 같은 경우,
    - 3,5,10을 더한 18이 배열에 있으면서 가장 큰 값이기 때문에 답이 된다.

## 🍎 문제 접근
- N^4
    - i + j + k = l ? -> 1000^4 = 1억을 훨씬 넘긴다.
- N^3logN
    - i + j + k가 배열에 있는지 이분탐색 -> N^4보단 조금 낫지만 1000^3 => 100억
- N^2logN
    - a + b + c = d 라는 식을 변형시켜 a + b = d - c로 만들어 해결하는 방법
        - 1. a + b 계산하기
            - a와 b를 더했을때 나올수 있는 수를 twoSumArr에 넣고 정렬시킨다.
            - a + b는 구해졌다.
        - 2. d - c 계산하기
            - 이제 d - c를 구하면 되는데, arr[i](현재)값에서 어떤 수(x)를 빼주었을때 그 값(y)이 존재한다는것은 x + y = arr[i]라는것이므로, 답이 될 수 있다.
            - i는 배열의 끝에서부터, j는 배열의 시작부터 순회하면 l을 가장 크게 만들어줄 수 있다.

## 🍎 문제 풀이 및 전체 코드
```swift
import Foundation

let N = Int(readLine()!)!
var arr = [Int]()
for _ in 0..<N {
    arr.append(Int(readLine()!)!)
}
arr.sort()

var twoSumArr = [Int]()
for i in 0..<N {
    for j in i..<N {
        twoSumArr.append(arr[i] + arr[j])
    }
}
twoSumArr.sort()

func binarySearch(_ targetNum: Int) -> Bool {
    var start = 0
    var end = twoSumArr.count - 1
    var mid = (start + end) / 2
    while start <= end {
        mid = (start + end) / 2
        let tempNum = twoSumArr[mid]
        if tempNum == targetNum {
            return true
        } else if tempNum > targetNum {
            end = mid - 1
        } else {
            start = mid + 1
        }
        
    }
    return false
}

func getResult() -> Int {
    for i in stride(from: N-1, through: 0, by: -1) {
        for j in 0..<N {
            let temp = arr[i] - arr[j]
            if binarySearch(temp) {
                return arr[i]
            }
        }
    }
    return 0
}

print(getResult())
```

## 🍎 참고
- [바킹독님의 이분탐색 강의](https://youtu.be/3TkaOKHxHnI?t=1369)
