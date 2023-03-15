# 2805 나무 자르기
- 이분 탐색은 무조건 배열을 정렬하고 문제를 풀어야 한다고 생각했었는데 이 문제는 조금 달랐다.

## 🍎 문제 이해를 위한 지문
- 목재절단기는 다음과 같이 동작한다. 먼저, 상근이는 절단기에 높이 H를 지정해야 한다.
- 높이를 지정하면 톱날이 땅으로부터 H미터 위로 올라간다. 그 다음, 한 줄에 연속해있는 나무를 모두 절단해버린다.
- 따라서, 높이가 H보다 큰 나무는 H 위의 부분이 잘릴 것이고, 낮은 나무는 잘리지 않을 것이다.
- 예를 들어, 한 줄에 연속해있는 나무의 높이가 20, 15, 10, 17이라고 하자. 상근이가 높이를 15로 지정했다면, 나무를 자른 뒤의 높이는 15, 15, 10, 15가 될 것이고, 상근이는 길이가 5인 나무와 2인 나무를 들고 집에 갈 것이다.
- (총 7미터를 집에 들고 간다) 절단기에 설정할 수 있는 높이는 양의 정수 또는 0이다.

## 🍎 문제 접근
- 상근이가 나무를 딱 필요한 만큼 가져가기 위해 톱날의 높이를 최대로 설정하기.

## 🍎 문제 해결
- 두개의 함수를 만들어 문제 해결
- 톱날의 길이가 주어졌을때, 해당 톱날로 자르고 남은 나무의 총 합이 M이 넘는지 확인하는 함수.
    - func checkIsEnoughTree(_ settingNumber: Int) -> Bool
- 이분 탐색으로 해당 톱날이 크기가 최대가 되도록 만들어 주는 함수.
    - func binarySearchForSawLength() -> Int
- 중요한 포인트
    - sawLength가 작을수록 나무를 많이 베어 상근이가 얻는 나무의 미터가 커진다.

## 🍎 전체 코드
```swift
import Foundation

let NM = readLine()!.split(separator: " ").map { Int(String($0))! }
let N = NM[0]
let M = NM[1]

var treeList = readLine()!.split(separator: " ").map { Int(String($0))! }

func checkIsEnoughTree(_ sawLength: Int) -> Bool {
    var tempTotal = 0
    for tree in treeList {
        if tree >= sawLength {
            tempTotal += tree - sawLength
        }
        if tempTotal >= M { // 현재 톱날로 잘랐을때 떨어지는 나무들의 합이 M보다 크다 ( 상근이가 가져갈 수 있지만 상근이는 딱 떨어지게 가져가고 싶다, 그럴려면 sawLength가 커야한다.
            return true
        }
    }
    return false
}

func binarySearchForSawLength() -> Int {
    var result = 0
    var start = 0, end = 2000000000, mid = 0
    while start <= end {
        mid = (start + end) / 2
        if checkIsEnoughTree(mid) == true {
            result = mid
            start = mid + 1
        } else {
            end = mid - 1
        }
    }
    return result
}

print(binarySearchForSawLength())
```
