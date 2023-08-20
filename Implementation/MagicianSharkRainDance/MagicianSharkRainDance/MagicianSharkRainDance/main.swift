//
//  main.swift
//  MagicianSharkRainDance
//
//  Created by Kay on 2023/08/20.
//

/*
 21610
 마법사 상어와 비바라기
 */

/*
 N = max 50, n * n = 2500
 M = max 100개
 
 로직 생각해보자.
 현재 구름 위치
 구름위치에 비 내리게하는 함수
 첫 구름 위치
 세트에서 여집합 사용하기 or 계속 50 * 50 돌면서 아닌부분 찾기?
 
 초기에 구름이 생긴다.
 이동한다. -> 다 이동하고 나서 구름의 위치에 1을 더한다. 2500 *100 * 50 = 12500000
 대각선에 물이 있는반큼 다시 물이 증가한다. 2500 * 4 = 10000
 이때 맵 전체를 돌면서 물이 2 이상이면서 이전에 구름이 있던칸이 아니라면 구름 배열에 넣어준다.
 2500 * 100 = 250000
 
 12500000 + 10000 + 250000 + 마지막 계산을 위해 전체 탐색 + 2500 -> 1초안에 가능하다.
 */

import Foundation

let NM = readLine()!.split(separator: " ").map { Int(String($0))! }
let N = NM[0]
let M = NM[1]

var arr = [[Int]]()
for _ in 0..<N {
    arr.append(readLine()!.split(separator: " ").map { Int(String($0))! })
}
var moveArr = [(Int, Int)]()
for _ in 0..<M {
    let temp = readLine()!.split(separator: " ").map { Int(String($0))!}
    moveArr.append((temp[0]-1, temp[1]))
}

// Set의 요소로 사용될 Location 구조체 정의
struct Location: Hashable {
    var Y: Int
    var X: Int
}

// 2차원 배열의 모든 위치를 저장하는 세트 -> 나중에 차집합을 사용하기 위함
var totalCloudSet = Set<Location>()
for i in 0..<N {
    for j in 0..<N {
        totalCloudSet.insert(Location(Y: i, X: j))
    }
}

// 대각선 계산을 위한 배열
let diagonalDirections = [(-1,-1), (-1,1), (1,-1), (1,1)]
// 8방향 계산을 위한 배열
let eightDirections = [(0,-1), (-1,-1), (-1,0), (-1,1), (0,1), (1,1), (1,0), (1,-1)]

// 구름의 위치를 가지는 배열, 초기에는 지문에서 주어진대로..
var cloudList = [(N-1,0), (N-1,1), (N-2,0), (N-2,1)]

//MARK: 구름을 실제로 움직이는 로직
func cloudeMove(_ direction: (Int, Int), _ times: Int) {
    var newCloudList = cloudList
    for _ in 0..<times {
        for index in 0..<newCloudList.count {
            var nextY = newCloudList[index].0 + direction.0
            var nextX = newCloudList[index].1 + direction.1
            if nextY < 0 {
                nextY = N - 1
            }
            if nextX < 0 {
                nextX = N - 1
            }
            if nextY == N {
                nextY = 0
            }
            if nextX == N {
                nextX = 0
            }
            newCloudList[index] = (nextY, nextX)
        }
    }
    cloudList = newCloudList
}

//MARK: 현재 구름 위치에서 모든 대각선 방향에 물이 있다면 arr 배열내 물의 높이를 올려주는 로직
func calculateDiagonal() {
    let cloudCount = cloudList.count
    for i in 0..<cloudCount {
        let currentLocation = cloudList[i]
        let cY = currentLocation.0
        let cX = currentLocation.1
        for j in diagonalDirections {
            let nY = currentLocation.0 + j.0
            let nX = currentLocation.1 + j.1
            if nY < 0 || nX < 0 || nY >= N || nX >= N { continue }
            if arr[nY][nX] >= 1 {
                arr[cY][cX] += 1
            }
        }
    }
}

//MARK: 모든 구름에 1만큼의 물을 더하는 로직
func addOne() {
    for i in cloudList {
        arr[i.0][i.1] += 1
    }
}

//MARK: 현재 구름이 아니면서 물의 양이 2 이상인 공간을 구름 배열에 넣는 로직
// - 차집합을 이용해 2중 for문 피하기.
func getRestCloud() {
    // 현재 구름 위치를 Set<Location> 형태의 세트로 만들어주기
    var currentCloudSet = Set(cloudList.map { Location(Y: $0.0, X: $0.1) })
    
    // 2차원배열의 모든 위치(모든 구름의 위치)를 가지고 있는 Set에서 현재 구름위치를 빼주어 남은 위치들만 남기기 + 배열화
    let tempArr = Array(totalCloudSet.subtracting(currentCloudSet))
    
    // 위치들을 순회하면서 2 이상인 곳들을 튜플 형태로 만들어 새로운 배열에 넣어주기
    let tempCloudList = tempArr.filter { arr[$0.Y][$0.X] >= 2 }.map { ($0.Y, $0.X) }
    
    // 물을 2씩 차감하기
    tempCloudList.forEach {
        arr[$0][$1] -= 2
    }
    
    // 기존 구름들의 위치를 가지고 있는 배열에 대입
    cloudList = tempCloudList
}

//MARK: 마지막에 모든 물의 양을 구하는 로직
func getResult() -> Int {
    var result = 0
    for i in 0..<N {
        for j in 0..<N {
            result += arr[i][j]
        }
    }
    return result
}

//MARK: 메인 로직
for i in 0..<M {
    let moveInfo = moveArr[i]
    let direction = eightDirections[moveInfo.0]
    let howMany = moveInfo.1
    cloudeMove(direction, howMany)  // 구름 움직이기
    addOne()                       // 구름위치를 순회하면서 모든 해당 위치에 1 추가
    calculateDiagonal()            // 대각선에 물 복사 로직
    getRestCloud()                // 현재 구름들을 제외하고 나머지 공간에서 2이상인곳 찾기
}
print(getResult())
