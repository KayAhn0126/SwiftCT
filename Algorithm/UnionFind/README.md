# Union Find
## 🍎 개념 설명
- 이코테 책에서 가져온 유니온파인드 코드를 스위프트로 바꿔보았다.
```swift
func find_parent(_ x: Int) -> Int {
    if parent[x] != x {
        return find_parent(parent[x])
    }
    return x
}
```
- 만약 parent[x]가 x가 아니라면, x의 조상을 find_parent 함수의 인자로 넣는다.
- 여기서 parent배열에는 초기에 자기 자신의 값이 들어있기 때문에 parent[x]가 자신이 아니라면 다시 조상을 찾으러 재귀함수를 실행하는것이다.
- 위의 함수가 답을 구하는데 문제는 없지만, 최악의 경우 아래와 같은 상황이 발생할 수도 있다.
 ```bash
 노드 번호   1 2 3 4 5
 부모       1 1 2 3 4
 ```
- 위의 함수에 적용된 알고리즘을 이용한다면 노드의 개수 N개 * union 또는 find의 개수 M개 즉, 최악의 경우 시간복잡도는 O(NM)이다. -> 매우 비효율적.
- 이 경우 아주 간단하게 **경로 압축(Path Compression)기법**을 적용하면 시간복잡도를 개선시킬 수 있다.
- 경로 압축은 find 함수를 재귀적으로 호출한 뒤에 부모 테이블 값을 갱신하는 기법이다.
- **찾기(find_parent) 함수**
```swift
func find_parent(_ x: Int) -> Int {
    if parent[x] != x {
        parent[x] = find_parent(parent[x])
    }
    return parent[x]
}
```
- 이렇게 함수를 구현하면 각 노드에 대하여 find함수를 호출한 이후에, 해당 노드의 루트 노드가 바로 부모 노드가 된다.
- **합치기(union_parent) 함수**
```swift
func union_parent(_ a: Int, _ b: Int) {
    let a = find_parent(a)
    let b = find_parent(b)
 
    if a < b {
        parent[b] = a
    } else {
        parent[a] = b
    }
}
```
## 🍎 백준 - 1717번 (집합의 표현) 문제를 통한 기본 사용법 알아보기
```swift
import Foundation

let NM = readLine()!.split(separator: " ").map { Int(String($0))! }
let N = NM[0]
let M = NM[1]

var parent = [Int](repeating: 0, count: N + 1)
for i in 1...N {
    parent[i] = i
}

func find_parent(_ x: Int) -> Int {
   if parent[x] != x {
       parent[x] = find_parent(parent[x])
   }
    return parent[x]
}

func union_parent(_ a: Int, _ b: Int) {
   let a = find_parent(a)
   let b = find_parent(b)

   if a < b {
       parent[b] = a
   } else {
       parent[a] = b
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
