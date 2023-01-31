import sys

userInput = int(sys.stdin.readline())

count = 2

for i in range(userInput):
    count = 2 * count - 1

print(count ** 2)
