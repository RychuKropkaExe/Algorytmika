function initialize_state_table(pat::Array{Char})
    len::Int64 = length(pat)
    if len == 1
        return [1]::Array{Int64}
    end
    table::Array{Int64} = zeros(1, len)
    table.=1
    j::Int64 = 1
    i::Int64 = 2
    while i <= len
        if pat[i] == pat[j]
            table[i] = j + 1
            j+=1
            i+=1
        else
            j = j - 1 == 0 ? 1 : table[j-1]
            if j == 1
                i+=1
            end
        end
    end
    return table        
end

function string_matcher(table::Array{Int64}, pattern::Array{Char}, file_path::String)
    f = open(file_path, "r")
    len::Int64 = length(pattern) + 1
    ptr::Int64 = 1
    res::Array{Int64} = []
    file_table = collect(read(f, String))
    file_len::Int64 = length(file_table)
    count::Int64 = 1
    while count != file_len
        if(file_table[count] == pattern[ptr])
            ptr+=1
            if(ptr == len)
                push!(res, count - (len -1) )
                ptr = table[ptr - 1]
            end
            count+=1
        else
            #Tu był problem
            while ptr != 1
                ptr = ptr - 1 == 0 ? 1 : table[ptr - 1]
                if(file_table[count] == pattern[ptr])
                    ptr+=1
                    if(ptr == len)
                        push!(res, count - (len -1) )
                        ptr = table[ptr - 1]
                    end
                    break
                end
            end
            count+=1
        end
    end
    close(f)
    println(pattern,":", res)
    return
end


function main(ARGS)
    if(length(ARGS) < 2)
        println("Not enough arguments provided")
        return nothing
    end
    pat_path::String = ARGS[1]
    f = open(pat_path, "r")
    file_path::String = abspath(ARGS[2])
    while !eof(f)
        line = readline(f)
        pat::Array{Char} = []
        count::Int64 = 1
        while true
            i = nextind(line,count)
            count = i
            if line[i] == '''
                break
            else
                push!(pat, line[i])
            end
        end
        table::Array{Int64} = initialize_state_table(pat)
        #println(table)
        string_matcher(table, pat, file_path)
    end
end


if abspath(PROGRAM_FILE) == @__FILE__
    main(ARGS)
end