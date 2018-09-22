a = []

x = int(input())
a.append(x)
summa = x

while summa != 0:
    x = int(input())
    a.append(x)
    summa += x

for i in a:
    print(i**2)
