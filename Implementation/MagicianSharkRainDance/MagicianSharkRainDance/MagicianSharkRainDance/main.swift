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
 
 대각선 탐색 로직
 8방향 이동 로직
 구름 실제 이동 로직
 매개변수에 따라 위치에 +1, -2 해주는 로직
 
 초기에 구름이 생긴다.
 이동한다. -> 다 이동하고 나서 구름의 위치에 1을 더한다. 2500 *100 * 50 = 12500000
 대각선에 물이 있는반큼 다시 물이 증가한다. 2500 * 4 = 10000
 이때 맵 전체를 돌면서 물이 2 이상이면서 이전에 구름이 있던칸이 아니라면 구름 배열에 넣어준다.
 2500 * 100 = 250000
 
 12500000 + 10000 + 250000 + 마지막 계산을 위해 전체 탐색 + 2500
 
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

struct Location: Hashable {
    var Y: Int
    var X: Int
}
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

// 구름의 위치를 가지는 배열, 초기에는 주어진대로..
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

//MARK: 현재 구름 위치에서 모든 대각선 방향에 물이 있다면 카운트를 올려주는 로직
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

//MARK: 모든 구름에 더하거나 빼는 로직
func addOne() {
    for i in cloudList {
        arr[i.0][i.1] += 1
    }
}

//MARK: 현재 구름이 아니면서 물의 양이 2 이상인 공간을 구름 배열에 넣는 로직
func getRestCloud() {
    var currentCloudSet = Set(cloudList.map { Location(Y: $0.0, X: $0.1) })
    let tempArr = Array(totalCloudSet.subtracting(currentCloudSet))
    let tempCloudList = tempArr.filter { arr[$0.Y][$0.X] >= 2 }.map { ($0.Y, $0.X) }
    tempCloudList.forEach {
        arr[$0][$1] -= 2
    }
    cloudList = tempCloudList
}

//MARK: 메인 로직
for i in 0..<M {
    let moveInfo = moveArr[i]
    let direction = eightDirections[moveInfo.0]
    let howMany = moveInfo.1
    cloudeMove(direction, howMany)
    addOne()
    calculateDiagonal()
    getRestCloud()
}
var result = 0
func getResult() -> Int {
    var result = 0
    for i in 0..<N {
        for j in 0..<N {
            result += arr[i][j]
        }
    }
    return result
}
print(getResult())
