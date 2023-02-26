//
//  main.swift
//  HumanComputerInteracts
//
//  Created by Kay on 2023/02/26.
//

/*
 16139
 인간-컴퓨터 상호작용
 */

import Foundation

let givenString = readLine()! // 주어진 문자열
let count = Int(readLine()!)! // 테스트 할 갯수
let lengthOfString = givenString.count // 주어진 문자열의 길이

var givenStringToArr = Array(givenString) // 문자열을 사용하기 편하게 배열화
var twoDimensionalPsumArr = [[Int]](repeating: [Int](repeating: 0, count: lengthOfString + 1), count: 26)

//MARK: 누적합 구하는 로직
for i in 0...25 { // i는 행렬의 첫번째 dimension
    let currentLetter = String(UnicodeScalar(97 + i)!) // a ~ z
    var givenStringCountArr = [Int](repeating: 0, count: lengthOfString)
    
    for j in 0..<givenStringToArr.count {
        if currentLetter == String(givenStringToArr[j]) {
            givenStringCountArr[j] = 1
        }
    }
    givenStringCountArr.insert(0, at: 0)
    
    for k in 1...givenStringToArr.count {
        twoDimensionalPsumArr[i][k] = twoDimensionalPsumArr[i][k-1] + givenStringCountArr[k]
    }
}

//MARK: 값 구하는 함수
func getPsum(_ alphabet: Character, _ from: Int, _ to: Int) -> Int {
    let currentLetterToInt = Int(alphabet.asciiValue!) - 97
    return twoDimensionalPsumArr[currentLetterToInt][to + 1] - twoDimensionalPsumArr[currentLetterToInt][from]
}

//MARK: 입력받고 함수 호출로 해 구하기
for _ in 0..<count {
    let test = readLine()!.split(separator: " ").map { String($0) }
    let alphabet = Character(test[0])
    let from = Int(test[1])!
    let to = Int(test[2])!
    print(getPsum(alphabet, from, to))
}
