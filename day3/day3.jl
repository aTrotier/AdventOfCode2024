using ReadableRegex
path_ = joinpath(@__DIR__,"ressources/input.txt")
l = readlines(path_)

# define regex
re = look_for(one_or_more(DIGIT) * exactly(1,",") * one_or_more(DIGIT),
              after=exactly(1,"mul("),
              before=exactly(1,")"))

function sum_mul(l::AbstractString)::Int
  m=collect(eachmatch(re, l))
  res = 0
  for r ∈ m
    res = res + *(parse.(Int,split(r.match,','))...)
  end
  return res
end

res = sum(sum_mul.(l))
println("results = $res")
