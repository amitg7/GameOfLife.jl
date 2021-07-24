function cell_next_value(grid::Grid, i, j)
    cell_is_live = grid[i, j]
    num_of_live_neighbours = sum(neighbours(grid, i, j))

    # Any live cell with two or three live neighbours survives
    if cell_is_live && num_of_live_neighbours in [2, 3]
        return true
    
    # Any dead cell with three live neighbours becomes a live cell
    elseif !cell_is_live && num_of_live_neighbours == 3
        return true
    
    # All other live cells die in the next generation. Similarly, all other dead cells stay dead
    else
        return false
    end
end


function evolve_one_step(grid::Grid)
    N, M = size(grid)

    next_grid = copy(grid)

    for i = 1:N, j = 1:M
        next_grid[i, j] = cell_next_value(grid, i, j)
    end

    return next_grid
end


function run_game_of_life(initial_grid, generations::Int64)
    grid = initial_grid

    println("Generation 0:")
    display(grid)

    for x = 1:generations
        readline()

        grid = evolve_one_step(grid)

        println("\nGeneration $(x):")
        display(grid)
    end
end