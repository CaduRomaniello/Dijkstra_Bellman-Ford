include("structs.jl")
include("algoritmos.jl")
include("functions.jl")

using JSON
using Printf

function main(ARGS)
    
    if (length(ARGS) != 3)
        println("Execução errada!")
        println("Para executar o programa digite: ")
        println("julia main.jl arquivo.json verticeOrigen, algoritmo")
        println("Algoritmos disponiveis: [dijkstra, bellman_ford]")
        return
    end

    aux = split(ARGS[1], ".")
    if (!(aux[2] == "JSON" || aux[2] == "json"))
        println("Arquivo de entrada fornecido nao eh do tipo JSON")
        return
    end
    dir = pwd()
    dados = JSON.parse(open("$(dir)/JSON/$(ARGS[1])"))
    
    # Lendo vertices
    vertices = Array{Vertice, 1}()
    lerVertices(vertices, dados)
    
    # Lendo arestas nao direcionadas
    countArestas = 1
    arestas = Array{Aresta, 1}()
    countArestas = lerNaoDirecionadas(arestas, vertices, dados, countArestas)

    # Lendo arestas nao direcionadas
    countArestas = LerDirecionadas(arestas, vertices, dados, countArestas)

    # Relacionando vertices e arestas
    relacionarVerticesArestas(vertices, arestas)

    # Chamando algoritmo principal
    if (ARGS[3] == "dijkstra")
        dijkstra(vertices, arestas, ARGS[2])
    elseif (ARGS[3] == "bellman_ford")
        bellman_ford(vertices, arestas, ARGS[2])
    else
        println("Algoritmo digitado inválido!")
        return
    end

end

main(ARGS)