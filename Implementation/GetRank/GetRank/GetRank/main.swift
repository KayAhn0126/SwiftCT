//
//  main.swift
//  GetRank
//
//  Created by Kay on 2023/08/16.
//

/*
 1205
 등수 구하기
 */

import Foundation

let NMP = readLine()!.split(separator: " ").map { Int(String($0))! }
let N = NMP[0] // 주어지는 숫자의 개수
let M = NMP[1] // 태수의 새로운 점수
let P = NMP[2] // 랭킹 리스트에 올라 갈 수 있는 점수의 개수

var result = 0
if N > 0 {
    var arr = readLine()!.split(separator: " ").map { Int(String($0))! }
    arr.append(M)
    arr.sort(by: >)
    var rank = [Int](repeating: 1, count: N + 1)
    for i in 0..<N+1 {
        for j in 0..<i {
            if arr[j] > arr[i] {
                rank[i] += 1
            }
        }
    }
    
    // 태수의 점수 또는 태수와 같은 점수들이 배열에서 처음으로 나오는 곳의 인덱스를 구한다.
    let firstIndexOfM = arr.firstIndex(of: M)!
    
    // 태수의 점수가 배열에서 총 몇개나 있는지 구한다.
    let count = arr.filter { $0 == M }.count
    
    // 배열에서 태수의 점수가 처음나오는 위치와 총 갯수를 더했을때 P를 넘어가면,
    // 태수는 랭킹 리스트에 들지 못했으므로 -1을 받고, 그것이 아니라면 랭킹 리스트에 적힌 등수를 얻는다.
    if firstIndexOfM + count > P {
        result = -1
    } else {
        result = firstIndexOfM + 1
    }
} else {
    result = 1
}
print(result)

