import Foundation

let targetNumberInString = readLine()!
let targetNumber = Int(targetNumberInString)!

let brokenCount = Int(readLine()!)!
var result = abs(targetNumber - 100) // 100에서 타겟 넘버까지 +,- 버튼을 누른 횟수

var brokenArr = [Bool](repeating: false, count: 10) // 고장난 버튼이 어떤 버튼인지 알 수 있도록 담아두는 배열

//MARK: 랜덤한 브루트포스의 숫자가 고장난 키를 가지고 있는지 확인하는 함수
func checkNumber(_ num: Int) -> Bool {
    var flag = true
    var testNum = num
    // 원래는 while testNum > 0으로 고장난 키패드를 포함하는지 확인했다.
    // 하지만 분기 처리한 이유는 0이 들어왔을때 while testNum > 0 으로 한다면 0을 처리하지 못한다.
    if testNum > 9 {
        while testNum > 0 {
            if brokenArr[testNum % 10] == true {
                flag = false
            }
            testNum /= 10
        }
    } else {
        if brokenArr[testNum] == true {
            flag = false
        }
    }
    
    return flag
}

if brokenCount == 0 {
    //고장난 버튼이 하나도 없다면, 타겟 넘버를 직접 누르는 것과 100에서 +,- 버튼을 눌러 타겟넘버에 도달하는 것 중 작은것을 출력하면 된다.
    result = result > targetNumberInString.count ? targetNumberInString.count : result
} else {
    // 고장난 버튼이 있다면,
    let tempArr = readLine()!.split(separator: " ").map { Int(String($0))! }
    for i in tempArr {
        brokenArr[i] = true
    }
    for i in 0...1000000 {
        if checkNumber(i) == true { // 현재 숫자 i가 고장난 키를 포함하고 있지 않다면
            // i를 누르기 위해서 버튼을 클릭한 횟수와 + 이제 i에서 target 숫자까지 도달하기 위한 +,- 버튼을 누른 숫자를 더한다.
            let tempResult = String(i).count + abs(targetNumber - i)
            
            // 이미 맨 위에서 result에 100에서 target 숫자까지 +,- 버튼만으로 가는 횟수를 구했다.
            // tempResult가 (100에서 타켓까지 +,-로만 이동할 때의 숫자)보다 작으면 갱신을 시켜준다.
            
            result = result > tempResult ? tempResult : result
            
            // 예를 들어 타겟 넘버가 150이고 고장난 숫자 1개 -> 9라고 해보자
            // 이미 맨 위에서 result에 100에서 target 숫자까지 +,- 버튼만으로 가는 횟수를 구했다.
            // 즉 현재 result는 50이다 -> 100에서 50번만 +를 누르면 되기 때문에.
            // 이제 result보다 작은 값이 있는지 확인해보자!
            // i = 0, (0을 입력해야 하므로 1) + (0에서 타겟넘버인 150까지 + 버튼을 150번 눌러야 하므로 150) = 151
            // 151은 50보다 크니까 최소값이 될 수 없다.
            // i = 1, (1을 입력해야 하므로 1) + (1에서 타겟넘버인 150까지 + 버튼을 149번 눌러야 하므로 149) = 150
            // ...
            // i = 10, (10을 입력해야 하므로 2) + (10에서 타겟넘버인 150까지 + 버튼을 140번 눌러야 하므로 140) = 142
            // i = 100, (100을 입력해야 하므로 3) + (100에서 타겟넘버인 150까지 + 버튼을 50번 눌러야 하므로 50) = 53
            // i = 150, (150을 입력해야 하므로 3) + (150에서 타겟넘버인 150까지 아무것도 안눌러도 되므로 0) = 3
            // 이 경우 답은 가장 작은 숫자인 3이 된다.
        }
    }
}
print(result)

