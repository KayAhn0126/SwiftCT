# Binary Search

## 🍎 정의
- 이분 탐색이란 두개의 인덱스의 위치를 바꿔가며 타겟 값이 나올 수 있는 범위를 줄여가며 탐색하는 방법.

## 🍎 기본 이분 탐색 코드
- 이분 탐색으로 타겟을 찾으려고 하는 배열은 오름차순 정렬이 보장 되어 있어야 한다.
- 타겟이 있을 수 있는 범위가 계속 반으로 줄어들기 때문에 시간복잡도는 O(logN)
```swift
func binarySearch(_ array: [Int], num: Int) -> Bool {
    var start = 0
    var end = array.count - 1
    
    while start <= end {
        let mid = (start + end) / 2
        
        if array[mid] == num { return true }
        if array[mid] > num {
            end = mid - 1
        } else {
            start = mid + 1
        }
    }
    return false
}
```

- 아직 정리중이다.
## 🍎 upper bound, lower bound 정리
- lower bound -> 데이터 내에서 특정 값보다 같거나 큰 값이 처음 나오는 위치
- upper bound -> 특정 값보다 처음으로 큰 값이 나오는 위치

### 📖 코드를 통해 조금 더 자세히 알아보자.
```swift
var arr = [1,1,1,2,2,3,3,3,4,4,5,5]
var l = 0
var r = arr.count
var mid = 0

lowerBound(9) 9랑 같거나 큰값이 처음나오는 위치 -> 8
[1,2,3,4,5,6,7,8,9,10]
l    r    mid     arr[mid]
0.   9    4          5
5.   9    7          8
8.   9.   8.         9
8.   7.   


// lower bound 구하는 코드
while l <= r {
    mid = (l + r) / 2
    if extractedArr[mid] < score {
        l = mid + 1
    } else { // extractedArr[mid] >= score
        r = mid - 1
    }
    print(l,r)
}
```
