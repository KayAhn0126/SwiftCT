import Foundation

let num = Int(readLine()!)!
var arr = readLine()!.split(separator: " ").map { Int(String($0))! }
arr.sort()
var result = 0
var temp = 0
for i in arr {
    temp += i
    result += temp
}
print(result)
