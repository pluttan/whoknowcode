def lists_sum(*lst, unique=False):
    if unique:
        return sum(set(j for i in lst for j in i))
    else:
        return sum(j for i in lst for j in i)


lists_sum([1, 2, 1, 2])
