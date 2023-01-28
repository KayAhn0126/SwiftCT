//
//  main.swift
//  CountingAlphabet
//
//  Created by Kay on 2023/01/28.
//

/*
 10808
 알파벳 개수
 */
import Foundation

extension String {
    subscript(idx: Int) -> Character? {
        guard (0..<count).contains(idx) else {
            return nil
        }
        let target = index(startIndex, offsetBy: idx)
        return self[target]
    }
}

let s = readLine()!

var counting = [Int](repeating: 0, count: 26)

s.enumerated().forEach {
    let char = $0.element
    counting[Int(char.asciiValue! - 97)] += 1
}

counting.enumerated().forEach {
    print($0.element, terminator: " ")
}

