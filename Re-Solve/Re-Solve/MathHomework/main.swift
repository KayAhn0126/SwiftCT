//
//  main.swift
//  MathHomework
//
//  Created by Kay on 2023/02/03.
//

/*
 2870
 수학 숙제
 */

// 1. 문자열을 받는다.
// 2. 반복문을 돌면서 숫자라고 판단되면 넣는다.
// 3. 앞의 자리가 0인것들을 삭제하는 함수 만든다.
// 4. 정상적인 숫자가 되었다면 배열에 넣는다.
// 5. 결과 배열을 오름차순으로 정렬 후 출력.

// 주의!
// 처음엔 정수로 풀었는데 입력을 보니 각 줄은 최대 100글자이므로 String으로 풀어야 함
import Foundation

let testCase = Int(readLine()!)!
var result = [String]()

func trim(_ element: String) {
    var trimmedString = element
    while trimmedString.hasPrefix("0") {
        if trimmedString.count == 1 {
            result.append(trimmedString)
            return
        }
        trimmedString = String(trimmedString.dropFirst())
    }
    result.append(trimmedString)
}

if 1 <= testCase && testCase <= 100 {
    for _ in 0..<testCase {
        let testString = readLine()!
        var tempStoreDigits = ""
        for i in testString {
            let asciiValue = Int(i.asciiValue!)
            if 48 <= asciiValue && asciiValue <= 57 {
                tempStoreDigits += String(i)
            } else {
                if !tempStoreDigits.isEmpty {
                    trim(tempStoreDigits)
                    tempStoreDigits = ""
                }
            }
        }
        if !tempStoreDigits.isEmpty {
            trim(tempStoreDigits)
        }
    }
    
    result.sorted(by: {
        if $0.count == $1.count {
            return $0 < $1
        }
        return $0.count < $1.count
    }).enumerated().forEach {
        print($0.element)
    }
}
