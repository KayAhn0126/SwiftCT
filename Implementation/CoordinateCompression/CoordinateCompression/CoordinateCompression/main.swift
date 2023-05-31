//
//  main.swift
//  CoordinateCompression
//
//  Created by Kay on 2023/05/31.
//

/*
 18870
 좌표 압축
 */

// 문제 접근
// 먼저 set으로 중복 없애주고
// 정렬하고 딕셔너리로 숫자와 인덱스 묶어주고
// 주어진 배열 돌면서 해당 숫자를 딕셔너리에서 찾아 인덱스를 result 배열에 append 하기

import Foundation

var result = [Int]()

let n = Int(readLine()!)!
let arr = readLine()!.split(separator: " ").map { Int(String($0))! }

let tempSet = Array(Set(arr).sorted())
var myDictionary: [Int: Int] = [:]
for i in 0..<tempSet.count {
    myDictionary[tempSet[i]] = i
}

for i in arr {
    result.append(myDictionary[i]!)
}
result.enumerated().forEach {
    print($0.element, terminator: " ")
}
print("")
