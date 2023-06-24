//
//  main.swift
//  Surveillance
//
//  Created by Kay on 2023/06/23.
//

/*
 15683
 감시
 */

/*
 문제 이해하기
 5 종류의 CCTV가 있다.
 방향에 따른 가짓수를 알아보자.
 1 -> 4
 2 -> 2
 3 -> 4
 4 -> 4
 5 -> 1

 CCTV는 최대 8개
 각 CCTV는 4방향으로 돌수 있다.
 즉, 4^8 = 65536
 각 케이스마다 사각지대를 카운트하면, 최대 8*8 = 64
 시간복잡도는 65536 * 64 = 4194304
 */

/*
 필요한 로직
    1. 카메라를 돌리는 로직,
    2. 감시 영역 색칠 로직,
    3. 사각지대 구하기 로직
 */

import Foundation

struct CCTV {
    var y: Int
    var x: Int
    var type: Int // 여기서 type이란 몇 방향으로 돌수 있는지 확인하는 용도.
}

let NM = readLine()!.split(separator: " ").map { Int(String($0))! }
let N = NM[0]
let M = NM[1]
var map = [[Int]](repeating: [Int](), count: N)
for i in 0..<N {
    map[i].append(contentsOf: readLine()!.split(separator: " ").map { Int(String($0))! })
}

let rotate = [4,2,4,4,1]
var cctvMap = [CCTV]()

//MARK: 맵 복사를 위한 함수 -> 백트래킹 목적
func mapCopy(_ to: inout [[Int]], _ from: inout [[Int]]) {
    to = from
}

//MARK: 카메라가 비추는 곳의 값 변경하기
func update(_ dir: Int, _ cctv: CCTV) {
    var currentDir = dir % 4
    // 시계 방향으로 0,1,2,3
    if currentDir == 0 {
        for y in stride(from: cctv.y - 1, through: 0, by: -1) {
            if map[y][cctv.x] == 6 { break }
            map[y][cctv.x] = -1
        }
    }
    if currentDir == 1 {
        for x in cctv.x + 1..<M {
            if map[cctv.y][x] == 6 { break }
            map[cctv.y][x] = -1
        }
    }
    if currentDir == 2 {
        for y in cctv.y + 1..<N {
            if map[y][cctv.x] == 6 { break }
            map[y][cctv.x] = -1
        }
    }
    if currentDir == 3 {
        for x in stride(from: cctv.x - 1, through: 0, by: -1) {
            if map[cctv.y][x] == 6 { break }
            map[cctv.y][x] = -1
        }
    }
}

//MARK: 깊이 우선 탐색 + 백트래킹을 이용해서
func dfs(_ cctv_index: Int) {
    if cctv_index == cctvSize {
        var tempResult = 0
        for i in 0..<N {
            for j in 0..<M {
                if map[i][j] == 0 {
                    tempResult += 1
                }
            }
        }
        if tempResult < result {
            result = tempResult
        }
        return
    }
    var backUp = [[Int]](repeating: [Int](repeating: 0, count: M), count: N)
    var type = cctvMap[cctv_index].type
    for dir in 0..<rotate[type] {
        mapCopy(&backUp, &map)
        if type == 0 {
            update(dir, cctvMap[cctv_index])
        }
        if type == 1 {
            update(dir, cctvMap[cctv_index])
            update(dir + 2, cctvMap[cctv_index])
        }
        if type == 2 {
            update(dir, cctvMap[cctv_index])
            update(dir + 1, cctvMap[cctv_index])
        }
        if type == 3 {
            update(dir, cctvMap[cctv_index])
            update(dir + 1, cctvMap[cctv_index])
            update(dir + 3, cctvMap[cctv_index])
        }
        if type == 4 {
            update(dir, cctvMap[cctv_index])
            update(dir + 1, cctvMap[cctv_index])
            update(dir + 2, cctvMap[cctv_index])
            update(dir + 3, cctvMap[cctv_index])
        }
        dfs(cctv_index + 1)
        mapCopy(&map, &backUp)
    }
}

var cctvSize = 0
for i in 0..<N {
    for j in 0..<M {
        if map[i][j] != 0 && map[i][j] != 6 {
            cctvMap.append(CCTV(y: i, x: j, type: map[i][j] - 1))
            cctvSize += 1
        }
    }
}
var result = 100
dfs(0)
print(result)
