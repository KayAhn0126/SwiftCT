# General

## 🍎시간복잡도
### 📖 문제에 주어진 범위와 메모리 제한 확인
- 보통 문제에 주어진 범위는 입력에 대한 범위이다.
    - 만약 입력에 대한 범위가 아니라 logic에 사용될 어떤 배열의 범위가 1000만이다면 로직을 다시 생각해보자.(C++기준) -> 메모리 초과
- 재귀함수의 시간 복잡도 = mainLogic * 함수 호출 횟수

### 📖 제한 시간이 1초 일 경우, N 의 범위에 따른 시간 복잡도 선택
- 채점 컴퓨터는 1초에 1억번 연산한다.
- 즉, 어떤 로직이 있다면 그 로직은 1초에 1억번 이하로 연산을 해야한다는 뜻.
    - **N^3이던 NlogN이던 상관없이 1초에 연산이 1억번 이하로 이뤄져야한다.**
- N 의 범위가 500 인 경우
    - 시간 복잡도가 O(N^3) 이하인 알고리즘을 설계
- N 의 범위가 2,000 인 경우
    - 시간 복잡도가 O(N^2) 이하인 알고리즘을 설계
- N 의 범위가 100,000 인 경우
    - 시간 복잡도가 O(NlogN) 이하인 알고리즘을 설계
- N 의 범위가 10,000,000 인 경우
    - 시간 복잡도가 O(N) 이하인 알고리즘을 설계
- N 의 범위가 10,000,000,000 인 경우
    - 시간 복잡도가 O(logN) 이하인 알고리즘을 설계

### 📖 Two Sum 문제를 푸는 여러 방법(시간복잡도 관점)
- n개의 정수가 저장되어 있는 배열이 하나 주어진다. 배열의 원소를 두 개 더해서 target number가 될 수 있다면 True. 불가하면 False를 반환해야하는 문제가 있다.
- 이 문제를 3가지 방법으로 풀 수 있다.
1. N^2
    - 완전 탐색
    - 2중 for문을 돌면서 i와 i + 1을 더한값이 타켓이 되는지.
    - N이 10000이면 위험하다!
2. NlogN
    - 정렬(NlogN)을 사용해서 양쪽에 포인터를 두고 찾는 방법
    ```swift
    func twoSum(_ arr: [Int], _ target: Int) -> Bool {
        arr.sort()
        var l = 0
        var r = arr.count - 1
        while l < r {
            if target > arr[l] + arr[r] { l += 1 }
            else if target < arr[l] + arr[r] { r -= 1 }
            else return true
        }
        return false
    }
    ```
3. N
    - Dictionary를 사용한 O(N)에 문제 해결
    - arr = [4,1,7,9,3,16,5] 라고 해보자
    - target number = 14
    - index 0 부터 시작.
    - 만약 dictionary[target number - 4]이 비어있다면, dictionary[4] = 10
    - 만약 dictionary[target number - 1]이 비어있다면, dictionary[1] = 13
    - 만약 dictionary[target number - 7]이 비어있다면, dictionary[7] = 7
    - 만약 dictionary[target number - 9]이 비어있다면, dictionary[9] = 5
    - ...
    - 만약 dictionary[target number - 5]가 비어있다면, dictionary[5] = 9를 해줘야 하지만, dictionary[9]에는 값이 비어있지 않고 존재하기 때문에 5,9를 반환
    ```swift
    var arr = [4,1,7,9,3,16,5]
    func twoSum(_ arr: [Int], _ targetNum: Int) {
        var dictionary: [Int:Int] = [:]
        arr.enumerated().forEach {
            if dictionary[targetNum - $0.element] == nil {
                dictionary[$0.element] = targetNum - $0.element
            } else {
                print($0.element, targetNum - $0.element)
            }
        }
    }
    twoSum(arr, 14)
    ```


## 🍎 구현
- 순서
    - 문제를 본다 (전체적으로)
    - 해석 (최대한 많은 시간 투자)
        - 최대, 최소 범위 파악
        - 단순 구현이면 구현
        - 무식하게 풀 수 있다면 무식하게 풀기 (완전 탐색(브루트 포스))
        - 다른 알고리즘
        - 제출하기 전 반례 생각하기
    - 코드를 작성


## 🍎 펜윅트리와 이분탐색
- 둘은 다른 알고리즘이지만 어떤 유동적인 배열에서 특정 요소를 logn만에 찾을수 있다.
- 하지만 펜윅트리는 무조건 새로운 배열을 만들어야 하고 이분탐색은 그렇지 않아도 된다.
- 만약  특정요소를 찾는 로직의 필요한 배열의 크기가 10,000,000(천만)이라면 새로운 배열을 만드는 펜윅트리 보다는 이분탐색을 사용하자


