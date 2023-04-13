import Foundation

// 1 - 팀, 시간 입력 받기
// 2 - 현재 이기고 있는 팀에 시간 더해주기
// 3 - 현재 시간을 이전 시간 변수에 넣어주기 (2번 작업을 위함)
// 4 - 마지막에 48분에서 한번 빼주기

// 시간은 주어진 값들 중에서 최소단위로!

let num = Int(readLine()!)!

var teamAScore = 0
var teamBScore = 0

var teamATime = 0
var teamBTime = 0

var prevTime = ""

//MARK: 문자열 시간을 초로 바꿔주는 함수 - String -> Int
func toSecond(_ time: String) -> Int {
    let newTime = time.split(separator: ":").map { Int(String($0))! }
    let min = newTime[0] * 60
    let second = newTime[1]
    return min + second
}

//MARK: 시간 계산 함수 - 단위(초)
func calculateTime(_ from: Int, _ to: Int) -> Int {
    return from - to
}

//MARK: 숫자를 시간으로 바꿔주는 함수 - Int -> String
func toTimeToString(_ num: Int) -> String {
    let newNum = num
    let min = newNum / 60
    let sec = newNum % 60
    var result = "00:00"
    if min < 10 && sec < 10 {
        result = "0\(min):0\(sec)"
    } else if min < 10 && sec >= 10 {
        result = "0\(min):\(sec)"
    } else if min >= 10 && sec < 10 {
        result = "\(min):0\(sec)"
    } else if min >= 10 && sec >= 10{
        result = "\(min):\(sec)"
    }
    return result
}

for _ in 0..<num {
    let teamTime = readLine()!.split(separator: " ").map { String($0) }
    let team = teamTime[0]
    let time = teamTime[1]
    
    if teamAScore > teamBScore {
        teamATime += calculateTime(toSecond(time), toSecond(prevTime))
    } else if teamAScore < teamBScore {
        teamBTime += calculateTime(toSecond(time), toSecond(prevTime))
    }
    if team == "1" {
        teamAScore += 1
    } else {
        teamBScore += 1
    }
    prevTime = time
}
if teamAScore > teamBScore {
    teamATime += calculateTime(toSecond("48:00"), toSecond(prevTime))
} else if teamAScore < teamBScore {
    teamBTime += calculateTime(toSecond("48:00"), toSecond(prevTime))
}
print(toTimeToString(teamATime))
print(toTimeToString(teamBTime))
