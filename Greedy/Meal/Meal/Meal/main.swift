//
//  main.swift
//  Meal
//
//  Created by Kay on 2023/08/16.
//

/*
 23559
 밥
 */

/*
 지문 해석 -> 준원이가 고른 메뉴의 맛의 합을 최대화!
 문제 접근 -> N이 100,000 -> 정렬 가능
    돈이 있다고 해서 맛있는것만 먹다가 밥을 못먹을수도 있기 때문에 남은 일수도 신경써야 한다.
 */

import Foundation

let NandMoney = readLine()!.split(separator: " ").map { Int(String($0))! }
var N = NandMoney[0]
var Money = NandMoney[1]

var arr = [(Int, Int, Int)]()
for _ in 0..<N {
    let temp = readLine()!.split(separator: " ").map { Int(String($0))! }
    arr.append((temp[0], temp[1], abs(temp[0] - temp[1])))
}
arr.sort(by: {
    return $0.2 > $1.2
})

var result = 0
for info in arr {
    let A = info.0
    let B = info.1
    if Money >= 5000 && Money - 5000 >= (N - 1) * 1000 { // 5천원 이상이고, 아래서 A를 선택하려 했을때, 나머지 남은 날들에 밥을 B로만 때울수 있는지 체크하기.
        if A > B {
            result += A
            Money -= 5000
        } else if B >= A { // 위의 if문이 아니라면 B를 먹어야 한다.
            result += B
            Money -= 1000
        }
    } else if Money >= 1000 { // 5천원은 없고, 1000원 이상이라면
        result += B
        Money -= 1000
    }
    N -= 1 // 날짜 차감
}
print(result)
