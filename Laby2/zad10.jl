using Distributions

function monteCarlo(n)

    xs = rand(Uniform(0.0,pi),n)
    ys = rand(Uniform(0.0,1.0),n)

    hits = 0

    area = pi

    for i in 1:n

        x = xs[i]
        y = ys[i]

        if y < sin(x)
            hits += 1
        end

    end

    delta = hits/n

    return delta * area
end

function main()
    println(monteCarlo(100))
    println(monteCarlo(1000))
    println(monteCarlo(10000))
    println(monteCarlo(100000))
    println(monteCarlo(1000000))
    println(monteCarlo(10000000))
    println(monteCarlo(100000000))
end

main()