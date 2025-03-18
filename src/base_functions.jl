"""
    Zero()

Constructs the zero function, i.e., the function that is zero everywhere.

# Example
```jldoctest
julia> f = Zero()
Zero()

julia> f(rand(3))
0.0
```
"""
struct Zero end

(::Zero)(x) = real(eltype(x))(0)

function gradient!(y, f::Zero, x)
    y .= eltype(x)(0)
    return f(x)
end

function prox!(y, ::Zero, x, gamma)
    y .= x
    return real(eltype(y))(0)
end

is_convex(::Type{Zero}) = true
is_generalized_quadratic(::Type{Zero}) = true

"""
    IndZero()

Constructs the indicator function of the zero set, i.e., the function that is zero if the input is zero and infinity otherwise.

# Example
```jldoctest
julia> f = IndZero()
IndZero()

julia> f([1, 2, 3])
Inf

julia> f([0, 0, 0])
0.0
```
"""
struct IndZero end

function (::IndZero)(x)
    R = real(eltype(x))
    if iszero(x)
        return R(0)
    end
    return R(Inf)
end

is_convex(::Type{IndZero}) = true
is_generalized_quadratic(::Type{IndZero}) = true

function prox!(y, ::IndZero, x, gamma)
    R = real(eltype(x))
    y .= R(0)
    return R(0)
end

"""
    ConvexConjugate(f)

Constructs the convex conjugate of the function `f`. The convex conjugate of a function `f` is defined as
    `f*(y) = sup_x {<x, y> - f(x)}`.
"""
struct ConvexConjugate{T}
    f::T
end

is_convex(::Type{<:ConvexConjugate}) = true
is_generalized_quadratic(::Type{ConvexConjugate{T}}) where T = is_generalized_quadratic(T)

function prox_conjugate!(y, u, f, x, gamma)
    u .= x ./ gamma
    v = prox!(y, f, u, 1 / gamma)
    v = real(dot(x, y)) - gamma * real(dot(y, y)) - v
    y .= x .- gamma .* y
    return v
end

prox_conjugate!(y, f, x, gamma) = prox_conjugate!(y, similar(x), f, x, gamma)

prox!(y, g::ConvexConjugate, x, gamma) = prox_conjugate!(y, g.f, x, gamma)

convex_conjugate(f) = ConvexConjugate(f)
convex_conjugate(::Zero) = IndZero()
convex_conjugate(::IndZero) = Zero()
