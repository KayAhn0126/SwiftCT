# 3986 좋은 단어

## 🍎 키워드
- 문제 해결 방법
- 스택
- 시간 복잡도

## 🍎 문제 풀이
- 문자열 문제가 나왔을 때 혼자 몇가지 시도를 해보고 감이 안올때 강사님이 추천해주신 방법이 있다.
- 만약 "ABAB"라는 문자열이 있다고 하자.
- 이 문자가 좋은 단어 (단어 위로 아치형 곡선을 그어 같은 글자끼리(A는 A끼리, B는 B끼리) 쌍을 짓기로 하였다. 만약 선끼리 교차하지 않으면서 각 글자를 정확히 한 개의 다른 위치에 있는 같은 글자와 짝 지을수 있다면, 그 단어는 '좋은 단어'이다) 인지 확인하고 싶을때 패턴을 읽을 수 없다면 아래와 같이..
    - 반시계 방향으로 90도 돌려보기,
        - B
        - A
        - B
        - A
    - 뒤집어보기,
        - BABA
    - 하나 더 붙여보기
        - ABABABAB
    - 위의 3가지를 추천하셨다.
- ABAB는 좋은 단어가 아니다.
- 이제, 다른 예제를 테스트 해봤다.
- "AABB" -> 좋은 단어
    - 반시계 방향으로 90도 돌려보기
        - B
        - B
        - A
        - A
- "ABBA" -> 좋은 단어
    - 반시계 방향으로 90도 돌려보기
        - A
        - B
        - B
        - A
- 반시계 방향으로 90도 돌렸을 때, 테트리스처럼 같은 단어끼리 만나면 터져 없어진다고 생각을 하고, 다 터져 없어지면 좋은단어, 무언가 남아있다면 좋은단어가 아니다.

## 🍎 시간 초과
- testString을 입력 받고 testString을 for문으로 돌면서 문제를 해결하려 했는데 시간초과가 났다.
- 처음엔 로직이 잘못되었나 싶어서 시간복잡도를 다시 계산해봤다.
- 1 <= N <= 100
- 단어의 길이 2 <= len(word) <= 100,000
- 최대 연산 10,000,000으로 생각해 잘 되겠구나 싶었고 Xcode에서 예제 테스트도 정상적으로 통과해서 바로 백준에 제출했더니 시간초과가 났다. 
- 저번에 공부했던 양방향 접근 컬렉션이 생각이 났고 다시 찾아봤다.
- String은 양방향 접근 컬렉션(Bidirectional Collection) 프로토콜을 채택하고 있고, extension에서 index(before:)메서드를 구현 함 으로써 준수하고 있다. 즉, String타입으로 생성된 객체는 Bidirectional Collection에 있는 메서드를 사용할 수 있다. 내가 사용한 index(_ i: String.Index, offsetBy distance: Int) 또한 Bidirectional Collection의 인스턴스 메서드이다.
- index(_ i: String.Index, offsetBy distance: Int)메서드의 시간복잡도는 O(n)이고, 그 뜻은 매번 저 메서드가 실행되면 O(n)번이 실행된다는 의미이다.
- 최악은 100,000 * 100,000 = 백억..
- 아래 코드에서 주석처리된 부분.
```swift
for _ in 0..<number {
    let testString = readLine()!
    ...
    for j in 0..<length {
        //let nextString = String(testString[testString.index(testString.startIndex, offsetBy: j)])
    }
    ...
}
print(result)
```
- 이를 **Array가 RandomAccessCollction의 접근 시간복잡도가 O(1)인 점을 이용해 해결했다.**
- 간단하게 testString을 배열화 시켰다.
- Array는 RandomAccessCollection 프로토콜을 준수하고 있고, RandomAccessCollection에서의 접근 시간복잡도는 O(1)을 보장하기 때문이다.
```swift
for _ in 0..<number {
    let testString = readLine()!
    var myStack = Stack<String>()
    let length = testString.count // O(n)
    let testStringArr = [Character](testString) 
    for j in 0..<length {
        let nextString = String(testStringArr[j]) // O(1)
        if myStack.count > 0 {
            if myStack.top()! == nextString {
                myStack.pop()
            } else {
                myStack.push(nextString)
            }
        } else {
            myStack.push(nextString)
        }
    }
    if myStack.isEmpty {
        result += 1
    }
}
print(result)
```
- length의 testString.count도 while문으로 해결하면 조금 더 좋아지지 않을까 하는 생각이 든다.

## 🍎 Citation
- [Bidirectional Collection](https://0urtrees.tistory.com/120)
- [왜 Swift 에서 문자열은 인덱스로 조회하지 못할까?](https://velog.io/@dongklee42/%EC%99%9C-Swift-%EC%97%90%EC%84%9C-%EB%AC%B8%EC%9E%90%EC%97%B4%EC%9D%80-%EC%9D%B8%EB%8D%B1%EC%8A%A4%EB%A1%9C-%EC%A1%B0%ED%9A%8C%ED%95%98%EC%A7%80-%EB%AA%BB%ED%95%A0%EA%B9%8C)
