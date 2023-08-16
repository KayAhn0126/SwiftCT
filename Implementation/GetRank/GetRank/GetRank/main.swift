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
    
    // 해당 숫자가 처음 나오는 인덱스를 구한다.
    // 1개이고 마지막 숫자라면 OK그대로 출력
    // 2개 이상이고 처음 나오는 인덱스 + 카운트가 P를 넘어버리면 -1
    let firstIndexOfM = arr.firstIndex(of: M)!
    
    let count = arr.filter { $0 == M }.count
    if firstIndexOfM + count > P {
        result = -1
    } else {
        result = firstIndexOfM + 1
    }
} else {
    result = 1
}
print(result)

