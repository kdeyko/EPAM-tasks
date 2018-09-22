def switcher(l1):
    lmax = max(l1)
    lmin = min(l1)
    lmax_index = l1.index(lmax)
    lmin_index = l1.index(lmin)
    l1[lmax_index] = lmin
    l1[lmin_index] = lmax
    return l1


list1 = [1, 2, 3, 4, 5, 6, 7]
print(switcher(list1))
