import Foundation

let NM = readLine()!.split(separator: " ").map { Int(String($0))! }
let N = NM[0]
let M = NM[1]

var arr = readLine()!.split(separator: " ").map { Int(String($0))! }

var result = 0
for i in 0..<N - 2 {
    for j in i+1..<N - 1 {
        for k in j+1..<N {
            let tempNum = arr[i] + arr[j] + arr[k]
            if M >= tempNum {
                result = tempNum > result ? tempNum : result
            }
        }
    }
}
print(result)
