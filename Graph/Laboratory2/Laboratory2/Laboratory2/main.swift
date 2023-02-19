//
//  main.swift
//  Laboratory2
//
//  Created by Kay on 2023/02/17.
//

/*
 17141
 연구소2
 */
import Foundation

//MARK: 시간복잡도 -> (바이러스의 위치들 C M) * M
// 조합은 가운데로 갈수록 값이 크다 -> 10C5 * 5 = 252 * 5

//MARK: Queue 구현
struct Queue<T> {
    var enqueueList: [T] = []
    var dequeueList: [T] = []
    
    var count: Int {
        return enqueueList.count + dequeueList.count
    }
    
    var isEmpty: Bool {
        return enqueueList.isEmpty && dequeueList.isEmpty
    }
    mutating func clear() {
        enqueueList.removeAll()
        dequeueList.removeAll()
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

//MARK: 조합
func combination<T>(_ arr: [T], _ number: Int) -> [[T]] {
    var result: [[T]] = []
    if arr.count < number { return result }
    
    func cycle(_ now: [T], _ index: Int) {
        if now.count == number {
            result.append(now)
            return
        }
        for i in index..<arr.count {
            cycle(now + [arr[i]], i + 1)
        }
    }
    cycle([], 0)
    return result
}

//MARK: 그래프 탐색 방향
let dy = [-1,0,1,0]
let dx = [0,1,0,-1]

//MARK: 입력 받기
let NM = readLine()!.split(separator: " ").map { Int(String($0))! }
let N = NM[0]
let M = NM[1]

var adjMatrix = [[Int]](repeating: [Int](), count: N)
var visited = [[Int]](repeating: [Int](repeating: 0, count: N ), count: N)

for i in 0..<N {
    adjMatrix[i].append(contentsOf: readLine()!.split(separator: " ").map { Int(String($0))!})
}

//MARK: 입력을 베이스로 빈칸, 벽, 바이러스 위치 저장
var emptyList: [(Int,Int)] = []
var wallList: [(Int,Int)] = []
var virusList: [(Int,Int)] = []

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

//MARK: 조합으로 M개의 바이러스 위치 구하기
var combinationArr = combination(virusList, M)

//MARK: virusList의 모든 좌표 0으로 만들기 함수
func makeVirusClean() {
    virusList.enumerated().forEach {
        adjMatrix[$0.element.0][$0.element.1] = 0
    }
}

//MARK: visited clear 함수
func visitedClear() {
    for i in 0..<N {
        for j in 0..<N {
            visited[i][j] = 0
        }
    }
}

//MARK: check if there zero exists
func checkZeroes() -> Bool {
    for i in 0..<N {
        for j in 0..<N {
            if adjMatrix[i][j] != 1 && visited[i][j] == 0 {
                return false
            }
        }
    }
    return true
}

/*
 
 메인로직 시작 전 알아두어야 할 주의사항!
 
 1. 바이러스를 어떻게 놓아도 100% 바이러스를 퍼뜨릴 수 없는 경우만 -1 (주어진 예외)

    7 2
    2 0 2 0 1 1 0
    0 0 1 0 1 0 0
    0 1 1 1 1 0 0
    2 1 0 0 0 0 2
    1 0 0 0 0 1 1
    0 1 0 0 0 0 0
    2 1 0 0 2 0 2
 
 2. 이미 바이러스가 다 펴져있어서 퍼뜨릴 필요가 없는 경우 -> 0 (히든 케이스)
 
    5 2
    1 1 1 1 1
    1 1 2 1 1
    1 1 2 1 1
    1 1 1 1 1
    1 1 1 1 1
 
 3. 앞의 두가지 상황이 둘다 아니라면 바이러스를 최소 경로로 퍼뜨리는 경우를 출력
 
     7 3
     2 0 0 0 1 1 0
     0 0 1 0 1 2 0
     0 1 1 0 1 0 0
     0 1 0 0 0 0 0
     0 0 0 2 0 1 1
     0 1 0 0 0 0 0
     2 1 0 0 0 0 2
 
 */

//MARK: 메인 로직 2 시작.
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
            if visited[ny][nx] > 0 || adjMatrix[ny][nx] == 1 || adjMatrix[ny][nx] == 2 { continue }
            visited[ny][nx] = visited[currentY][currentX] + 1
            result = visited[ny][nx] > result ? visited[ny][nx] : result
            queue.enqueue((ny,nx))
        }
    }
    if checkZeroes() == true {
        return result
    } else {
        return 987654321 // 방문할 수 없는 곳이 있었다면..
    }
}

var queue = Queue<(Int,Int)>()
var result = 987654321
var flag = true

//MARK: 메인 로직 1 시작.
combinationArr.enumerated().forEach {
    queue.clear()
    visitedClear()
    makeVirusClean()
    $0.element.enumerated().forEach {
        let virusLocationY = $0.element.0
        let virusLocationX = $0.element.1
        adjMatrix[virusLocationY][virusLocationX] = 2
        queue.enqueue((virusLocationY,virusLocationX))
        visited[virusLocationY][virusLocationX] = 1
    }
    let temp = bfs()
    result = result > temp ? temp : result // 최소값을 찾기 위한 로직
}

if result == 987654321 { // 모든 경우를 bfs로 탐색하고 나서도 result의 값이 987654321라면, 항상 100% 바이러스를 퍼뜨릴 수 없었다는 이야기.
    print(-1)
} else if result == 0 { // 만들어진 모든 조합을 반복문으로 돌았을 때 0이란것은 그래프 탐색을 시도 했지만 주변이 1로 둘러 싸여 있어 한번도 탐색을 하지 못해 바이러스를 퍼뜨리는데 0번이 걸린다는 이야기.
    print(result)
} else { // visited가 1부터 시작이므로 1을 빼준다.
    print(result - 1)
}
