
/*
 N개보다 많이 만드는것도 N개를 만드는 것에 포함된다.
 최대 랜선의 길이를 구해라
 
 K개를 N개로 만들어야 한다.
 
 */
import Foundation

let KN = readLine()!.split(separator: " ").map { Int(String($0))! }
let K = KN[0]
let N = KN[1]

var arr = [Int]()
for i in 0..<K {
    arr.append(Int(readLine()!)!)
}

func isBigger(_ testNum: Int) -> Bool {
    var tempResult = 0
    for element in arr {
        if element >= testNum {
            tempResult += (element / testNum)
        }
        if tempResult >= N {
            return true
        }
    }
    return false
}

func binarySearch() -> Int {
    var start = 0
    var end = 4294967295, mid = 0
    
    var result = 0
    while start <= end {
        mid = (start + end) / 2
        if isBigger(mid) == true {
            result = mid
            start = mid + 1
        } else {
            end = mid - 1
        }
    }
    return result
}
print(binarySearch())
