# 2594 놀이공원
- 구현
- 시간
- 스위핑

## 🍎 지문 해석
- 놀이공원에서 일하는 세혁이와 근영이는 서로 좋아하는 사이인데 놀이기구 작동시간 이외의 쉬는시간에 만나려 한다.
- 놀이공원 개장은 10시.
- 놀이기구 작동시간이 주어진다.
    - 놀이기구가 작동 시작하기 10분전, 종료 이후 10분은 쉴 수 없다.
    - 어떤 놀이기구가 10시 30분에서 1시까지 작동한다면,
    - 10시 20분부터 1시 10분까지 놀이기구 준비 및 정리 때문에 쉴 수 없다는 이야기
- 가장 오래 쉬는 구간을 분(단위)으로 출력하면 된다.
## 🍎 문제 접근
- 오전 10시부터 오후 10시까지 일한다. -> 시간을 입력받자마자 10을 빼줘서 계산하기 쉽게 만들어준다.
- 시 * 60 + 분으로 계산하기 쉽게한다.
- 미리 시작시간에서 10을 빼주고 종료시간에 10을 더해준다.
- 1. 이미 종료가 된 경우,
    - last와 현재 시작시간의 시간 차 계산
- 2. 아직 종료가 안된 경우.
    - last를 현재 종료 시간으로 갱신

## 🍎 문제 풀이 및 전체 코드
```swift
import Foundation

let N = Int(readLine()!)!

if N > 0 {
    //MARK: 문자열을 분으로 통일
    func stringToTime(_ myString: String) -> Int {
        var result = 0
        let secondIndex = myString.index(myString.startIndex, offsetBy: 2)
        let hour = Int(String(myString[myString.startIndex..<secondIndex]))!
        let minute = Int(String(myString[secondIndex..<myString.endIndex]))!
        result += ((hour - 10) * 60) + minute
        return result
    }
    
    var timeTable = [(Int,Int)]()
    for _ in 0..<N {
        let temp = readLine()!.split(separator: " ").map { String($0) }
        timeTable.append((stringToTime(temp[0]) - 10, stringToTime(temp[1]) + 10))
    }
    
    //MARK: 튜플 타입의 요소 오름차순 정렬
    timeTable = timeTable.sorted(by: {
        return $0.0 < $1.0
    })
    
    var result = [Int]()
    result.append(timeTable[0].0)
    var last = timeTable[0].1
    for i in 1..<timeTable.count {
        let current = timeTable[i]
        let currentStart = current.0
        let currentEnd = current.1
        // 만약 이전 놀이기구 종료시간이 현재 시작시간 보다도 크고 종료시간 보다도 크면 못 쉰다!
        if last > currentStart && last > currentEnd {
            continue
        } else if last >= currentStart { // 이전 종료시간이 현재 시작시간보다 크지만 종료시간보다는 작을때 last 갱신
            last = currentEnd
        } else { // start가 확실히 더 큰 경우 -> 쉬는 시간이 존재했다!
            result.append(currentStart - last)
            last = currentEnd
        }
    }
    
    //MARK: 마지막 놀이기구가 끝나고 폐장 할 때까지 쉬는시간도 계산해주기!
    var finishTime = 12 * 60
    result.append(finishTime - last)
    if result.isEmpty {
        print(0)
    } else {
        print(result.max()!)
    }
} else {
    print(0)
}
```
