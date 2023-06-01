//
//  main.swift
//  OffBrand
//
//  Created by Kay on 2023/06/01.
//

/*
 1764
 듣보잡
 */
import Foundation

let heardSeen = readLine()!.split(separator: " ").map { Int(String($0))! }
let total = heardSeen[0] + heardSeen[1]

var dictionary: [String: Int] = [:]
for i in 0..<total {
    let name = readLine()!
    if dictionary[name] == nil {
        dictionary[name] = 1
    } else {
        dictionary[name]! += 1
    }
}
var result = [String]()
for i in dictionary.keys.sorted() {
    if dictionary[i]! == 2 {
        result.append(i)
    }
}
print(result.count)
result.enumerated().forEach {
    print($0.element)
}
