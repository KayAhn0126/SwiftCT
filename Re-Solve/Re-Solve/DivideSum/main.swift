import Foundation

let targetNumber = Int(readLine()!)!

var flag = false
for i in 1..<targetNumber {
    var number = i
    var result = 0
    while number > 0 {
        result += number % 10
        number = number / 10
    }
    result += i
    if result == targetNumber {
        flag = true
        print(i)
        break
    }
}
if !flag {
    print(0)
}
