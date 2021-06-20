# Dijkstra & Bellman-Ford
Neste repositório está presente os algoritmos de Dijkstra e Bellman-Ford implementados em Julia.
---
### Requisitos
Para poder executar o programa em sua máquina será necessário realizar o download do compilador de [Julia](https://julialang.org/downloads/)
---
### Execução
A execução é a mesma tanto para windows quanto para linux. Na linha de comando será necessário passar 3 parâmetros

```bash
> julia main.jl <arquivo.json> <verticeOrigen> <algoritmo>
```

Os parâmetros entre <> são parâmetros obrigatórios. 
- <arquivo.json> - este arquivo JSON deverá seguir um padrão que está representado na seção abaixo e deverá conter o grafo no qual se deseja executar o algoritmo;
- <verticeOrigem> - este parâmetro deverá conter o nome do vértice de origem que deve ser idêntico ao ome do vértice no arquivo .JSON;
- <algoritmo> - este parâmetro deverá conter qual algoritmo se deseja executar. Atualmente ele possui duas opções: `dijkstra` ou `bellman_ford`.
---
### JSON
O algoritmo usa como base um arquivo JOSN para compor o grafo, portanto ele deve segui um padrão.

```JSON
{
    "vertices": [
        {"nome": "0"},
        {"nome": "1"},
        {"nome": "2"}
    ],
    "arestasNaoDirecionadas": [
        {"nome": "aresta 0", "vertice1": "0", "vertice2": "1", "peso": 2}
    ], 
    "arestasDirecionadas": [
        {"nome": "aresta 1", "origem": "2", "destino": "1", "peso": 1}
    ]
}
```

- No campo de `vertices` deverão ser listados todos os vértices do grafo com seus respectivos nomes;
- No campo `arestasNaoDirecionadas` deverão ser inseridas todas as arestas não direcionadas do grafo com atenção aos campos `vertice1` e `vertice2` que deverão conter os nomes exatos dos vértices;
- No campo `arestasDirecionadas` deverão ser isneridas as arestas direcioandsa do grafo com atenção aos campos `origem` e `destino` que deverão conter os nomes extaos dos vértices e por serem arestas orientadas os vértices inseridos nesses campos devem correpsonder com o grafo original.
