# Zwykła funkcja do obliczania lcs, jako że zadanie nie kazało nam
# bezpośrednio jej implementować, to pozwoliłem sobie skorzystać z
# wyszukiwarki google w celu znalezienia takowej, bo Julia nie posiada
# działającego pakietu do takich zadań(istniejacy jest martwy). Mam
# nadzieję, że nie jest to nielegalne.
function LCS(arr1::Array, arr2::Array)::Int32
    m, n = length(arr1) + 1, length(arr2) + 1
    dp = fill(0, m, n)

    for i in 2:m, j in 2:n
        dp[i, j] = (arr1[i - 1] == arr2[j - 1]) ? (dp[i - 1, j - 1] + 1) : max(dp[i - 1, j], dp[i, j - 1])
    end

    return dp[m, n]
end

function LCSExpectedValue(n::Int)::Float64

    # Zamiast bawienia się w generowanie tych ciągów
    # Możemy skorzystać z tego, że takie ciągi to po
    # prostu liczby 5 bitowe i na ich podstawie pokryć
    # Wszystkie ciągi bez dziwnych operacji
    maxNumber::Int64 = 2^n

    expectedValue::Float64 = 0.0

    # Prawdopodobieństwo pojedyńczej kombinacji
    # Czyli 1 / |A| gdzie A to zbiór 
    # kombinacji x, y bez uwzględniania
    # kombinacji (y, x)
    numberOfCombinations::Int64 = 2^(2*n)

    # Te petle wyznaczają wszystkie kombinacje dla (x, y)
    # Ale nie wyznaczają dla (y, x), bo nie jest to konieczne.
    # Wartość lcs dla (y, x) jest ta sama co dla (x, y)
    # co koniec końców można skrócić i nie zmieni to wyniku
    for i in 0:(maxNumber-1)

        firstNumberInBits::String = bitstring(i)[(64-n)+1:64]
        firstString::Array = collect(firstNumberInBits)

        for j in 0:(maxNumber-1)

            secondNumberInBits::String = bitstring(j)[(64-n)+1:64]
            secondString::Array = collect(secondNumberInBits)
            
            expectedValue += LCS(firstString, secondString)

        end

    end

    return expectedValue/numberOfCombinations

end


function main()

    println(LCSExpectedValue(5))

end

main()