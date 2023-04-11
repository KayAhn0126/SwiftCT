import Foundation

let arr = readLine()!.split(separator: " ").map { Int(String($0))! }
let a = arr[0]
let b = arr[1]
let c = arr[2]

var timeArr = [Int](repeating: 0, count: 101)
for _ in 0..<3 {
    let time = readLine()!.split(separator: " ").map { Int(String($0))! }
    let from = time[0]
    let to = time[1]
    for j in from..<to {
        timeArr[j] += 1
    }
}
var result = 0
for i in timeArr {
    if i == 0 {
        continue
    } else if i == 1 {
        result += (a * 1)
    } else if i == 2 {
        result += (b * 2)
    } else if i == 3 {
        result += (c * 3)
    }
}
print(result)
