MAX_N = 10
sequence = [0]*MAX_N
CNT = 0


def print_chars(n) {
    for ()
    print(sequence[i])
    print("\n")
}


def gen(i, n, k) :
    if (i == n) {
        print_chars(n)
        return
    }
    sequence[i] = '('
    if (n - i >= k + 1)
    gen(i + 1, n, k + 1)
    sequence[i] = ')'
    if (k > 0)
    gen(i + 1, n, k - 1)
}


gen(0, 8, 0)
