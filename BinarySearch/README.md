# Binary Search List
| 제목 | 키워드 | 풀어보기 |
| :-: | :-: | :-: |
| [숫자 카드 2](https://github.com/KayAhn0126/SwiftCT/tree/main/BinarySearch/NumberCard2) | 배열에서 음수 관리하기 | [10816](https://www.acmicpc.net/problem/10816) |
| [수 찾기](https://github.com/KayAhn0126/SwiftCT/tree/main/BinarySearch/FindingNumber) | 이분탐색 | [1920](https://www.acmicpc.net/problem/1920) |
| [나무 자르기](https://github.com/KayAhn0126/SwiftCT/tree/main/BinarySearch/CuttingTree) | 이분탐색 변형 | [2805](https://www.acmicpc.net/problem/2805) |
| [랜선 자르기](https://github.com/KayAhn0126/SwiftCT/tree/main/BinarySearch/CuttingLanCable) | 이분탐색 변형 | [1654](https://www.acmicpc.net/problem/1654) |

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
