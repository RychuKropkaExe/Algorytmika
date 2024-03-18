base = 256
modulus = 2137

#define my_mod(a,n) ((a%n)+n)%n

function myMod(x)
    return ((x%modulus)+modulus)%modulus
end

function horner(poly, n, x, modulus)

    result = poly[1]
  
    for i in 2:n
        result = (result*x + poly[i]) % modulus
    end

    return result

end

function main() 
    txt = "GEEKS FOR GEEKS" |> collect |> (x -> [Int64(elem) for elem in x])
    pat = "GEEK" |> collect |> (x -> [Int64(elem) for elem in x])

    patLen = length(pat)

    rabinKarp(pat, txt)
end 

function rabinKarp(pat, txt)
    patLen = length(pat)
    patHash = horner(pat, patLen, base, modulus)
    currentHash = horner(txt, patLen, base, modulus)

    startPointer = 1

    for i in (patLen+1):length(txt)

        if patHash == currentHash && pat == txt[startPointer:(startPointer+patLen-1)]
            
            println("FOUND MATCH AT INDEX: ", startPointer)
            
        end
        
        currentHash = myMod(currentHash - myMod((txt[startPointer])*base^(patLen-1)))
        currentHash = myMod(currentHash*base)
        currentHash = myMod(currentHash + txt[i])
        startPointer += 1
        #println(currentHash)

    end

end

main()