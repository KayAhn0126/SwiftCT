# 1991 트리 순회
- 트리

## 🍎 지문 해석
- 전위, 중위, 후위 순회한 결과값 출력하기

## 🍎 문제 접근
- N (max 26)
- N줄에 걸쳐 해당 노드와 그의 왼쪽 오른쪽이 주어진다.
    - 자식 노드가 없는 경우는 .으로 표현
- 항상 A가 루트노드가 된다.
- 전위
    - 루트, 왼쪽, 오른쪽
- 중위
    - 왼쪽, 루트, 오른쪽
- 후위
    - 왼쪽, 오른쪽, 루트

## 🍎 문제 풀이 및 전체 코드
- **트리 문제를 풀때는 항상 노드 구조체를 만들어주자!**
- 자식노드가 없는 경우는 "."으로 표현하니 런타임에러 방지를 위해..
    - node.left != "." 이런식으로 "."이 아닌 경우만 재귀를 실행할 수 있게 해주자!
```swift
import Foundation

struct Node {
    var root: Character
    var left: Character
    var right: Character
}

let total = Int(readLine()!)!
var nodeDictionary: [Character: Node] = [:]
for _ in 0..<total {
    let info = readLine()!.split(separator: " ").map { Character(String($0)) }
    nodeDictionary[info[0]] = Node(root: info[0], left: info[1], right: info[2])
}

// 전위 -> 루트, 왼쪽, 오른쪽 순
func preOrder(_ node: Node) {
    print(String(node.root), terminator: "")
    if node.left != "." {
        preOrder(nodeDictionary[node.left]!)
    }
    if node.right != "." {
        preOrder(nodeDictionary[node.right]!)
    }
}

// 중위 -> 왼쪽, 루트, 오른쪽 순
func inOrder(_ node: Node) {
    if node.left != "." {
        inOrder(nodeDictionary[node.left]!)
    }
    print(String(node.root), terminator: "")
    if node.right != "." {
        inOrder(nodeDictionary[node.right]!)
    }
}

// 후위 -> 왼쪽, 오른쪽 루트 순
func postOrder(_ node: Node) {
    if node.left != "." {
        postOrder(nodeDictionary[node.left]!)
    }
    if node.right != "." {
        postOrder(nodeDictionary[node.right]!)
    }
    print(String(node.root), terminator: "")
    
}
preOrder(nodeDictionary["A"]!)
print("")
inOrder(nodeDictionary["A"]!)
print("")
postOrder(nodeDictionary["A"]!)
print("")
```
