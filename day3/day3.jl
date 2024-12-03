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


### Part 2 : proccess only string after do()
path_ = joinpath(@__DIR__,"ressources/input.txt")
l = join(readlines(path_))
#l=join(l)

function count_do(l::AbstractString)::Int
  l2 = split.(l,"don't()")
  l3 = split.(l2,"do()")

  keep=[]
  push!(keep,l2[1]) # first line start with do()
  for i in axes(l3,1)[2:end]
    for j =  2:length(l3[i])
      push!(keep,l3[i][j])
    end
  end

  return sum(sum_mul.(keep))
end

res = sum(count_do.(l))
println("results = $res")