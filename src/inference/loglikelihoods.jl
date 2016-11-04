"""
Log likelihood for a pair of sequences being a certain distance apart, under a
specified substitution model
"""
function loglikelihood(seq1::Sequence,
                       seq2::Sequence,
                       distance::Float64,
                       mod::SubstitutionModel,
                       site_rates::Vector{Float64})
  if length(seq1) !== length(seq2)
    error("Sequences must be of the same length")
  end
  ll = 0.
  pmat = P(mod, distance)
  for i = 1:length(seq1)
    ll += log(pmat[seq1.nucleotides[:, i], seq2.nucleotides[:, i]][1])
  end
  return ll
end


function loglikelihood(seq1::Sequence,
                       seq2::Sequence,
                       distance::Float64,
                       mod::SubstitutionModel)
  return loglikelihood(seq1,
                       seq2,
                       distance,
                       mod,
                       fill(1., length(seq1)))
end


"""
Calculates the log likelihood of a tree with sequences observed at all leaves
"""
function loglikelihood(seq::Vector{Sequence},
                       tree::Tree,
                       mod::SubstitutionModel,
                       site_rates::Vector{Float64})
  seq_length = length(site_rates)
  leaves = findleaves(tree)
  if length(leaves) !== length(seq)
    error("Number of leaves and number of observed sequences do not match")
  end
  visit_order = postorder(tree)
  ll_seq = fill(0., (4, seq_length, length(tree.nodes)))
  leafindex = 0
  for i in visit_order
    if isleaf(tree.nodes[i])
      leafindex += 1
      ll_seq[:, :, i] = log(seq[leafindex].nucleotides)
    else
      branches = tree.nodes[i].out
      for j in branches
        branch_length = get(tree.branches[j].length)
        child_node = tree.branches[j].target
        for k in 1:seq_length
          ll_seq[:, k, i] += log(exp(ll_seq[:, k, child_node])' * P(mod, branch_length * site_rates[k]))[:]
        end
      end
    end
  end
  return sum(ll_seq[:, :, visit_order[end]])
end


function loglikelihood(seq::Vector{Sequence},
                       tree::Tree,
                       mod::SubstitutionModel)
  return loglikelihood(seq,
                       tree,
                       mod,
                       fill(1., size(seq[1].nucleotides, 2)))
end
