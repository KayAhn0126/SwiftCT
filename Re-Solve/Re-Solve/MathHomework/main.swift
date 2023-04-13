import Foundation

let number = Int(readLine()!)!

func removeZeroes(_ numInString: String) -> String {
    var x = numInString
    while x.first! == "0" {
        if x.count == 1 {
            return x
        }
        x.removeFirst()
    }
    return x
}

var result = [String]()

for i in 0..<number {
    let temp = readLine()!
    var store = ""
    for j in temp {
        if 97 <= j.asciiValue! && j.asciiValue! <= 122 {
            if store.isEmpty == true {
                continue
            } else {
                result.append(removeZeroes(store))
                store = ""
            }
        } else {
            store += String(j)
        }
    }
    if store.isEmpty == false {
        result.append(removeZeroes(store))
    }
}

result.sorted(by: {
    if $0.count == $1.count {
        return $0 < $1
    }
    return $0.count < $1.count
}).forEach {
    print($0)
}
