"""
    gradient!(y, f, x)

In-place gradient (and value) of `f` at `x`.

The gradient is written to the (pre-allocated) array `y`, which should have the same shape/size as `x`.

Returns the value `f` at `x`.

See also: [`gradient`](@ref).
"""
gradient!

"""
    gradient(f, x)

Gradient (and value) of `f` at `x`.

Return a tuple `(y, fx)` consisting of
- `y`: the gradient of `f` at `x`
- `fx`: the value of `f` at `x`

See also: [`gradient!`](@ref).
"""
function gradient(f, x)
    y = similar(x)
    fx = gradient!(y, f, x)
    return y, fx
end

"""
    prox!(y, f, x, gamma=1)

In-place proximal mapping for `f`, evaluated at `x`, with stepsize `gamma`.

The proximal mapping is defined as
```math
\\mathrm{prox}_{\\gamma f}(x) = \\arg\\min_z \\left\\{ f(z) + \\tfrac{1}{2\\gamma}\\|z-x\\|^2 \\right\\}.
```
The result is written to the (pre-allocated) array `y`, which should have the same shape/size as `x`.

Returns the value of `f` at `y`.

See also: [`prox`](@ref).
"""
prox!

prox!(y, f, x) = prox!(y, f, x, 1)

"""
    prox(f, x, gamma=1)

Proximal mapping for `f`, evaluated at `x`, with stepsize `gamma`.

The proximal mapping is defined as
```math
\\mathrm{prox}_{\\gamma f}(x) = \\arg\\min_z \\left\\{ f(z) + \\tfrac{1}{2\\gamma}\\|z-x\\|^2 \\right\\}.
```

Returns a tuple `(y, fy)` consisting of
- `y`: the output of the proximal mapping of `f` at `x` with stepsize `gamma`
- `fy`: the value of `f` at `y`

See also: [`prox!`](@ref).
"""
function prox(f, x, gamma=1)
    y = similar(x)
    fy = prox!(y, f, x, gamma)
    return y, fy
end
