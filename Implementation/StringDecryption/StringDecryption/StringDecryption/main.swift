//
//  main.swift
//  StringDecryption
//
//  Created by Kay on 2023/04/02.
//

/*
 1593
 문자 해독
 */

/*
 특정 문자들이 주어지고 어떤 문자열에서 있을수 있는 모든 경우의 수를 계산하면 된다.
 W와 S가 주어진다.
 
 */
import Foundation

extension String {
    subscript(idx: Int) -> Character? {
        guard(0..<count).contains(idx) else { return nil }
        let target = index(startIndex, offsetBy: idx)
        return self[target]
    }
}

let lengths = readLine()!.split(separator: " ").map { Int(String($0))! }
let WLength = lengths[0]
let SLength = lengths[1]

let W = readLine()!.map { Character(String($0)) }
let S = readLine()!.map { Character(String($0)) }

var wArr = [Int](repeating: 0, count: 53)
var sArr = [Int](repeating: 0, count: 53)

for i in 0..<W.count {
    if "a" <= W[i] && W[i] <= "z" {
        wArr[Int(W[i].asciiValue!) - 97 + 26] += 1
    } else {
        wArr[Int(W[i].asciiValue!) - 65] += 1
    }
    
}

var currentLength = 0
var start = 0
var result = 0

for i in 0..<SLength {
    if "a" <= S[i] && S[i] <= "z" {
        sArr[Int(S[i].asciiValue!) - 97 + 26] += 1
    } else {
        sArr[Int(S[i].asciiValue!) - 65] += 1
    }
    currentLength += 1
    
    if currentLength == WLength {
        if wArr == sArr {
            result += 1
        }
        if "a" <= S[start] && S[start] <= "z" {
            sArr[Int(S[start].asciiValue!) - 97 + 26] -= 1
        } else {
            sArr[Int(S[start].asciiValue!) - 65] -= 1
        }
        start += 1
        currentLength -= 1
    }
}
print(result)
