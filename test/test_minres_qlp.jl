function test_minres_qlp()
  minres_qlp_tol = 1.0e-6

  # Cubic spline matrix.
  A, b = symmetric_definite()
  (x, stats) = minres_qlp(A, b)
  r = b - A * x
  resid = norm(r) / norm(b)
  @printf("MINRES-QLP: Relative residual: %8.1e\n", resid)
  @test(resid ≤ minres_qlp_tol)
  @test(stats.solved)

  # Symmetric indefinite variant.
  A, b = symmetric_indefinite()
  (x, stats) = minres_qlp(A, b)
  r = b - A * x
  resid = norm(r) / norm(b)
  @printf("MINRES-QLP: Relative residual: %8.1e\n", resid)
  @test(resid ≤ minres_qlp_tol)
  @test(stats.solved)

  # Code coverage.
  (x, stats) = minres_qlp(Matrix(A), b)
  show(stats)

  # Sparse Laplacian.
  A, b = sparse_laplacian()
  (x, stats) = minres_qlp(A, b)
  r = b - A * x
  resid = norm(r) / norm(b)
  @printf("MINRES-QLP: Relative residual: %8.1e\n", resid)
  @test(resid ≤ minres_qlp_tol)
  @test(stats.solved)

  # Symmetric indefinite variant, almost singular.
  A, b = almost_singular()
  (x, stats) = minres_qlp(A, b)
  r = b - A * x
  resid = norm(r) / norm(b)
  @printf("MINRES-QLP: Relative residual: %8.1e\n", resid)
  @test(resid ≤ minres_qlp_tol)
  @test(stats.solved)

  # Test b == 0
  A, b = zero_rhs()
  (x, stats) = minres_qlp(A, b)
  @test x == zeros(size(A,1))
  @test stats.status == "x = 0 is a zero-residual solution"

  # Test integer values
  A, b = square_int()
  (x, stats) = minres_qlp(A, b)
  @test stats.solved
end

test_minres_qlp()
