//
//  main.swift
//  Laboratory
//
//  Created by Kay on 2023/02/16.
//

/*
 14502
 연구소
 */

// 벽 조합 구하기 = (64 - 2의 갯수 - 1의 갯수) C 3 = 41664이하
// 바이러스 퍼뜨리기 = DFS의 반복횟수
// 0의 갯수 체크하기 = 64

// O(40000 * 64)

/*
 1. 빈칸 위치 저장. + 바이러스 퍼뜨릴 바이러스 위치 저장 + 벽 위치 저장.
 2. Combination으로 빈칸 조합 구하기
 3. Combination을 이용해 조건에 맞게 벽 세우기 + 바이러스 퍼뜨리기 + 0의 갯수 체크하기 + 벽 허물기
 4. 조합 바뀔때마다 0의 갯수 체크 + max 구하기
 */

import Foundation

func combination<T>(_ arr:[T], _ num: Int) -> [[T]] {
    var result: [[T]] = []
    if arr.count < num { return result }
    func cycle(_ now: [T], _ index: Int) {
        if now.count == num {
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

let NM = readLine()!.split(separator: " ").map { Int(String($0))! }
let N = NM[0]
let M = NM[1]

var adjMatrix = [[Int]](repeating: [Int](), count: N)

for i in 0..<N {
    adjMatrix[i].append(contentsOf: readLine()!.split(separator: " ").map { Int(String($0))! })
}

var virusLocation: [(Int,Int)] = []
var wallLocation: [(Int,Int)] = []
var emptyLocation: [(Int,Int)] = []

// 25분 + 
