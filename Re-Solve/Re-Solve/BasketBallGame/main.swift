//
//  main.swift
//  BasketBallGame
//
//  Created by Kay on 2023/01/28.
//

import Foundation

extension String {
    subscript(idx: Int) -> Character? {
        guard (0..<count).contains(idx) else { return nil }
        let target = index(startIndex, offsetBy: idx)
        return self[target]
    }
}

var counting = [Int](repeating: 0, count: 26)

let num = Int(readLine()!)!

for i in 0..<num {
    let player = readLine()!
    let firstLetter = player[0]!
    counting[Int(firstLetter.asciiValue!) - 97] += 1
}

var result = ""
counting.enumerated().forEach {
    if $0.element >= 5 {
        result += String(UnicodeScalar($0.offset + 97)!)
    }
}
if result.count == 0 {
    print("PREDAJA")
} else {
    print(result)
}

