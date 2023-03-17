//
//  main.swift
//  FindingFraction
//
//  Created by Kay on 2023/03/17.
//

/*
 1193
 분수 찾기
 */


/*
 홀수 레이어는 좌하단에서 우상단
    분모 1부터 layer까지
    분자 layer부터 1까지
 
 짝수 레이어는 우상단에서 좌하단
    분모 layer부터 1까지
    분자 1부터 layer까지
 
 질문 예)12번째 분수는 무엇입니까?
    -> 각 레이어는 레이어 숫자만큼의 분수가 있음
    -> 1레이어는 1개     -> 즉, 1레이어까지는 총 1개의 분수가 있다
    -> 2레이어는 2개     -> 즉, 2레이어까지는 총 3개의 분수가 있다
    -> 3레이어는 3개     -> 즉, 3레이어까지는 총 6개의 분수가 있다
    ...
    -> 5레이어는 5개     -> 즉, 5레이어까지는 총 15개의 분수가 있다
 
 12번째 분수는 5레이어에 있다.
    -> 왜? 4레이어까지는 10개의 분수, 5레이어까지는 15개의 분수가 있기 때문에
    -> 10 < 12 < 15
    -> 5 레이어(홀수)라는것을 알았다. -> 좌하단에서 우상단으로 올라가는 패턴.
    -> 그럼 5레이어에서 몇번째에 있을까? 2번째에 있다!
    -> 12 - 10(이전레이어까지 총 분수의 갯수) = 2
    -> 5레이어 2번째라는것이 구해졌으니 구현 시작.
 */


import Foundation

var number = Int(readLine()!)!

var totalFractions = 0
var layer = 1

if number == 1 {
    print("1/1")
} else {
    while number > totalFractions {
        totalFractions += layer
        layer += 1
    }
    layer = layer - 1
    let index = number - (totalFractions - layer)
    if layer % 2 != 0 {
        print("\(layer-index+1)/\(index)")
    } else {
        print("\(index)/\(layer-index+1)")
    }
}
