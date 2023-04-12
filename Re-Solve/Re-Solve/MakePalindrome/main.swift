import Foundation

let temp = readLine()!

var arr = [Int](repeating: 0, count: 26)

for i in temp {
    arr[Int(i.asciiValue!) - 65] += 1
}

var flag = false
var count = 0
for i in arr {
    if i % 2 != 0 {
        count += 1
        if count == 2 {
            flag = true
        }
    }
}
if flag == true {
    print("I'm Sorry Hansoo")
} else {
    var result = ""
    var myChar: Character = " "
    var oneMoreFlag = false
    for i in stride(from: 25, to: -1, by: -1) {
        if arr[i] % 2 != 0 {
            myChar = Character(UnicodeScalar(i + 65)!)
            oneMoreFlag = true
            arr[i] -= 1
        }
        for _ in stride(from: 0, to: arr[i], by: 2) {
            result += String(UnicodeScalar(i + 65)!)
            result = String(result.reversed()) + String(UnicodeScalar(i + 65)!)
        }
    }
    if oneMoreFlag == true {
        let index = result.index(result.startIndex, offsetBy: Int(result.count / 2))
        result.insert(myChar, at: index)
        print(result)
    } else {
        print(result)
    }
}

