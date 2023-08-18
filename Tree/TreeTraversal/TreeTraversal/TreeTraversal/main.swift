//
//  main.swift
//  TreeTraversal
//
//  Created by Kay on 2023/08/18.
//

/*
 1991
 트리 순회
 */

/*
 N은 최대 26(알파벳 숫자)
 트리가 나오면 노드와 노드를 연결지어 관계를 형성 해주자!
 
 전위, -> 루트, 왼쪽, 오른쪽 순
 중위, -> 왼쪽, 루트, 오른쪽 순
 후위  -> 왼쪽, 오른쪽 루트 순
 3개 각각 만들기
 
 */

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
