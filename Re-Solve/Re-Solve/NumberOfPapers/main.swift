import Foundation

// 쿼드트리와 비슷한 문제
// 하지만 9개로 나눠야 한다.
// 사이즈를 3으로 계속 나눠주기
// y, x, size 형태로 매개변수 받기

// 갯수를 더해주면 된다. 상황을 보자
// 1. 사이즈가 1일때 바로 분기처리해서 갯수 올려주기
// 2. 다 똑같다면 마지막에 분기처리해서 갯수 올려주기

let N = Int(readLine()!)!

var arr = [[Int]](repeating: [Int](), count: N)
for i in 0..<N {
    arr[i].append(contentsOf: readLine()!.split(separator: " ").map { Int(String($0))! })
}

var minusCount = 0
var zeroCount = 0
var oneCount = 0

func increaseCount(_ num: Int) {
    if num == -1 {
        minusCount += 1
    } else if num == 0 {
        zeroCount += 1
    } else {
        oneCount += 1
    }
}

func go(_ y: Int, _ x: Int, _ size: Int) {
    let currentNumber = arr[y][x]
    if size == 1 {
        increaseCount(currentNumber)
        return
    }
    for i in y..<y+size {
        for j in x..<x+size {
            if currentNumber != arr[i][j] {
                let divided = size / 3
                go(y, x, divided)
                go(y, x + divided, divided)
                go(y, x + divided + divided, divided)
                go(y + divided, x, divided)
                go(y + divided, x + divided, divided)
                go(y + divided, x + divided + divided, divided)
                go(y + divided + divided, x, divided)
                go(y + divided + divided, x + divided, divided)
                go(y + divided + divided, x + divided + divided, divided)
                return
            }
        }
    }
    increaseCount(currentNumber)
}

go(0,0,N)
print(minusCount)
print(zeroCount)
print(oneCount)
