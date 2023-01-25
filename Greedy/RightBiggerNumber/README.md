# 17298 오큰수

## 🍎 키워드
- 스택 구현하기
- N이 최대 1,000,000
- 이중 for 문으로 풀면 시간초과
## 🍎 지문
- 크기가 N인 수열 A = A1, A2, ..., AN이 있다. 수열의 각 원소 Ai에 대해서 오큰수 NGE(i)를 구하려고 한다. Ai의 오큰수는 오른쪽에 있으면서 Ai보다 큰 수 중에서 가장 왼쪽에 있는 수를 의미한다. 그러한 수가 없는 경우에 오큰수는 -1이다.
- 예를 들어, 
- A = [3, 5, 2, 7]인 경우 
    - NGE(1) = 5, NGE(2) = 7, NGE(3) = 7, NGE(4) = -1이다. 
- A = [9, 5, 4, 8]인 경우에는 
    - NGE(1) = -1, NGE(2) = 8, NGE(3) = 8, NGE(4) = -1이다.

## 🍎 문제 접근
- 이중 for 문으로 풀면 시간초과
- O(N)으로 풀 방법을 찾아야 한다.

## 🍎 문제 풀이
- 메인 로직
```swift
for i in 0..<numbers.count {
    while !myStack.isEmpty && numbers[myStack.top!] < numbers[i] {
        result[myStack.top!] = numbers[i]
        myStack.pop()!
    }
    myStack.push(i)
}
```
- 중요한것은 stack에 값이 아닌 **인덱스**를 넣어주는것이다.
- 예시를 통해 로직을 알아보자
- numbers = [3, 5, 2, 7]인 경우
- i = 0, myStack이 비어있으므로 myStack.push(0)
- i = 1, myStack이 비어있지 않고 numbers[0] < numbers[1]이 참이므로 result[0] = numbers[1], myStack에서 pop해준다. 그리고 myStack.push(1)
- i = 2, myStack이 비어있지 않지만 numbers[1] < numbers[2]이 거짓이므로 패스 그리고 myStack.push(2) 
- i = 3, myStack이 비어있지 않고 numbers[2] < numbers[3]이 참이므로 result[2] = numbers[3], myStack에서 pop해준다.
- i = 3, myStack이 비어있지 않고 numbers[1] < numbers[3]이 참이므로 result[1] = numbers[3], myStack에서 pop해준다.
- for문 종료.
- result에는 5, 7, 7, -1이 들어있다.
