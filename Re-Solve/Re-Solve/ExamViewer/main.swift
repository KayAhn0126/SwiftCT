import Foundation

let testPlace = Int(readLine()!)!

var arr = readLine()!.split(separator: " ").map { Int(String($0))! }

let BC = readLine()!.split(separator: " ").map { Int(String($0))! }
let B = BC[0]
let C = BC[1]

var result = 0

for i in 0..<testPlace {
    if arr[i] < B {
        result += 1
    } else {
        result += 1
        let newNumber = arr[i] - B
        if newNumber % C == 0 {
            result += (newNumber / C)
        } else {
            result += ((newNumber / C) + 1)
        }
    }
}
print(result)


