import Foundation

// 1 = 1/1

// 패턴
/*
라인수만큼 분수들이 있다.
짝수 라인
 - 우상 -> 좌하
 - 분모는 라인수(n)부터 1까지 내려감
 - 분자는 1부터 라인수(n)까지 올라감
홀수 라인
 - 좌하 -> 우상
 - 분모는 1부터 라인수(n)까지 올라감
 - 분자는 라인수(n)부터 1까지 내려감
*/

// 숫자가 주어졌을때 몇번째 라인에서 몇번째에 있는지 알아내야한다.
// 1부터 시작해서 2,3,4,5를 더해주면서 찾아보자

let target = Int(readLine()!)!

if target == 1 {
    print("1/1")
} else {
    var base = 1
    var counter = 2
    var line = 1 // 해당 target의 위치를 알려줄 라인
    while base < target {
        base += counter
        counter += 1
        line += 1
    }
    /*
    짝수 라인
     - 우상 -> 좌하
     - 분모는 라인수(n)부터 1까지 내려감
     - 분자는 1부터 라인수(n)까지 올라감
    홀수 라인
     - 좌하 -> 우상
     - 분모는 1부터 라인수(n)까지 올라감
     - 분자는 라인수(n)부터 1까지 내려감
    */
    if line % 2 == 0 { // 짝수라인이면
        print("\(target + line - base)/\(base - target + 1)")
    } else { // 홀수라인이면
        print("\(base - target + 1)/\(target + line - base)")
    }
}

/*
8 = 4번째 라인 2번째
9 = 4번째 라인의 3번째
10 = 4번째 라인 4번째
*/
