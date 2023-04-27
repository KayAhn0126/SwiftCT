import Foundation

let NM = readLine()!.split(separator: " ").map { Int(String($0))! }
let N = NM[0] // 스크린의 크기
let M = NM[1] // 사과를 담는 상자의 크기

var dropCount = Int(readLine()!)!

var l: Int = 1
var r: Int = l - 1 + M

var result = 0
for i in 0..<dropCount {
    let falling = Int(readLine()!)!
    if l <= falling && falling <= r {
        continue // 사실 이 분기는 안 만들어 줘도 된다.
    } else if r < falling {
        result += falling - r
        l = l + (falling - r)
    } else {
        result += l - falling
        l = falling
    }
    r = l - 1 + M
}
print(result)
