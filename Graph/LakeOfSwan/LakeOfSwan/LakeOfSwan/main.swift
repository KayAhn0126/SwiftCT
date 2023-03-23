//
//  main.swift
//  LakeOfSwan
//
//  Created by Kay on 2023/03/22.
//

/*
 3197
 백조의 호수
 */

/*
 
 . -> water
 X -> 빙판
 L -> 백조
 
 1. .의 위치를 모두 구한다.
 2. BFS큐를 만들고 다 넣어준다.
 3. 배열이 끝날때까지 돌려주고
 3-1. 돌리는 도중에 X를 만나면 X의 위치를 다른 Queue에 넣어준다. + .으로 만들어준다.
 3-2. 기존 큐가 끝나면 X의 위치가 들어있던 큐를 기존큐에 넣어준다.
 4. 3번이 한번씩 끝날때마다 날짜를 늘려주고, 백조끼리 만날 수 있는지 체크한다.
 
 */


/*
 물은 물의 큐에서 시간에 지남에 따라 녹게 만들고
 백조는 X를 만난곳에서 계속 BFS를 한다. -> 시간이 점점 짧아진다. + visited는 continue해서 더 빨라진다.
 */
import Foundation

let dy = [-1,0,1,0]
let dx = [0,1,0,-1]

let NM = readLine()!.split(separator: " ").map { Int(String($0))! }
let N = NM[0]
let M = NM[1]

var adjMatrix = [[Character]](repeating: [Character](), count: N)

for i in 0..<N {
    adjMatrix[i].append(contentsOf: readLine()!)
}

var waterLocation: [(Int, Int)] = []
var swanLocation: [(Int, Int)] = []

for i in 0..<N {
    for j in 0..<M {
        if adjMatrix[i][j] == "." {
            waterLocation.append((i,j))
        } else if adjMatrix[i][j] == "L" {
            swanLocation.append((i,j))
        }
    }
}

var found = false // 백조가 다른 백조를 찾았는지??

//MARK: 백조가 움직이는 것 관련
var swanQueue: [(Int,Int)] = [], swanIdx = 0
var nextSwanQueue: [(Int,Int)] = []
var swanVisited = [[Int]](repeating: [Int](repeating: 0, count: M), count: N)

swanQueue.append((swanLocation[0].0, swanLocation[0].1))
swanVisited[swanLocation[0].0][swanLocation[0].1] = 1


func swanBFS() {
    while swanIdx < swanQueue.count {
        let swanLocation = swanQueue[swanIdx]; swanIdx += 1
        for i in 0..<4 {
            let ny = swanLocation.0 + dy[i]
            let nx = swanLocation.1 + dx[i]
            if ny < 0 || nx < 0 || ny >= N || nx >= M { continue }
            if swanVisited[ny][nx] != 0 { continue }
            
            swanVisited[ny][nx] = 1
            if adjMatrix[ny][nx] == "." {
                swanQueue.append((ny,nx))
            } else if adjMatrix[ny][nx] == "X" {
                nextSwanQueue.append((ny,nx))
            } else if adjMatrix[ny][nx] == "L" {
                found = true
                break
            }
        }
    }
}


//MARK: 물 주변의 얼음을 녹이는 과정
var waterLocationQueue: [(Int,Int)] = [], waterIdx = 0
var nextWaterLocationQueue: [(Int,Int)] = []

// 물의 위치 넣어주기
waterLocation.enumerated().forEach {
    waterLocationQueue.append(($0.element.0, $0.element.1))
}

// 백조가 있는곳(물 위)도 물 !
swanLocation.enumerated().forEach {
    waterLocationQueue.append(($0.element.0, $0.element.1))
}

func waterMeltsIceBFS() {
    while waterIdx < waterLocationQueue.count {
        let currentYX = waterLocationQueue[waterIdx]; waterIdx += 1
        for i in 0..<4 {
            let ny = currentYX.0 + dy[i]
            let nx = currentYX.1 + dx[i]
            if ny < 0 || nx < 0 || ny >= N || nx >= M { continue }
            if adjMatrix[ny][nx] == "X" {
                nextWaterLocationQueue.append((ny,nx))
                adjMatrix[ny][nx] = "."
            }
        }
    }
}


var result = 0
while found == false {
    swanBFS()
    if found == false {
        waterMeltsIceBFS()
        swanQueue = nextSwanQueue
        swanIdx = 0
        waterLocationQueue = nextWaterLocationQueue
        waterIdx = 0
        nextSwanQueue = []
        nextWaterLocationQueue = []
        result += 1
    }
}
print(result)
