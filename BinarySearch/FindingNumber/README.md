# 1920 수 찾기
- 이분 탐색

## 🍎 문제 접근
- N개의 정수가 주어졌을 때, 이 안에 X라는 정수가 존재하는지 알아내는 프로그램을 작성한다.

## 🍎 예제 입력 형식
- 주어지는 수의 갯수
- 주어지는 수들
- 찾아야 하는 수의 갯수
- 찾아야하는 수들
- 주어지는 수의 갯수와 찾아야하는 수의 갯수는 N개
    - N은 1 ~ 100000
- 2중 for문으로 찾게 된다면 10만 * 10만 = 100억 (시간초과)

## 🍎 문제 풀이 및 전체 코드
- 이분탐색을 이용 -> 오름차순 정렬 필수
```swift
import Foundation

let N = Int(readLine()!)!
var firstArr = [Int]()
firstArr.append(contentsOf: readLine()!.split(separator: " ").map { Int(String($0))! })

let M = Int(readLine()!)!
var secondArr = [Int]()
secondArr.append(contentsOf: readLine()!.split(separator: " ").map { Int(String($0))! })

firstArr.sort()

var firstArrCount = firstArr.count - 1

func binarySearch(_ array: [Int], _ targetNum: Int) -> Bool {
    var start = 0
    var end = firstArrCount
    //(array.count - 1) 배열의 count는 O(N), 한번만 계산하고 사용할 수 있도록 밖으로 빼주자
    while start <= end {
        var mid = (start + end) / 2
        
        if array[mid] == targetNum { return true }
        if array[mid] > targetNum {
            end = mid - 1
        } else {
            start = mid + 1
        }
    }
    return false
}

secondArr.enumerated().forEach {
    if binarySearch(firstArr, $0.element) == true {
        print(1)
    } else {
        print(0)
    }
}
```
