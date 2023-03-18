//
//  main.swift
//  FrequencySortAgain
//
//  Created by Kay on 2023/03/18.
//

/*
 2910
 빈도 정렬
 */

/*
 더 많이 등장하는경우 앞에, 만약 등장하는 횟수가 같다면 먼저나온것이 앞에.
 */

import Foundation

let NC = readLine()!.split(separator: " ").map { Int(String($0))! }
let N = NC[0]
let C = NC[1]

var arr = readLine()!.split(separator: " ").map { Int(String($0))! }

// dictionary [Int: (빈도, 처음나온 인덱스)] = []
var dictionary: [Int:(Int,Int)] = [:]

for i in 0..<arr.count {
    if dictionary[arr[i]] == nil {
        dictionary[arr[i]] = (1,i)
    } else {
        let frequencyAndIndex = dictionary[arr[i]]!
        let frequency = frequencyAndIndex.0
        let index = frequencyAndIndex.1
        dictionary[arr[i]] = (frequency + 1, index)
    }
}

var result = ""
dictionary.sorted(by: {
    if $0.value.0 == $1.value.0 {
        return $0.value.1 < $1.value.1
    }
    return $0.value.0 > $1.value.0
}).forEach {
    for _ in 0..<$0.value.0 {
        result += String($0.key) + " "
    }
}
print(result)
