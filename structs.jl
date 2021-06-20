using Base: Int64, String

abstract type Aresta end
intOrNothing = Union{Int64, Nothing}

mutable struct Direcionada <: Aresta
    id::Int64
    nome::String
    origem::Int64
    destino::Int64
    peso::Int64
    visitado::Bool

    Direcionada() = new()
    Direcionada(x, y, w, z, b, p) = new(x, y, w, z, b, p)
end

mutable struct NaoDirecionada <: Aresta
    id::Int64
    nome::String
    vertice1::Int64
    vertice2::Int64
    peso::Int64
    visitado::Bool

    NaoDirecionada() = new()
    NaoDirecionada(x, y, w, z, b, p) = new(x, y, w, z, b, p)
end

mutable struct Vertice
    id::Int64
    nome::String
    arestas::Array{Aresta, 1}
    visitado::Bool

    Vertice() = new()
    Vertice(x, y, w) = new(x, y, w, false)
end