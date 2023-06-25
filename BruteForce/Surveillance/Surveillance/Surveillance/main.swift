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
    var type: Int // type이라는 프로퍼티는 CCTV가 어떤 타입인지 저장한다. 또, 이 정보를 이용해 rotate 배열에서 최대 몇 방향을 회전해야 하는지 알 수 있다.
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

//MARK: 카메라가 감시하는 영역의 값 변경하기
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
    // cctvSize에 도달했다는것은 마지막 cctv까지 왔다는 이야기
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
    // 백트래킹을 위해 현재 맵을 저장하기 위한 2차원 배열
    var backUp = [[Int]](repeating: [Int](repeating: 0, count: M), count: N)
    // 카메라가 들어있는 배열에서 cctv_index로 접근해 카메라가 어느 종류의 카메라인지 확인한다.
    var type = cctvMap[cctv_index].type
    // 카메라의 종류를 알았다면 얼만큼 회전해야 하는지 저장되어 있는 rotate 배열에 접근해 값을 가져온다.
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

// DFS 탐색시 끝에 도달했다라는 기저사례를 만들기 위한 cctvSize.
var cctvSize = 0
for i in 0..<N {
    for j in 0..<M {
        if map[i][j] != 0 && map[i][j] != 6 {
            cctvMap.append(CCTV(y: i, x: j, type: map[i][j] - 1))
            cctvSize += 1
        }
    }
}

// 최대 사각지대의 갯수는 8 * 8인 64개 이지만 100으로 놓았다.
var result = 100
// cctv 객체들이 들어있는 cctvMap의 첫번째 요소부터 시작한다.
dfs(0)
print(result)
