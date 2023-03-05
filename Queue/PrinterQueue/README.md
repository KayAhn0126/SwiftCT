# 1966 프린터 큐
- Queue를 이용한 구현

## 🍎 문제 접근
- 먼저 기준점이 될 배열을 주어진 배열을 내림차순으로 정렬해 새로 만든다.
- 문제에서 구해달라는 현재 Queue에 있는 문서의 수와 중요도가 주어졌을 때, 어떤 한 문서가 몇 번째로 인쇄되는지 알아내는 것이다
- 조심해야 할 점.
    - 같은 수가 여러개 있을 수 있다.
- 같은 수가 여러개 있을 수 있으니 탈출 조건을 꼼꼼하게 세워보자

## 🍎 문제 풀이
- 코드를 보면서 어떤 생각을 하고 구현했는지 알아보자
- 중요한 부분만 가져왔다.
```swift
// 기존 배열을 내림차순으로 정렬한 배열
// 이 배열의 0번째 인덱스와 맞으면 popFront()할 것이다.
var sortedArr = arr.sorted(by: >)

// 특정 문서의 실제 숫자와 기존 배열에서 인덱스
let number = arr[docsCountFind[1]]
var index = docsCountFind[1] // 궁금한 숫자의 인덱스 (변화한다!)
    
// 몇번 popFront()되었는지 세는 카운터
var counter = 1
while true {
    // 만약 특정 문서의 인덱스가 0, 즉 빠져나갈수 있고, 또 중요도 또한 이번에 빠져나갈 순서라면 답 출력 후, 무한 반복을 종료한다.
    if (index == 0) && sortedArr[0] == number {
    print(counter)
        break
    }
    
    // 기존 배열의 앞 숫자와 중요도 배열의 앞 숫자가 맞으면 pop한다
    // counter도 늘려준다.
    if arr[0] == sortedArr[0] {
        arr.removeFirst()
        sortedArr.removeFirst()
        counter += 1
        index -= 1
    } else { // 다르다면 뒤로 넘겨야 하는데 이때 인덱스 처리도 잘 해주면 된다.
        arr.append(arr[0])
        arr.removeFirst()
        if index == 0 {
            index = arr.count - 1
        } else {
            index -= 1
        }
    }
}
```
