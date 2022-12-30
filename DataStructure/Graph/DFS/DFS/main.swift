//
//  main.swift
//  DFS
//
//  Created by Kay on 2022/12/30.
//

import Foundation

var size = 6
var adjList = [[Int]](repeating: [], count: size) // 인접 리스트 구현
var visited = [Bool](repeating: false, count: size) // 방문 노드 체크 배열 구현

func dfs(_ node: Int) {
    visited[node] = true
    print(node)
    adjList[node].enumerated().forEach {
        if visited[$0.element] == false {
            dfs($0.element)
        }
    }
    print("\(node)내 함수가 종료되었습니다.")
}

adjList[1].append(2)
adjList[1].append(3)
adjList[2].append(4)
adjList[4].append(2)
adjList[2].append(5)
dfs(1)






