//
//  main.swift
//  RemoteControl
//
//  Created by Kay on 2023/03/21.
//

/*
 1107
 리모컨
 */

/*
 채널의 숫자가 작아서 브루트포스 가능!
 고장난 버튼이 없다 -> Length 반환
 
 생각할 것
 1. 고장난 버튼이 없을수 있다.
 
 
 1. 먼저 +,-로 갔을때 100에서 얼마나 눌러야 하는지 구한다 Number - 100 = ??
 2. 고장나지 않은 유효한 숫자들을 담은 배열을 돌면서 기존 Number와 해당 요소의 절대값이 가장 적은것을 선택해
 특정 숫자를 만들고 Number - 숫자 해준다.
 3. 브루트포스
 */


/*
 
 A 배열 = [0,1,2,3,4,5,6,7,8,9]
 B 배열 = [0,1,2,3]
 A배열에서 B배열이 가지고 있는 값을 제외한 값을 A배열에 넣고 싶다면..
 A = A.filter { !B.contains($0) }
 print(A) -> [4,5,6,7,8,9]
 
 */

/*
 왜 100만인지?
 시간 복잡도 -> 100만 * len("500,000") = 600만정도 2초면 충분
 */

import Foundation

let numberString = readLine()!
let number = Int(numberString)!
let brokenCount = Int(readLine()!)!
var validArr = [Bool](repeating: true, count: 10)
var result = abs(number - 100)


func checkValidNumber(_ number: Int) -> Bool {
    var result = true
    var testNumber = number
    
    if testNumber > 9 {
        while testNumber > 0 {
            if validArr[testNumber % 10] == false {
                result = false
                break
            }
            testNumber /= 10
        }
    } else {
        if validArr[testNumber] == false {
            result = false
        }
    }
    return result
}

if brokenCount != 0 {
    let arr = readLine()!.split(separator: " ").map { Int(String($0))! }
    for i in 0..<arr.count {
        validArr[arr[i]] = false
    }
    for i in 0..<1000000 {
        if checkValidNumber(i) == true {
            let digitCount = String(i).count
            let currentMin = abs(number - i) + digitCount
            result = result > currentMin ? currentMin : result
        }
    }
} else {
    result = result > numberString.count ? numberString.count : result
}
print(result)
