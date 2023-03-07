//
//  main.swift
//  Laboratory3
//
//  Created by Kay on 2023/02/19.
//

/*
 17142
 연구소 3
 */

/*
 바이러스가 비활성화된곳을 가면 활성화가 된다.
 비활성화되어있는 곳도 방문처리를 해주는데 대신, 카운트는 하지 않는다.
 맵에서 0인 부분만 카운트를 해준다.
 */

/*
 빈칸 0
 벽 1
 바이러스 활성화 2
 바이러스 비활성화 -2
 */


import Foundation

struct Queue<T> {
    var enqueueList: [T] = []
    var dequeueList: [T] = []
    
    var count: Int {
        return enqueueList.count + dequeueList.count
    }
    
    var isEmpty: Bool {
        return enqueueList.isEmpty && dequeueList.isEmpty
    }
    
    mutating func enqueue(_ element: T) {
        enqueueList.append(element)
    }
    
    mutating func dequeue() -> T? {
        if dequeueList.isEmpty {
            dequeueList = enqueueList.reversed()
            enqueueList.removeAll()
        }
        return dequeueList.popLast()
    }
}

func combination<T>(_ arr: [T], _ number: Int) -> [[T]] {
    var result: [[T]] = []
    if arr.count < number { return result }
    
    func cycle(_ now: [T], _ idx: Int) {
        if now.count == number {
            result.append(now)
            return
        }
        for i in idx..<arr.count {
            cycle(now + [arr[i]], i + 1)
        }
    }
    cycle([], 0)
    return result
}

let NM = readLine()!.split(separator: " ").map { Int(String($0))! }
let N = NM[0]
let M = NM[1]

var adjMatrix = [[Int]](repeating: [Int](), count: N)
var visited = [[Int]](repeating: [Int](repeating: 0, count: N), count: N)

for i in 0..<N {
    adjMatrix[i].append(contentsOf: readLine()!.split(separator: " ").map {  Int(String($0))! })
}

var emptyList: [(Int, Int)] = []
var wallList: [(Int, Int)] = []
var virusList: [(Int, Int)] = []

for i in 0..<N {
    for j in 0..<N {
        if adjMatrix[i][j] == 0 {
            emptyList.append((i,j))
        } else if adjMatrix[i][j] == 1 {
            wallList.append((i,j))
        } else {
            virusList.append((i,j))
        }
    }
}

//MARK: 그래프탐색
let dy = [-1,0,1,0]
let dx = [0,1,0,-1]

var queue = Queue<(Int,Int)>()

//MARK: 0이 있으면 True, 없으면 False
func checkZeroes() -> Bool {
    for i in 0..<N {
        for j in 0..<N {
            if visited[i][j] == 0 && adjMatrix[i][j] != 1 {
                return true
            }
        }
    }
    return false
}

func bfs() -> Int {
    var result = 0
    while !queue.isEmpty {
        let currentYX = queue.dequeue()!
        let currentY = currentYX.0
        let currentX = currentYX.1
        for i in 0..<4 {
            let ny = currentY + dy[i]
            let nx = currentX + dx[i]
            if ny < 0 || nx < 0 || ny >= N || nx >= N { continue }
            if adjMatrix[ny][nx] == 1 || visited[ny][nx] > 0 { continue }
            visited[ny][nx] = visited[currentY][currentX] + 1
            queue.enqueue((ny,nx))
            if adjMatrix[ny][nx] == 0 {
                result = visited[ny][nx] > result ? visited[ny][nx] : result
            }
        }
    }
    let hasZero = checkZeroes()
    if hasZero == true { // 0이 있는 경우
        return 987654321
    } else if result != 0 { // 0은 없고 result가 바뀐경우
        return result
    } else {            // 0은 없고, result가 0인 경우
        return 0
    }
}

func makeNegativeTwo() {
    virusList.enumerated().forEach {
        let Y = $0.element.0
        let X = $0.element.1
        adjMatrix[Y][X] = -2
    }
}

func visitedClear() {
    for i in 0..<N {
        for j in 0..<N {
            visited[i][j] = 0
        }
    }
}

let combiVirusList = combination(virusList, M)

var result = 987654321
combiVirusList.enumerated().forEach {
    makeNegativeTwo()
    visitedClear()
    $0.element.enumerated().forEach {
        let currentYX = $0.element
        let currentY = currentYX.0
        let currentX = currentYX.1
        visited[currentY][currentX] = 1
        adjMatrix[currentY][currentX] = 2
        queue.enqueue((currentY,currentX))
    }
    let temp = bfs()
    result = result > temp ? temp : result
}

if result == 987654321 {
    print(-1)
} else if result != 0 {
    print(result - 1)
} else {
    print(0)
}
