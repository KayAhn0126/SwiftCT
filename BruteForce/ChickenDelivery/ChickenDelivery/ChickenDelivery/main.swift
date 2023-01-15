//
//  main.swift
//  ChickenDelivery
//
//  Created by Kay on 2023/01/14.
//

/*
 15686
 치킨 배달
 */
// 3rd week fast campus

import Foundation

func combinationWithRecursive<T>(_ array: [T], _ n: Int) -> [[T]] {
    var result = [[T]]()
    if array.count < n { return result }

    func cycle(_ index: Int, _ now: [T]) {
        if now.count == n {
            result.append(now)
            return
        }

        for i in index..<array.count {
            cycle(i + 1, now + [array[i]])
        }
    }

    cycle(0,[])

    return result
}



let NM = readLine()!.split(separator: " ").map { Int(String($0))! }
let N = NM[0]
let M = NM[1]

var adjMatrix = [[Int]](repeating: [Int](), count: N)
var homeList = [(Int,Int)]()
var chickenList = [(Int,Int)]()

for i in 0..<N {
    adjMatrix[i].append(contentsOf: readLine()!.split(separator: " ").map { Int(String($0))! })
}


// MARK: - 맵 안에서 집과 치킨집의 위치를 파악하기
func checkHomeAndChickenLocation() {
    for i in 0..<N {
        for j in 0..<N {
            if adjMatrix[i][j] == 1 {
                homeList.append((i,j))
            } else if adjMatrix[i][j] == 2 {
                chickenList.append((i,j))
            }
        }
    }
}


func solution() {
    var finalResult = 987654321
    for i in 0..<randomChickenLocationByNumberOfM.count {
        var localTotal = 0
        for j in 0..<homeList.count {
            let homeLocation  = homeList[j]
            let homeY = homeLocation.0
            let homeX = homeLocation.1
            var distanceFromEachChickenMinimum = 987654321
            for k in 0..<randomChickenLocationByNumberOfM[i].count {
                let randomChickenLocation = randomChickenLocationByNumberOfM[i][k]
                let randomChickenY = randomChickenLocation.0
                let randomChickenX = randomChickenLocation.1
                
                let distance = abs(randomChickenY - homeY) + abs(randomChickenX - homeX)
                distanceFromEachChickenMinimum = distance < distanceFromEachChickenMinimum ? distance : distanceFromEachChickenMinimum
            }
            localTotal += distanceFromEachChickenMinimum
        }
        finalResult = localTotal < finalResult ? localTotal : finalResult
    }
    print(finalResult)
}

// MARK: - 집의 위치와 치킨집 위치 리스트화
checkHomeAndChickenLocation()
// MARK: - M 만큼 조합으로 뽑기
var randomChickenLocationByNumberOfM = combinationWithRecursive(chickenList, M)
// MARK: - 집 집 마다, 조합으로 뽑은 치킨집 중 가장 가까운 치킨집까지 거리를 구하고 계속 최소값으로 업데이트 후 값 구하기
solution()




