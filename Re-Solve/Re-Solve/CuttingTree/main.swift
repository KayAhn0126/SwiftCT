import Foundation

//MARK: 설명
/*
 높이 H
 적어도 나무 M미터를 집에 가져가기 위해 전기톱의 높이를 최대한으로 올려야한다.
 
 0에서 ~ 20억까지 start와 end 설정 후 매번 mid를 설정하고
 total에 mid - arr[i]를 더해준다.
 만약 total이 M을 넘어가면 start를 mid + 1로 정해준다.
 만약 total이 M을 넘어가지 않으면 end를 mid - 1로 정해준다.
 상근이는 집에 필요한 나무를 항상 가져갈 수 있다.
 
 최대값을 찾아야한다.
 */

let NM = readLine()!.split(separator: " ").map { Int(String($0))! }
let N = NM[0]
let M = NM[1]

var arr = readLine()!.split(separator: " ").map { Int(String($0))! }

func binarySearch() -> Int {
    var start = 0
    var end = 2000000000
    var mid = 0
    var result = 0
    while start <= end {
        var total = 0
        mid = (start + end) / 2
        for elementNumber in arr {
            let tempNum = elementNumber - mid
            if tempNum > 0 {
                total += tempNum
            }
        }
        if total >= M {
            result = mid
            start = mid + 1
        } else if total < M {
            end = mid - 1
        }
    }
    return result
}
print(binarySearch())
