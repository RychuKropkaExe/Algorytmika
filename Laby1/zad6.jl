function horner(poly, n, x)

    result = poly[1]
  
    for i in 2:n
        result = result*x + poly[i]
    end
  
    return result

end

println(horner([1,2,3,4], 4, 2))