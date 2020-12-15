module MatrixPencils
# Release V1.4 (in preparation)

const BlasFloat = Union{Float64,Float32,ComplexF64,ComplexF32}
const BlasReal = Union{Float64,Float32}
const BlasComplex = Union{ComplexF64,ComplexF32}

using LinearAlgebra
using Polynomials
using Random

include("lapackutil2.jl")
import .LapackUtil2: larfg!, larfgl!, larf!, gghrd!, hgeqz!, tgexc!, tgsen!, lanv2, lag2, safemin, tgsyl!

export preduceBF, klf, klf_left, klf_leftinf, klf_right, klf_rlsplit, klf_right_refineut!, klf_left_refineut!
export prank, pkstruct, peigvals, pzeros, KRInfo
export isregular, isunimodular, fisplit, _svdlikeAE!, sfisplit
export sreduceBF, sklf, gsklf, sklf_right, sklf_left, sklf_right!, sklf_right2!, sklf_left!, sklf_rightfin!, sklf_rightfin2!, sklf_leftfin! 
export sprank, spkstruct, speigvals, spzeros
export lsminreal, lsminreal2, lsequal, lseval
export lpsminreal, lpsequal, lpseval
export poldivrem, polgcdvw, pollcm, conv, poldiv, convmtx, gcdvwupd, qrsolve!, poldeg, poldeg1
export poly2pm, pm2poly, pmdeg, pmreverse, pmeval, pmdivrem
export pm2lpCF1, pm2lpCF2, pm2lps, pm2ls, spm2ls, spm2lps, ls2pm, lps2pm
export pmkstruct, pmeigvals, pmzeros, pmzeros1, pmzeros2, pmroots, pmpoles, pmpoles1, pmpoles2, pmrank, ispmregular, ispmunimodular 
export rmeval, rm2lspm, rm2ls, ls2rm, rm2lps, lps2rm
export lpmfd2ls, rpmfd2ls, lpmfd2lps, rpmfd2lps, pminv2ls, pminv2lps
export rmkstruct, rmzeros, rmzeros1, rmpoles, rmpoles1, rmrank 
export saloc, salocd, salocinf, ordeigvals, isqtriu, eigselect1, eigselect2, saloc2
export fihess, fischur, fischursep, sfischursep, fiblkdiag, gsblkdiag, ssblkdiag
import LinearAlgebra: copy_oftype

include("klftools.jl")
include("regtools.jl")
include("klfapps.jl")
include("sklftools.jl")
include("sklfapps.jl")
include("lstools.jl")
include("pmtools.jl")
include("pmapps.jl")
include("poltools.jl")
include("rmtools.jl")
include("rmapps.jl")
include("lputil.jl")
include("slputil.jl")
include("gsfstab.jl")
include("gsep.jl")
# fallback for versions prior 1.1
if VERSION < v"1.1.0" 
function rank(A::AbstractMatrix; atol::Real = 0.0, rtol::Real = (min(size(A)...)*eps(real(float(one(eltype(A))))))*iszero(atol))
    isempty(A) && return 0 # 0-dimensional case
    s = svdvals(A)
    tol = max(atol, rtol*s[1])
    count(x -> x > tol, s)
end
end
 
end
