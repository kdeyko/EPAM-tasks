def dictGen(l1, l2):
    newDict = {}
    minLen = min(len(l1), len(l2))
    for i in range(minLen):
        newDict[l1[i]] = l2[i]
    return newDict


l1 = ['name', 'age', 'weight', 'email']
l2 = ['John', 55, 80, 'yo@m.ru', 90, 999, 10]

print(dictGen(l1, l2))
