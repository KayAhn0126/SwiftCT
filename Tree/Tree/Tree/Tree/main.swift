//
//  main.swift
//  Tree
//
//  Created by Kay on 2023/01/10.
//

/*
 1068
 트리
 */
// 2nd week fast campus

/* 설계
 
 각 노드의 부모가 차례대로 주어진다.
 만약 노드의 부모가 없다면 -1이다 -> 즉 -1이 들어온 노드가 루트 노드라는 이야기
 
 -1 0 0 1 1 을 예시로 보자
 
 입력이 -1 0 0 1 1으로 들어왔다는 이야기는
 노드 0의 부모는 -1
 노드 1의 부모는 0
 노드 2의 부모는 0
 노드 3의 부모는 1
 노드 4의 부모는 1 이라는 이야기이다.
 
 즉, 노드 0은 자식으로 1과 2를 가지고 있고,
    노드 1은 자식으로 3과 4를 가지고 있다. 이것을 인접 리스트로 나타내면 아래와 같다.
 adjList[0][1,2]
 adjList[1][3,4]
 
 문제에서 요구하는 해는 어떤 노드를 지웠을때, 해당 트리의 리프 노드 갯수를 구하면 된다.
 
 리프노드는 자식이 없는 노드. dfs로 끝까지 파고들어서 해당 노드가 자식이 없다면 카운트를 증가시키면 된다.
 */

import Foundation

let totalNode = Int(readLine()!)!

var adjList = [[Int]](repeating: [Int](), count: totalNode)

var root = 0

let userInput = readLine()!.split(separator: " ").map { Int(String($0))! }

for currentNode in 0..<totalNode {
    let parentNode = userInput[currentNode]
    if parentNode == -1 {
        root = currentNode
    } else {
        adjList[parentNode].append(currentNode)
    }
}

let nodeToRemove = Int(readLine()!)!

func dfs(_ node: Int) -> Int {
    var result = 0
    var child = 0
    let childCount = adjList[node].count
    for childNode in 0..<childCount {
        if adjList[node][childNode] == nodeToRemove {
            continue
        }
        result += dfs(adjList[node][childNode])
        child += 1
    }
    if child == 0 {
        result = 1
    }
    return result
}

if root == nodeToRemove {
    print("0")
} else {
    print(dfs(root))
}
