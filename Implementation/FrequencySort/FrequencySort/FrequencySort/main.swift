//
//  main.swift
//  FrequencySort
//
//  Created by Kay on 2023/01/05.
//

/*
 2910
 빈도 정렬
 */
// 2nd week fast-campus

import Foundation


let NC = readLine()!.split(separator: " ").map { Int(String($0))! }
let N = NC[0]
let C = NC[1]

let input = readLine()!.split(separator: " ").map { String($0) }

var data: [String : (Int,Int)] = [:]

var result = ""

for i in 0..<N {
    if data[input[i]] == nil {
        data[input[i]] = (1,i)
    } else {
        let previousFrequency = data[input[i]]!.0
        let currentFrequency = previousFrequency + 1
        let firstAppearance = data[input[i]]!.1
        data.updateValue((currentFrequency, firstAppearance), forKey: input[i])
    }
}

data.sorted(by: {
    if $0.value.0 == $1.value.0 {
        return $0.value.1 < $1.value.1
    }
    return $0.value.0 > $1.value.0
}).forEach {
    for i in 0..<$0.value.0 {
        result += $0.key + " "
    }
}
print(result)
