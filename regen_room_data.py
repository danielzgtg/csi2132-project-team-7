#!/usr/bin/env python3
import random
import re

PATTERN = re.compile(r"\('([^']+)',\s*'([^']+)',\s*'[^']+',\s*(\d+),\s*'[^']+',\s*'[^']+',\s*123456789")


def main():
    with open("docker-entrypoint-initdb.d/2-examples.sql") as f:
        data = f.read()
    data = data.split("INSERT INTO hotel")[1].split("VALUES")[1]
    lines = iter(data.split("),"))
    cur = next(lines)
    output = []
    try:
        while True:
            if '(' in cur:
                match = PATTERN.search(cur)
                output.append((match.group(1), match.group(2), match.group(3)))
                match.group()
            cur = next(lines)
    except StopIteration:
        pass
    rng = random.Random(1)
    BASE_PRICE = [30, 50, 70, 100, 120]
    #  (address_of_hotel, area_of_hotel, room_id, room_price_cents, capacity, extended_capacity, problems_or_damages) VALUES
    for out in output:
        capacities = [1, 2, 3, 4, 5]
        rng.shuffle(capacities)
        for room_id in range(1, 6):
            ranking = out[2]
            capacity = capacities[room_id - 1]
            extended_capacity = max(capacity, rng.randint(1, 3))
            price = 100 * (BASE_PRICE[int(ranking) - 1] + capacity * 20 + extended_capacity * 10) + rng.randrange(0, 1000)
            print(f"('{out[0]}', '{out[1]}', {room_id}, {price}, {capacity}, {extended_capacity}, ''),")
    print(len(output))


if __name__ == '__main__':
    main()
