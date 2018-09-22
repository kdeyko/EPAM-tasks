def dictSwitcher(d1):
    newDict = {}
    for key in d1:
        newKey = d1.get(key)
        newDict[newKey] = key
    return newDict


mydict = {'name': 'John', 'age': 55, 'weight': 80}
print(dictSwitcher(mydict))