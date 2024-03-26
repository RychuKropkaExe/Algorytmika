

# Złożoność obliczeniowa poniższego algorytmu
# To |F|*x + |uExcluded|*x + |3| * x
# Jako że każda z tych wartości jest stała
# To otrzymujemy coś w stylu:
# O(9*x + 9*x + 3*x) = O(x)
function notCodonAlgorithm(x::String)

    ATG::String = "ATG"
    F::Array{String} = ["TAA", "TAG", "TGA"]
    # Ze względu na to jak działa zaimplementowany algorytm
    # Nie uwzględniamy "ATG" w poniższym zbiorze
    uExcluded::Array{String} = ["TAA", "TAG", "TGA"]

    atgFlag::Bool = false
    uCounter::Int64 = 0
    startIndex::Int64 = 0

    textLen::Int64 = length(x)

    for i in 1:(textLen-2)

        # Sprawdzamy trójkami
        textBlock::String = x[i:i+2]

        # Jeżeli wykryliśmy wcześniej "ATG", to przed każdym następnym 
        # Sprawdzaniem inkrementujemy uCounter
        if atgFlag 

            uCounter += 1

        end

        # Bardzo specjalny przypadek, gdy łańcuch kończy się na "ATGA"
        # Gdyż wtedy element z uExcluded zaczynający się przed 
        # F posiada część wspólną z elementem z F
        # Więc jest to sytuacja w której powinniśmy zaliczyć taki
        # Łańcuch 
        if uCounter >= 29 && textBlock == ATG && i+3 < textLen && x[i+1:i+3] == "TGA"

            println("FOUND PATTERN AT INDEX: ", startIndex)

            atgFlag = false
            uCounter = 0

        end

        # Wykryliśmy "ATG". W tym miejscu, niezależnie gdzie to było, 
        # oznacza to powrót do stanu początkowego
        if textBlock == ATG

            uCounter = 0
            atgFlag = true
            startIndex = i
            
        end

        # Jeżeli wykryjemy zakazaną sekwejncję w u to wracamy
        # Do stanu początkowego
        if atgFlag &&  uCounter < 30 && textBlock in uExcluded
        
            atgFlag = false
            uCounter = 0
            
        end

        # Jeżeli spełniliśmy założenie długości u, to szukamy
        # Elementów F, które pokrywają się z textem
        if atgFlag && uCounter >= 30 && textBlock in F

            println("FOUND PATTERN AT INDEX: ", startIndex)

            atgFlag = false
            uCounter = 0

        end

    end

end


function main()

    # Przykłady od Joanny Kulig
    b = "ATGCACGTCCAACAAACATCAAAACAAAAAAAATAACTTTGATAATGCACGGTCCACAAACTCAAGGCAACAAAAAACTGA"
    #    ATG------------------------------TAA
    #                                                  ATG-------------------------------TGA

    c = "ATGCCAAAAAAAAATGCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCTAA"
    #    ATG------------x
    #                 ATG-------------------------------TAA
    println("FOR PATTERN B: ", b)
    notCodonAlgorithm(b)
    println("FOR PATTERN C: ", c)
    notCodonAlgorithm(c)

end

main()