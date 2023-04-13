import Foundation

var num = Int(readLine()!)!

var arr = [Int](repeating: 0, count: 8001)

var total = 0
var mediumArr = [Int]()
var max = 0
for i in 0..<num {
    let temp = Int(readLine()!)!
    arr[temp + 4000] += 1
    if arr[temp + 4000] > max {
        max = arr[temp + 4000]
    }
    mediumArr.append(temp)
    total += temp
}

var doubleCount = 0
var mostNum = 0
for i in 0..<8001 {
    if arr[i] == max {
        doubleCount += 1
        mostNum = i - 4000
        if doubleCount == 2 {
            break
        }
    }
}

print(Int(round(Double(total) / Double(num))))
mediumArr.sort()
print(mediumArr[num/2])
print(mostNum)
print(abs(mediumArr[num-1] - mediumArr[0]))
