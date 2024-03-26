using Graphs

# Okazuje się, że to nie takie proste wylosować
# z dobrym rozkładem dwie różne liczby
# Ale ta funkcja robi to zaskakująco
# dobrze
function draw2(n)
    a = rand(1:n)
    b = rand(1:n-1)
    b += (b >= a)
    return a, b
end

# Funkcja sama się opisuje
function getRandomVertexPair(g::SimpleGraph)

    flag = false

    result = (0, 0)

    while !flag

        v1, v2 = draw2(nv(g))

        if has_edge(g, v1, v2)

            return (v1, v2)

        end


    end

end

function minCutKarger(graph::SimpleGraph)

    g::SimpleGraph = SimpleGraph(graph)

    # Zasadniczo używam tutaj implementacji grafów w Julii
    # (Zakładam że to nie jest nielegalne) jednakże
    # gdy złączymy ze sobą dwa wierzchołki to zmienia się
    # numeracja w tym grafie, stąd istnienie tej tablicy
    # Która odpowiada za śledzenie tego
    vertcises::Array{Array{Int64}} = [[i] for i in 1:nv(g)] 

    while nv(g) > 2

        v1, v2 = getRandomVertexPair(g)

        # Zcalanie dwóch wierzchołków lub grupy
        # w jedną, we wspomnianej tablicy do śledzenia
        # numerów wierzchołków
        append!(vertcises[v1], vertcises[v2])

        # Usuwanie niepotrzebnej tablicy
        splice!(vertcises, v2)

        # Łaczenie wierzchołków w grafie
        # Tak jak wspomniałem zmienia to numery
        # wierzchołków ze względu użycia biblioteki
        merge_vertices!(g, [v1, v2])

    end

    # Z tym minimalnym to tylko żarty oczywiście,
    # nie ma gwarancji że taka losowa metoda da
    # w konkretnym podejściu min cut
    minCut::Array{Tuple{Int64, Int64}} = []

    # Znajdujemy wszystkie krawędzie pomiędzy
    # pierwszą grupą wierzchołków i drugą
    # By znaleźć cut
    for i in vertcises[1]

        for j in vertcises[2]

            if has_edge(graph, i, j)

                push!(minCut, (i, j))

            end

        end

    end

    return vertcises, minCut

end

function main()

    g = SimpleGraph()

    add_vertices!(g, 4)

    # Przykłady od Piotra Piotrowskiego
    #//////////////////////////////////////////////////EXAMPLE 1//////////////////////////
    add_edge!(g, 1, 2);
    add_edge!(g, 1, 3);
    add_edge!(g, 1, 4);
    add_edge!(g, 2, 4);
    add_edge!(g, 3, 4);

    println(nv(g))

    println(minCutKarger(g))

    g2 = SimpleGraph()

    add_vertices!(g2, 10)

    #////////////////////////////////////////////////EXAMPLE 2///////////////////////////
    add_edge!(g2, 1, 2);
    add_edge!(g2, 1, 3);
    add_edge!(g2, 1, 4);
    add_edge!(g2, 1, 5);
    add_edge!(g2, 2, 3);
    add_edge!(g2, 2, 4);
    add_edge!(g2, 2, 5);
    add_edge!(g2, 3, 4);
    add_edge!(g2, 3, 5);
    add_edge!(g2, 4, 5);
    add_edge!(g2, 6, 7);
    add_edge!(g2, 6, 8);
    add_edge!(g2, 6, 9);
    add_edge!(g2, 6, 10);
    add_edge!(g2, 7, 8);
    add_edge!(g2, 7, 9);
    add_edge!(g2, 7, 10);
    add_edge!(g2, 8, 9);
    add_edge!(g2, 8, 10);
    add_edge!(g2, 9, 10);
    add_edge!(g2, 1, 8);
    add_edge!(g2, 2, 9);
    add_edge!(g2, 3, 10);

    println(minCutKarger(g2))
    

end


main()