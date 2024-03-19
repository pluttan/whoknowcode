MAX_N = 10 sequence[MAX_N] CNT = 0

    func
    print_chars(n)
{
    for (i = 0; i < n; ++i)
        print(sequence[i])
            print("\n")
}

func gen(i, n, k)
{
    if (i == n)
    {
        print_chars(n) return
    }
    sequence[i] = '(' if (n - i >= k + 1)
        gen(i + 1, n, k + 1)
            sequence[i] = ')' if (k > 0)
                gen(i + 1, n, k - 1)
}

gen(0, 8, 0)