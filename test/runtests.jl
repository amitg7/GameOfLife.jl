using Test
using GameOfLife


g = GameOfLife.GridBool([
    0 0 0 1
    1 0 0 1
    1 1 0 1
    ])

g_next = GameOfLife.GridBool([
    0 0 0 0
    1 1 0 1
    1 1 1 0
    ])


@test GameOfLife.evolve_one_step(g) == g_next