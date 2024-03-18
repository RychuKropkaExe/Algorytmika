# For patter a a b c
# __________
# |*|a|b|c|d| 
# |0|1|0|0|0| 
# |1|2|0|0|0|
# |2|2|3|0|0|
# |3|1|0|4|0|

function initialize_dict(paths::Array{String}, pat::Array{Char})
    # alph::Array{Char,1} = []
    dict::Dict{Char,Array{Int64}} = Dict{Char,Array{Int64}}()
    for path in paths
    f = open(path, "r")
        while !eof(f)
            dict[read(f, Char)] = []
        end
    end
    len = length(pat)
    for (key, val) in dict
        dict[key] = zeros(1,len)
    end
    return dict::Dict{Char,Array{Int64}}  
end


function initialize_state_table(dict::Dict{Char,Array{Int64}}, pat::Array{Char})
    #pat = collect(pattern)
    len::Int64 = length(pat)
    for (key, val) in dict
        for i in 1:len
            if(key == pat[i])
                dict[key][i] = i
            else
                slice::Array{Char} = pat[1:i]
                popfirst!(slice)
                if(!isempty(slice))
                    pop!(slice)
                end
                push!(slice,key)
                j::Int64 = 0
                for j in reverse(1:i-1)
                    if(isempty(slice))
                        dict[key][i] = 0
                        break
                    end
                    if(slice == pat[1:j])
                        dict[key][i] = j
                        break
                    else
                        popfirst!(slice)
                    end
                end
            end
        end
    end
    return dict::Dict{Char,Array{Int64}}
end

function string_matcher(dict::Dict{Char,Array{Int64}}, pattern::Array{Char}, path::String)
    state::Int64 = 0
    f = open(path, "r")
    count::Int64 = 0
    result::Array{Int64} = []
    while !eof(f)
        i = read(f,Char)
        state = dict[i][state+1]
        if(state == length(pattern))
            push!(result, count - (length(pattern) - 1))
            state = 0
        end
        count+=1
    end
    println(pattern," : ",result)
    return
end

function main(ARGS)
    if(length(ARGS) < 2)
        println("Not enough arguments provided")
        return nothing
    end
    patterns::String = abspath(ARGS[1])
    file_path::String = abspath(ARGS[2])
    f = open(patterns, "r")
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
        dict::Dict{Char,Array{Int64}} = initialize_dict([file_path,patterns],pat)
        dict = initialize_state_table(dict, pat)
        string_matcher(dict, pat, file_path)
    end
end


if abspath(PROGRAM_FILE) == @__FILE__
    main(ARGS)
end