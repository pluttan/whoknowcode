SET(0, 5, 2)
SET(5, 8, 3)
PRINT(GET_SUM(4, 5))
PRINT(GET_SUM(5, 6))
FOR I = 1 TO 5 DO
ADD((4 * I) % 10, ((4 * I) % 10) + 2, (I % 2) * 2)
PRINT(GET_SUM(0, 10))
PRINT(GET_SUM(4, 6))


def CREATE(N):
    n = 10
    struct = [0]*n
