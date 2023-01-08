//
//  main.swift
//  Laboratory
//
//  Created by Kay on 2023/01/08.
//

/*
 14502
 연구소
 */
// 2nd week fast campus

/*
 문제 풀이
 1. 시간복잡도 계산 64C3 * (64 + 64)
 2. 벽 3개 세우기
    2-1. 벽은 어디에 세울수 있나? -> 0의 자리에 세울수 있음
    2-2. 어떻게 세울수 있나? -> 64C3 (조합) 으로 세울수 있음
 3. 바이러스 퍼뜨리기
 4. 바이러스가 다 퍼진 지역에서 2차원 배열 안전영역 구하기
 */

import Foundation

let dy = [-1,0,1,0]
let dx = [0,1,0,-1]

let NM = readLine()!.split(separator: " ").map { Int(String($0))! }
let N = NM[0]
let M = NM[1]

var adjMatrix = [[Int]](repeating: [Int](), count: N)
var visited = [[Int]](repeating: [Int](repeating: 0, count: M), count: N)

var virusListFromGiven: [(Int, Int)] = [] // 현재 바이러스가 있는 위치 리스트
var wallPossibleListFromGiven: [(Int, Int)] = [] // 벽을 세울 수 있는 공간을 가진 리스트 (맵에서 0인곳)

var biggestNumber = -10000000

for i in 0..<N {
    adjMatrix[i].append(contentsOf: readLine()!.split(separator: " ").map { Int(String($0))! })
}

// MARK: - 바이러스와 벽이 어느 위치에 있는지 각각의 리스트에 넣기
func fillListsFromMatrix() {
    for i in 0..<N {
        for j in 0..<M {
            if adjMatrix[i][j] == 2 {
                virusListFromGiven.append((i,j))
            } else if adjMatrix[i][j] == 0 {
                wallPossibleListFromGiven.append((i,j))
            }
        }
    }
}

// MARK: - 3 개의 벽 세우고
func buildRandomWallAndCheck() {
    let currentlyZeroCount = wallPossibleListFromGiven.count
    for i in 0..<currentlyZeroCount {
        for j in i + 1 ..< currentlyZeroCount {
            for k in j + 1 ..< currentlyZeroCount {
                adjMatrix[wallPossibleListFromGiven[i].0][wallPossibleListFromGiven[i].1] = 1
                adjMatrix[wallPossibleListFromGiven[j].0][wallPossibleListFromGiven[j].1] = 1
                adjMatrix[wallPossibleListFromGiven[k].0][wallPossibleListFromGiven[k].1] = 1
                let result = afterSpreadVirusCheckWhichIsAvailable()
                biggestNumber = result > biggestNumber ? result : biggestNumber
                adjMatrix[wallPossibleListFromGiven[i].0][wallPossibleListFromGiven[i].1] = 0
                adjMatrix[wallPossibleListFromGiven[j].0][wallPossibleListFromGiven[j].1] = 0
                adjMatrix[wallPossibleListFromGiven[k].0][wallPossibleListFromGiven[k].1] = 0
            }
        }
    }
}


// MARK: - 바이러스 퍼뜨리기
func spreadVirusDFS(_ y: Int, _ x: Int) {
    visited[y][x] = 2
    for i in 0..<4 {
        let ny = y + dy[i]
        let nx = x + dx[i]
        if ny < 0 || nx < 0 || ny >= N || nx >= M || adjMatrix[ny][nx] == 1 || visited[ny][nx] == 2 { continue }
        spreadVirusDFS(ny,nx)
    }
}

// MARK: - 방문 배열 초기화
func emptyVisitedArr() {
    for i in 0..<N {
        for j in 0..<M {
            visited[i][j] = 0
        }
    }
}

// MARK: - 바이러스 퍼뜨리고 몇 군데가 안전한지 체크하기
func afterSpreadVirusCheckWhichIsAvailable() -> Int {
    var counter = 0
    
    emptyVisitedArr()
    virusListFromGiven.enumerated().forEach {
        spreadVirusDFS($0.element.0,$0.element.1)
    }
    
    for i in 0..<N {
        for j in 0..<M {
            if visited[i][j] == 0 && adjMatrix[i][j] == 0 {
                counter += 1
            }
        }
    }
    return counter
}

fillListsFromMatrix()
buildRandomWallAndCheck()
print(biggestNumber)


//
//for i in 0..<N {
//    for j in i+1..<N {
//        for k in j+1..<N {
//            print(i,j,k)
//        }
//    }
//}
//print("")
//for i in 0..<N {
//    for j in 0..<i {
//        for k in 0..<j {
//            print(i,j,k)
//        }
//    }
//}
