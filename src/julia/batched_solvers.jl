module Solvers

# Thomas algorithm for symmetric tridiagonal problem
# Forward sweep can be in increasing order (flip_solve=false) or decreasing order.

Thomas!(x, A, B, R, flip_solve) = flip_solve ? Thomas_flip!(x,A,B,R) : Thomas_noflip!(x,A,B,R)

function Thomas_noflip!(x, A, B, R)
    # Thomas algorithm for symmetric tridiagonal system
    Nz = size(A, 3)
    C, D = similar(A), similar(B) # FIXME
    # Forward sweep
    let l = 1
        for i in axes(A,1), j in axes(A,2)
            X = inv(B[i,j,l])
            C[i,j,l] = -A[i,j,l] * X
            D[i,j,l] = R[i,j,l] * X
        end
    end
    for l in 2:Nz
        for i in axes(A,1), j in axes(A,2)
           X = inv(B[i,j,l] + A[i,j,l - 1] * C[i,j,l - 1])
           D[i,j,l] = (R[i,j,l] + A[i,j,l - 1] * D[i,j,l - 1]) * X
           C[i,j,l] = -A[i,j,l] * X
        end
    end
    let l = Nz + 1
        for i in axes(A,1), j in axes(A,2)
            X = inv(B[i,j,l] + A[i,j,l - 1] * C[i,j,l - 1])
            D[i,j,l] = (R[i,j,l] + A[i,j,l - 1] * D[i,j,l - 1]) * X
        end
    end
    # Back-substitution
    for i in axes(A,1), j in axes(A,2)
        x[i,j,Nz + 1] = D[i,j,Nz + 1]
    end
    for l in Nz:-1:1
        for i in axes(A,1), j in axes(A,2)
            x[i,j,l] = D[i,j,l] - C[i,j,l] * x[i,j,l + 1]
        end
    end
    return nothing
end

end # module
