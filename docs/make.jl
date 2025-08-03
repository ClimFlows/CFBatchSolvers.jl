using CFBatchSolvers
using Documenter

DocMeta.setdocmeta!(CFBatchSolvers, :DocTestSetup, :(using CFBatchSolvers); recursive=true)

makedocs(;
    modules=[CFBatchSolvers],
    authors="Thomas Dubos <thomas.dubos@polytechnique.edu> and contributors",
    sitename="CFBatchSolvers.jl",
    format=Documenter.HTML(;
        canonical="https://dubosipsl.github.io/CFBatchSolvers.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/dubosipsl/CFBatchSolvers.jl",
    devbranch="main",
)
