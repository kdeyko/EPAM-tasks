def div7not5(a,b):
    for x in range(a,b + 1):
        if x % 7 == 0 and x % 5 != 0:
            print(x)


div7not5(0,40)
