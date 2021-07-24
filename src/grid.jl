using DelimitedFiles


abstract type AbstractGrid{T} end


struct Grid{T} <: AbstractGrid{T}
    cells::Array{T, 2}
end


const GridBool = Grid{Bool}


Base.getindex(g::Grid, I...) = getindex(g.cells, I...)
Base.getindex(g::Grid, index::CartesianIndex) = getindex(g.cells, index[1], index[2])
Base.setindex!(g::Grid, v, I...) = setindex!(g.cells, v, I...)
Base.size(g::Grid) = size(g.cells)
Base.:(==)(x::Grid, y::Grid) = x.cells == y.cells
Base.copy(g::Grid) = Grid(copy(g.cells))


function neighbours(grid::Grid, i, j)
    N, M = size(grid)
    nn = []
    for k in [i - 1, i, i + 1]
        for l in [j - 1, j, j + 1]
            if 1 <= k <= N && 1 <= l <= M && !(k == i && l == j)
                push!(nn, CartesianIndex((k, l)))
            end
        end
    end
    return nn
end


function read_grid(file_path)
    return Grid(readdlm(file_path, ' ', Bool))
end


function random_grid(N, M)
    return Grid(rand(Bool, N, M))
end


function Base.display(grid::Grid)
    display(grid.cells)
end


struct G{T} <: AbstractMatrix{T}
    cells::Array{T, 2}
end