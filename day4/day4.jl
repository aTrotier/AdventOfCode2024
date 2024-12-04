# Horizontal / vertical / diagonal (+/- backward)
using LinearAlgebra: diag

path_ = joinpath(@__DIR__,"ressources/input.txt")
l = readlines(path_)

M = Matrix{Char}(undef,size(l,1),length(l[1]))
for i in axes(l,1)
  M[i,:]=[l[i]...]
end
M

# create all comb
vec_xmas = []
for i in axes(M,2) # horizontal
  push!(vec_xmas,string(M[i,:]...))
end
for i in axes(M,1) # vertical
  push!(vec_xmas,string(M[:,i]...))
end
for i in -size(M,1)+1:1:size(M,1)-1 # diagonal
  push!(vec_xmas,string(diag(M,i)...))
  push!(vec_xmas,string((diag(rotl90(M),i)...)))
end

# also reverse
vec_tot = vcat(vec_xmas,[reverse(vec_xmas[i]) for i in eachindex(vec_xmas)])

re = r"XMAS"
count_XMAS = 0
for i in eachindex(vec_tot)
  count_XMAS += length(collect(eachmatch(re,vec_tot[i])))
end
count_XMAS

## Part 2. Patch
path_ = joinpath(@__DIR__,"ressources/input.txt")
l = readlines(path_)

M = Matrix{Char}(undef,size(l,1),length(l[1]))
for i in axes(l,1)
  M[i,:]=[l[i]...]
end
M

# Create patch
patch_vec = []
for i in 2:size(M,1)-1
  for j in 2:size(M,2)-1
    push!(patch_vec,M[i-1:i+1,j-1:j+1])
  end
end
patch_vec


function check_patch(patch_)
  patch_comp = ['M' '0' 'S';'0' 'A' '0';'M' '0' 'S']
  patch_comp_1 = rotl90(patch_comp)
  patch_comp_2 = rotl90(patch_comp_1)
  patch_comp_3 = rotl90(patch_comp_2)

  count_match = (sum(patch_ .== patch_comp) == 5) | (sum(patch_ .== patch_comp_1) == 5) | (sum(patch_ .== patch_comp_2) == 5) | (sum(patch_ .== patch_comp_3) == 5)
end

sum(check_patch.(patch_vec))
