//
//  main.swift
//  BitMasking
//
//  Created by Kay on 2023/03/27.
//

                            // 비트마스크 연습 //
import Foundation

//MARK: 사용할 숫자 만들기
var number: Int = (1 << 30) {
    //MARK: 새로운 값이 저장된 직후에 호출된다. 이전 프로퍼티의 값이 oldValue로 제공된다.
    didSet {
        bitArr = String(number, radix: 2)
    }
}
//MARK: 이진수로 보여줄 문자열 만들기
var bitArr = String(number, radix: 2)
print(bitArr)

print("-------------------------------")
//MARK: bitArr의 5번째 인덱스 비트 켜기!
print("bit on")
var fifth = 5
number |= (1 << fifth)
print(number)
print(bitArr)

print("-------------------------------")
//MARK: birArr의 5번째 인덱스 비트 끄기
print("bit off")
number &= ~(1 << fifth)
print(number)
print(bitArr)

print("-------------------------------")
//MARK: bitArr의 5번째 인덱스 토글!
print("toggle")
number ^= (1 << 5)
print(number)
print(bitArr)

//MARK: 다시 토글해서 확인하기
number ^= (1 << 5)
print(bitArr)

print("-------------------------------")
//MARK: bitArr의 특정 비트가 켜져있는지 확인하기
print("Check if bit is on or not")
print(number & (1 << 5))  // 특정 비트가 꺼져있으면 0
print(number & (1 << 30)) // 특정 비트가 켜져있으면 해당 값이 나온다 1073741824
