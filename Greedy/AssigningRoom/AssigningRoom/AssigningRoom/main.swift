//
//  main.swift
//  AssigningRoom
//
//  Created by Kay on 2023/04/25.
//

/*
 1931
 회의실 배정
 */

// 그리디(라인스위핑)

// 최대한 많은 회의를 할 수 있도록 회의 스케줄을 짜보는 것이 이 문제의 포인트
// 끝나는 지점을 기준으로 오름차순 정렬 -> 그럼 끝나자마다 다른 회의를 잡을 수 있다. -> 빨리 끝나면 더 많은 회의를 잡을 수 있다.
// 빨리 끝난다는 것은 뒤에 다른 회의를 더 넣을수 있다는 의미!

// 이 문제를 브루트 포스로 풀게 된다면?
// -> 하나의 구간마다 선택할지 말지를 결정해야 하기 때문에 2^n번의 지수(exponential) 시간복잡도를 가지게 된다.
// O O O O O O O ...
// X X X X X X X ...


import Foundation

let num = Int(readLine()!)!

var intervals: [(Int,Int)] = []

for _ in 0..<num {
    let interval = readLine()!.split(separator: " ").map { Int(String($0))! }
    intervals.append((interval[0], interval[1]))
}

intervals.sort(by: {
    if $0.1 == $1.1 {
        return $0.0 < $1.0
    }
    return $0.1 < $1.1
})

var start = intervals[0].0
var end = intervals[0].1
var result = 1

for i in 1..<intervals.count {
    if intervals[i].0 < end {
        continue
    } else {
        result += 1
        end = intervals[i].1
    }
}
print(result)
