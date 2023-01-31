import sys

asce = [1,2,3,4,5,6,7,8]
desc = [8,7,6,5,4,3,2,1]

userInput = list(map(int, sys.stdin.readline().split()))

if userInput == asce:
    print("ascending")
elif userInput == desc :
    print("descending")
else:
    print("mixed")
