using Printf

function dijkstra(vertices::Array{Vertice, 1}, arestas::Array{Aresta, 1}, verticeOrigem::String)
    
    tabelaPesos = Array{intOrNothing, 2}(undef, length(vertices), length(vertices))
    for i = 1:length(vertices)
        for j = 1:length(vertices)
            tabelaPesos[i, j] = nothing
        end
    end

    criarTabelaPesos(tabelaPesos, arestas)

    dt = zeros(Int64, length(vertices))
    for i = 1:length(dt)
        if (vertices[i].nome != verticeOrigem)
            dt[i] = typemax(Int64) - 10000000
        end
    end
    rot = zeros(Int64, length(vertices))

    abertos = []
    fechados = []
    for i = 1:length(vertices)
        push!(abertos, vertices[i].id)
    end

    dtTimeLine = [deepcopy(dt)]
    rotTimeLine = [deepcopy(rot)]

    cont = 1
    while (length(fechados) != length(vertices))

        # v <- elemento de A, tal que dt[i] é o minimo dentre os elementos de A
        menorPos = 0
        valor = typemax(Int64)
        for i = 1:length(dt)
            if (dt[i] < valor && (i in abertos))
                valor = dt[i]
                menorPos = i
            end
        end
        if (menorPos == 0)
            println("ERRO")
            return
        end

        # F <- F U {v}
        push!(fechados, menorPos)

        # A <- A\{v}
        remove = findfirst(isequal(menorPos), abertos)
        deleteat!(abertos, remove)

        # N <- N\F
        # para u ∈ N faca
        
        for i = 1:length(vertices[menorPos].arestas)
            vizinho = encontrarVizinho(vertices[menorPos], vertices[menorPos].arestas[i])
            if (dt[menorPos] + vertices[menorPos].arestas[i].peso < dt[vizinho])
                dt[vizinho] = dt[menorPos] + vertices[menorPos].arestas[i].peso
                rot[vizinho] = menorPos
            end

        end

        push!(dtTimeLine, deepcopy(dt))
        push!(rotTimeLine, deepcopy(rot))

    end

    imprimeResultado(vertices, arestas, dtTimeLine, rotTimeLine)

end

function bellman_ford(vertices::Array{Vertice, 1}, arestas::Array{Aresta, 1}, verticeOrigem::String)
    
    posOrigem = 0
    for i = 1:length(vertices)
        if (vertices[i].nome == verticeOrigem)
            posOrigem = i
            break
        end
    end

    vizinhos = encontrarVizinhos(vertices[posOrigem])
    dt = zeros(Int64, length(vertices))
    rot = zeros(Int64, length(vertices))
    for i = 1:length(dt)
        if (vertices[i].nome != verticeOrigem)
            if (i in vizinhos)
                x = findfirst(isequal(i), vizinhos)
                rot[i] = posOrigem
                dt[i] = vertices[posOrigem].arestas[x].peso
            else
                dt[i] = typemax(Int64) - 10000000
            end
        end
    end

    fechoTransitivo = encontraFechoTransitivo(vertices)

    dtTimeLine = [deepcopy(dt)]
    rotTimeLine = [deepcopy(rot)]

    for k = 1:(length(vertices) - 1)
        altera = false

        for i = 1:length(vertices)
            if (i == posOrigem)
                continue
            end

            for j = 1:length(fechoTransitivo[i])

                posVizinho = fechoTransitivo[i][j]
                aux = encontrarVizinhos(vertices[posVizinho])
                x = findfirst(isequal(i), aux)
                if (dt[i] > dt[posVizinho] + vertices[posVizinho].arestas[x].peso)
                    dt[i] = dt[posVizinho] + vertices[posVizinho].arestas[x].peso
                    rot[i] = posVizinho
                    altera = true
                end

            end

        end

        push!(dtTimeLine, deepcopy(dt))
        push!(rotTimeLine, deepcopy(rot))

        if (!altera)
            break
        end
    end

    imprimeResultado(vertices, arestas, dtTimeLine, rotTimeLine)

end