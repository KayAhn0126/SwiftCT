# 2108 통계학
- 구현

## 🍎 문제 접근
- 문제에서 요구하는것
    - 산술평균 : N개의 수들의 합을 N으로 나눈 값
    - 중앙값 : N개의 수들을 증가하는 순서로 나열했을 경우 그 중앙에 위치하는 값
    - 최빈값 : N개의 수들 중 가장 많이 나타나는 값
    - 범위 : N개의 수들 중 최댓값과 최솟값의 차이

## 🍎 문제 풀이
- 산술평균은 소수점 이하 첫째 자리에서 반올림한 값을 출력 해야하므로 round를 써서 처리해줬다.
- 중앙값은 배열을 정렬하고 가운데 숫자를 출력해주었다.
    - 범위가 50만이라 nlogn 시간 통과
- 최빈값, 즉 N개의 수들 중 가장 많이 나타나는 값을 출력해야하는데 요소중에는 음수도 있으므로 범위를 양수 범위의 2배로 정하고 문제를 풀었다.
    - 여러 개 있을 때에는 최빈값 중 두 번째로 작은 값을 출력한다.
- 범위는 끝 요소에서 첫 요소를 빼줬다.

## 🍎 전체 코드
```swift
import Foundation

let N = Int(readLine()!)!

var arr = [Int]()
var countingArr = [Int](repeating: 0, count: 8001)
var total = 0
var countMax = 0

for i in 0..<N {
    let num = Int(readLine()!)!
    arr.append(num)
    countingArr[num + 4000] += 1
    if countingArr[num+4000] > countMax {
        countMax = countingArr[num+4000]
    }
    total += num
}

var mostNum = 0
var doubleCount = 0

for i in 0..<countingArr.count {
    if countingArr[i] == countMax {
        doubleCount += 1
        mostNum = i - 4000
        if doubleCount == 2 {
            break
        }
    }
}

arr.sort()

print(Int(round(Double(total)/Double(N))))
print(arr[arr.count/2])
print(mostNum)
print(arr[arr.count-1] - arr[0])
```
