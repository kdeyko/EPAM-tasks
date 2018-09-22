def accum(string):

    return '-'.join(c.upper() + c.lower() * i for i, c in enumerate(string))
    #
    # new_s = ''
    # for i in range(len(string)):
    #     new_s += string[i].upper()
    #     new_s += i * string[i].lower()
    #     new_s += '-'
    # print(new_s[:-1])


s = 'ErTyUop'
print(accum(s))
