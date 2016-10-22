"""
Jukes and Cantor 1969 substitution model

Θ = []
or
Θ = [λ]
"""
type JC69 <: SubstitutionModel
  Θ::Vector{Float64}
  π::Vector{Float64}

  function JC69(Θ::Vector{Float64})
    if !(0 <= length(Θ) <= 1)
      error("Θ is not a valid length for JC69 model")
    elseif any(Θ .<= 0.)
      error("All elements of Θ must be positive")
    end

    π = [0.25
         0.25
         0.25
         0.25]

    new(Θ, π)
  end
end


JC69() = JC69(Float64[])


function show(io::IO, object::JC69)
  print(io, "\r\e[0m\e[1mJ\e[0mukes and \e[1mC\e[0mantor 19\e[1m69\e[0m substitution model")
end


function Q(jc69::JC69)
  if length(jc69.Θ) == 1
    λ = jc69.Θ[1]
  else
    λ = 1.
  end

  return [[-3*λ λ λ λ]
          [λ -3*λ λ λ]
          [λ λ -3*λ λ]
          [λ λ λ -3*λ]]
end


function P(jc69::JC69, t::Float64)
  if t < 0
    error("Time must be positive")
  end
  if length(jc69.Θ) == 1
    λ = jc69.Θ[1]
  else
    λ = 1.
  end

  P_0 = 0.25 + 0.75 * exp(-t * λ * 4)
  P_1 = 0.25 - 0.25 * exp(-t * λ * 4)

  return [[P_0 P_1 P_1 P_1]
          [P_1 P_0 P_1 P_1]
          [P_1 P_1 P_0 P_1]
          [P_1 P_1 P_1 P_0]]
end


"""
Generate a `SubstitutionModel` proposal using the multivariate normal
distribution as the transition kernel, with a previous set of
`SubstitutionModel` parameters as the mean vector and a transition kernel
variance as the variance-covariance matrix
"""
function propose(currentstate::JC69,
                 transition_kernel_variance::Array{Float64, 2})
  if length(currentstate.Θ) == 1
    return JC69(rand(MvNormal(currentstate.Θ, transition_kernel_variance)))
  else
    return JC69()
  end
end
