//
//  main.swift
//  ChickenDelivery
//
//  Created by Kay on 2023/02/11.
//

/*
 15686
 치킨배달
 */

// 브루트 포스 + 순열 + BFS

/*
 문제 해석:
 
 N * N
 빈칸, 집, 치킨집
 r과 c는 1부터 시작.
 치킨거리 = 집과 가장 가까운 치킨집 사이의 거리.
 도시의 치킨 거리 = 모든 집의 치킨 거리의 합.
 임의의 두 칸(r1, c1)과 (r2, c2)사이의 거리는 |r1 - r2| + |c1 - c2| 이다.
 
 
 문제 접근 :
 특정 지점부터 다른 특정 지점까지의 거리를 구하면서 최소값을 구해야한다.
 현재 존재하는 치킨집에서 M개를 선택해야한다. 즉, 현재 5개가 있고 M이 3이라면 2개를 돌아가면서 없애야한다.
 
 
 문제 풀이 :
 하나의 집에서 가장 가까운 치킨집을 찾는 과정 * 100 -> BFS로 0,0에서 49,49까지 50
 즉, 100 * 50 = 5000
 이제 치킨집을 바꿔보자.
 치킨집은 최대 13개가 될수 있고 그 중 M 개 고르기
 조합은 중앙으로 갈수록 최대값이고 13 C m => 최대 13C6 or 13C7 -> 1716
 정말 최악의 경우 -> 5000 * 1716 = 858000
 1000만 아래이므로 완탐으로 푼다.
 */

import Foundation

let NM = readLine()!.split(separator: " ").map { Int(String($0))! }

let N = NM[0]
let M = NM[1]

var matrix = [[Int]](repeating: [Int](), count: N)

for row in 0..<N {
    matrix[row].append(contentsOf: readLine()!.split(separator: " ").map { Int(String($0))! })
}

func combination<T>(_ arr: [T], _ limit: Int) -> [[T]] {
    var result = [[T]]()
    guard arr.count >= limit else { return result }
    
    func cycle(_ combArr: [T], _ index: Int) {
        if combArr.count == limit {
            result.append(combArr)
            return
        }
        
        for i in index..<arr.count {
            cycle(combArr + [arr[i]], i + 1)
        }
    }
    cycle([], 0)
    return result
}

var homeLocationList = [(Int,Int)]()
var chickenLocationList = [(Int,Int)]()

for row in 0..<N {
    for col in 0..<N {
        if matrix[row][col] == 1 {
            homeLocationList.append((row,col))
        } else if matrix[row][col] == 2 {
            chickenLocationList.append((row,col))
        }
    }
}

var combinationChickenLocation = combination(chickenLocationList, M)







