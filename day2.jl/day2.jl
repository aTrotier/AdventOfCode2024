using DelimitedFiles


function day2(input_path::AbstractString)
  input = Int.(readdlm(input_path))

  d=Dict{Int,Int}()
  res = 0
  for i in axes(input,1)
    keyval = input[i,1]
    if ~haskey(d,input[i])
      d[keyval] = keyval*sum(input[:,2].==keyval)
    end
    res = res + d[keyval]
  end

  return res
end


day2("../ressources/day1_test.txt")
day2("../ressources/day1_input.txt")