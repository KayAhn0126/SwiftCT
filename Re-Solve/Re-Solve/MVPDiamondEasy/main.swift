import Foundation

// 현재 달과 지난달, 즉 현재 달을 포함한 최근 2개월간의 과금액으로 결정된다.
// 최대 과금한도가 있어 한달에 최대 다이아몬드 등급 기준액까지만 과금할 수 있다.

let n = Int(readLine()!)!

var arr = readLine()!.split(separator: " ").map { Int(String($0))! }
let MVP = readLine()!
// 30 60 90 150
// S G P D
// BSG = 118
/*
첫 달에는 브론즈 29 합 29
두번째 달에는 실버 30 합 59 실버
세번째 달에는 골드 59 합 89 골드
*/

var total = 0
var prev = 0

let S = arr[0] - 1
let G = arr[1] - 1
let P = arr[2] - 1
let D = arr[3] - 1
let aboveD = arr[3]

for level in MVP {
    if level == "B" {
        total += S - prev
        prev = S - prev
    } else if level == "S" {
        total += G - prev
        prev = G - prev
    } else if level == "G" {
        total += P - prev
        prev = P - prev
    } else if level == "P" {
        total += D - prev
        prev = D - prev
    } else if level == "D" {
        total += aboveD
        prev = aboveD - prev
    }
}
print(total)

