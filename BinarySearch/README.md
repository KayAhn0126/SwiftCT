# Binary Search List
| 제목 | 키워드 | 풀어보기 |
| :-: | :-: | :-: |
| [숫자 카드 2](https://github.com/KayAhn0126/SwiftCT/tree/main/BinarySearch/NumberCard2) | 배열에서 음수 관리하기 | [10816](https://www.acmicpc.net/problem/10816) |
| [수 찾기](https://github.com/KayAhn0126/SwiftCT/tree/main/BinarySearch/FindingNumber) | 이분탐색 | [1920](https://www.acmicpc.net/problem/1920) |
| [나무 자르기](https://github.com/KayAhn0126/SwiftCT/tree/main/BinarySearch/CuttingTree) | 이분탐색 | [2805](https://www.acmicpc.net/problem/2805) |
| [랜선 자르기](https://github.com/KayAhn0126/SwiftCT/tree/main/BinarySearch/CuttingLanCable) | 이분탐색 | [1654](https://www.acmicpc.net/problem/1654) |
| [과자 나눠주기](https://github.com/KayAhn0126/SwiftCT/tree/main/BinarySearch/SharingSnack) | 이분탐색 | [16401](https://www.acmicpc.net/problem/16401) |

# 기본 이분 탐색 코드
- 인자로 넘기는 array는 오름차순 정렬이 보장되어야 한다. -> O(logN)
```swift
func binarySearch(_ array: [Int], num: Int) -> Bool {
    var start = 0
    var end = (array.count - 1)
    
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

# 이분탐색이 인덱스 기반이 아니라면 어떤 상황이 발생하는가?
- 위의 기본 이분 탐색 코드를 보면 mid가 계속 바뀌면서 array에서 mid 인덱스가 찾는 숫자인지 확인한다.
- 근데, 만약 배열을 사용하지 않으면 어떤 상황이 발생하는가??
```swift
func find(_ number: Int) -> Int {
    var start = arr[0]
    var end = arr[arr.count - 1]
    var mid = 0
    while start <= end {
        mid = (start + end) / 2
        if mid == number { return 1 }
        if number < mid {
            end = mid - 1
        } else if number > mid {
            start = mid + 1
        }
    }
    return 0
}
```
- 배열 하나가 주어지고 그 배열에 찾는 숫자가 있는지 확인해 있다면 1, 없다면 0을 출력해야하는 [문제](https://www.acmicpc.net/problem/1920)를 풀어보자.
- 아래와 같은 입력이 주어졌다고 가정하자.
- 2
- 0 10
- 1
- 4
- 즉, 이 문제는 배열 A에 0과 10이 있는데 여기서 4를 찾는 예제다.
- 답은 0이 나와야 하지만 결과는 1이 나온다.
- 왜 그럴까?
    - 예제에서 start는 0, end는 10이되고, 그에따라 mid는 5가된다.
    - 이 코드는 어떤 숫자가 start와 end 사이에 있다면 무조건 있다고 판단하는 코드이다.
    - 0 ~ 10에서 특정값을 찾을때까지 이분 탐색을 하기 때문이다.
- **그래서 항상 이분탐색 코드는 인덱스의 위치를 바꿔가면서 배열에서 찾는것 이라고 기억하자!**
