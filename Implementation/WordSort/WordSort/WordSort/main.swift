//
//  main.swift
//  WordSort
//
//  Created by Kay on 2023/03/27.
//

/*
 1181
 단어 정렬
 */

import Foundation

let number = Int(readLine()!)!

var firstFilterSet = Set<String>()
for _ in 0..<number {
    firstFilterSet.insert(readLine()!)
}

var finalArr = Array(firstFilterSet)

finalArr.sorted(by: {
    if $0.count == $1.count {
        return $0 < $1
    }
    return $0.count < $1.count
}).forEach {
    print($0)
}
