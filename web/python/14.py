def get_popular_name_from_file(filename):
    names = []
    maxcount = 0
    maxnames = []
    with open(filename) as f:
        names = f.readlines()
    for i in range(len(names)):
        names[i] = names[i].split()[0]
    for i in set(names):
        nowcount = names.count(i)
        if (nowcount > maxcount):
            maxnames = [i]
            maxcount = nowcount
        elif (nowcount == maxcount):
            maxnames.append(i)
    return ", ".join(sorted(maxnames))


print(get_popular_name_from_file("1.txt"))
