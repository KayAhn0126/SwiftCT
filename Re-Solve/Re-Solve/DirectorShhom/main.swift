import Foundation

// 666 부터 6666666까지 시작하면서 6이 연속으로 3개 들어가면 +1
let num = Int(readLine()!)!

func find(_ num: Int) -> Int {
    var count = 0
    for i in 666...6666666 {
        var temp = i
        var sixCount = 0
        while temp > 0 {
            if temp % 10 == 6 {
                sixCount += 1
            } else {
                sixCount = 0
            }
            temp /= 10
            
            if sixCount == 3 {
                count += 1
                break
            }
        }
        if count == num {
            return i
        }
    }
    return 0
}

print(find(num))
