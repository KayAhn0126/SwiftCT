//
//  main.swift
//  MakePalindrome
//
//  Created by Kay on 2023/03/18.
//

/*
 1213
 팰린드롬 만들기 다시 풀기
 */

/*
 홀수인 문자가 2개 이상이면 안된다.
 
 */

import Foundation

extension String {
    subscript(idx: Int) -> Character? {
        guard(0..<count).contains(idx) else { return nil }
        let target = index(startIndex, offsetBy: idx)
        return self[target]
    }
}

var testString = readLine()!

var arr = [Int](repeating: 0, count: 26)
var middleChar = ""
// 계수 정렬
for i in 0..<testString.count {
    arr[Int(testString[i]!.asciiValue!) - 65] += 1
}

var oddCount = 0
var offset = 0
arr.enumerated().forEach {
    if $0.element % 2 != 0 {
        oddCount += 1
        middleChar = String(UnicodeScalar($0.offset + 65)!)
        offset = $0.offset
    }
}

if oddCount > 1 {
    print("I'm Sorry Hansoo")
} else {
    var result = ""
    for i in stride(from: 25, through: 0, by: -1) {
        if i == offset {
            arr[i] -= 1
        }
        for _ in stride(from: 0, to: arr[i], by: 2) {
            result += String(UnicodeScalar(i + 65)!)
            result = String(UnicodeScalar(i + 65)!) + result
        }
    }
    let middleIndex = result.count / 2
    if !middleChar.isEmpty {
        result.insert(Character(middleChar), at: result.index(result.startIndex, offsetBy: middleIndex))
    }
    print(result)
}
