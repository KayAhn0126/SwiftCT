# 1593 문자 해독
- 문자열
- 슬라이딩 윈도우

## 🍎 문제 접근
- 문제를 이해하는데 오래 걸렸다.
```bash
4 11
cAda
AbrAcadAbRa
```
- 예제를 다시 보자!
- 고고학자들이 찾고자 하는 단어는 cAda이다. 하지만 이 문자들을 AbrAcadAbRa 문자열 안에서 어떠한 형태로 있을지 모르는데 이때, 있을 수 있는 형태의 총 개수를 구하면 된다.
- 이 예제의 답은 2이다.
- **Acad**와 **cadA**. 이 두개는 cAda와 배치만 다를 뿐, 고고학자들이 찾는 문자들을 가지고 있기 때문이다.

## 🍎 문제 풀이
- 처음부터 시작해서 currentLength를 WLength가 될 때까지 하나씩 늘려준다.
    - 늘려주다가 currentLength와 WLength이 값이 같아지는 순간 -> 즉, 비교 할 수 있는 순간.
    - 대조군(wArr)과 실험군(sArr)의 값을 비교한다.
    - 비교해서 일치한다면 정답 += 1
```swift
import Foundation

extension String {
    subscript(idx: Int) -> Character? {
        guard(0..<count).contains(idx) else { return nil }
        let target = index(startIndex, offsetBy: idx)
        return self[target]
    }
}

let lengths = readLine()!.split(separator: " ").map { Int(String($0))! }
let WLength = lengths[0]
let SLength = lengths[1]

let W = readLine()!.map { Character(String($0)) }
let S = readLine()!.map { Character(String($0)) }

// 대문자 0 ~ 25까지, 소문자 26~51까지
var wArr = [Int](repeating: 0, count: 53) // 0 ~ 52
var sArr = [Int](repeating: 0, count: 53) // 0 ~ 52

// 먼저 w의 문자들을 카운팅 배열을 이용해 카운팅을 해준다.
// 대조군 만들기
for i in 0..<W.count {
    if "a" <= W[i] && W[i] <= "z" {
        wArr[Int(W[i].asciiValue!) - 97 + 26] += 1
    } else {
        wArr[Int(W[i].asciiValue!) - 65] += 1
    }
}

var currentLength = 0
var start = 0
var result = 0

// 실험군을 우측으로 한칸 늘려주면서 좌측은 한칸씩 땡겨주면서 비교하는 로직
for i in 0..<SLength {
    if "a" <= S[i] && S[i] <= "z" {
        sArr[Int(S[i].asciiValue!) - 97 + 26] += 1
    } else {
        sArr[Int(S[i].asciiValue!) - 65] += 1
    }
    currentLength += 1
    
    if currentLength == WLength { 
        if wArr == sArr { 
            result += 1 // wArr와 sArr가 일치한다면 답 += 1
        }
        if "a" <= S[start] && S[start] <= "z" {
            sArr[Int(S[start].asciiValue!) - 97 + 26] -= 1
        } else {
            sArr[Int(S[start].asciiValue!) - 65] -= 1
        }
        start += 1
        currentLength -= 1
    }
}
print(result)
```
