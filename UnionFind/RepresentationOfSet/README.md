# 1717 집합의 표현
## 🍎 문제 접근
- 처음에는 Set을 이용해 풀어보았고 틀렸습니다가 나와서 반례를 찾아봤다.
- 반례
```bash
3 3
0 1 2
0 1 3
1 2 3
out: NO
나의 답: YES
```
- 내가 문제를 이해한 방식을 합집합이라 인접리스트 + 양방향 간선을 두면 되겠다 생각했다.
- 즉, 0 1 2 -> 1번셋과 2번셋 합침. 인접리스트에 서로를 추가.
- 하지만 문제는 유니언 파인드를 이용해서 특정 두 노드에 대해서 해당 노드들의 조상이 같은지 출력하는 프로그램을 구현해야 했다.
- 아래는 유니언 파인드를 사용한 문제 풀이 전체 코드

## 🍎 문제 풀이
```swift
import Foundation

let NM = readLine()!.split(separator: " ").map { Int(String($0))! }
let N = NM[0]
let M = NM[1]

var parent = [Int](repeating: 0, count: N + 1)
for i in 1...N {
    parent[i] = i
}

// 조상 노드를 찾는 함수
func find_parent(_ x: Int) -> Int {
    if parent[x] != x { // parent[x]가 자신이 아니라면 
        parent[x] = find_parent(parent[x])
    }
    return parent[x]
}

// 노드를 합칠때, 조상 노드를 먼저 찾고 비교적 큰 숫자가 더 작은 숫자쪽으로 바라보게 한다.
func union_parent(_ a: Int, _ b: Int) {
    let a = find_parent(a)
    let b = find_parent(b)

    if a < b {
        parent[b] = a // b의 조상은 a다
    } else {
        parent[a] = b // a의 조상은 b다
    }
}

for i in 0..<M {
    let operAB = readLine()!.split(separator: " ").map { Int(String($0))! }
    let oper = operAB[0]
    let a = operAB[1]
    let b = operAB[2]
    if oper == 0 {
        union_parent(a,b)
    } else {
        if find_parent(a) == find_parent(b) {
            print("YES")
        } else {
            print("NO")
        }
    }
}
```
