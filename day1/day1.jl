using DelimitedFiles

function day1(input_path::AbstractString)
  input = Int.(readdlm(input_path))
  l1 = sort(input[:,1])
  l2 = sort(input[:,2])
  return sum(abs.(l1.-l2))
end


day1("../ressources/day1_test.txt")
day1("../ressources/day1_input.txt")