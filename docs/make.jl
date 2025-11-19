using Documenter
using ProximalCore

makedocs(
    sitename = "ProximalCore.jl",
    format = Documenter.HTML(),
    modules = [ProximalCore],
    pages = [
        "Home" => "index.md",
        "API Reference" => "api.md"
    ]
)

#=deploydocs(
    repo = "github.com/JuliaFirstOrder/ProximalCore.jl",
    devbranch = "main"
)=#
