//
//  main.swift
//  BFS
//
//  Created by Kay on 2022/12/30.
//

// MARK: - 알고리즘 강의 BFS를 이용해 최단거리 구하는 기본 문제 ( 백준 아님 )
/*
 지문: 승원이는 당근을 좋아해서 당근마킷에 엔지니어로 취업했다. 당근을 매우좋아하기 때문에 차도 당근차를 샀다. 이 당근차는 한칸 움직일 때마다 당근을 내뿜으면서 간다. 즉, "한칸" 움직일 때 "당근한개"가 소모된다는 것이다. 승원이는 오늘도 아침 9시에 일어나 당근마킷으로 출근하고자 한다. 승원이는 최단거리로 당근마킷으로 향한다고 할 때 당근몇개를 소모해야 당근마킷에 갈 수 있는지 알아보자. 이 때 승원이는 육지로만 갈 수 있으며 바다로는 못간다. 맵의 1은 육지며 0은 바다를 가리킨다. 승원이는 상하좌우로만 갈 수 있다.

 입력

 맵의 세로길이 N과 가로길이 M 이 주어지고 이어서 N * M의 맵이 주어진다. 그 다음 줄에 승원이의 위치(y, x)와 당근마킷의 위치(y, x)가 주어진다.

 출력

 당근을 몇개 소모해야 하는지 출력하라.

 범위

 1 <= N <= 100

 1 <= M <= 100
 
 입력:
 5 5
 0 0
 4 4
 1 0 1 0 1
 1 1 1 0 1
 0 0 1 1 1
 0 0 1 1 1
 0 0 1 1 1
 
 출력: 9
 
 */
import Foundation

struct Queue<T> {
    private var queue: [T] = []
    private var head = 0
    
    var count: Int {
        return queue.count
    }
    
    var isEmpty: Bool {
        return queue.isEmpty
    }
    
    mutating func enqueue(_ element: T) {
        queue.append(element)
    }
    
    // MARK: - 디큐하기전 수량 체크 필수. count 보다 isEmpty로 체크하자
    mutating func dequeue() -> T {
        queue = queue.reversed()
        let dequeNumber = queue.popLast()!
        queue = queue.reversed()
        return dequeNumber
    }
}

var dy = [-1,0,1,0]
var dx = [0,1,0,-1]

var matrixSize = readLine()!.split(separator: " ").map { Int($0)! }
let N = matrixSize[0]
let M = matrixSize[1]

let startYX = readLine()!.split(separator: " ").map { Int($0)! }
let sY = startYX[0]
let sX = startYX[1]

let endYX = readLine()!.split(separator: " ").map { Int($0)! }
let eY = endYX[0]
let eX = endYX[1]

var adjmatrix = [[Int]]()
var visited = [[Int]](repeating: [Int](repeating: 0, count: M), count: N)

for _ in 0..<N {
    adjmatrix.append(readLine()!.split(separator: " ").map { Int($0)! })
}

var readyQueue = Queue<(Int,Int)>()
visited[sY][sX] = 1
readyQueue.enqueue((sY, sX))

while !readyQueue.isEmpty {
    let current = readyQueue.dequeue()
    
    let y = current.0
    let x = current.1
    
    for i in 0..<4 {
        let ny = y + dy[i]
        let nx = x + dx[i]
        if ny < 0 || nx < 0 || ny >= N || nx >= M { continue }
        if adjmatrix[ny][nx] == 0 { continue }
        if visited[ny][nx] != 0 { continue }
        visited[ny][nx] = visited[y][x] + 1 // 그래프에서 정점과 정점 사이 가중치가 같은때 최단거리 구하는 용도
        readyQueue.enqueue((ny,nx))
    }
}

for i in 0..<N {
    for j in 0..<M {
        print(visited[i][j], terminator: "")
    }
    print("")
}

print(visited[eY][eX])
