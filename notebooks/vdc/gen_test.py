import random as rd
rd.seed(70)

n = 20
limX = (0, 100)
limY = (0, 100)
city_pos = []
for _ in range(n):
    c = rd.randint(limX[0], limX[1]), rd.randint(limY[0], limY[1])
    city_pos.append(c)

with open("data.txt", "w", encoding="utf-8") as f:
    for x in city_pos:
        f.write(f"{x[0]}")
        f.write(",")
        f.write(f"{x[1]}")
        f.write("\n")

