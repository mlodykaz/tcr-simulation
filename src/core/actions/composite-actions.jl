
function challenge(rng, registry, agents, deposit, voteFunc, redistributionFunc)
    if (length(registry) >= 10)
        challenger = agents[rand(rng, 1:end)]
        evaluations = evaluateCandidateByAgent.(registry, challenger)
        challengedIndex = indmin(evaluations);
        challengedValue = evaluations[challengedIndex]

        # if (min < mean(registry))
            challenger.balance -= deposit

            votingResult = voteFunc(registry, registryMean(registry), challengedValue, agents)
            if (!votingResult[1])
                deleteat!(registry, challengedIndex)
            end
            redistributionFunc(votingResult, challenger, deposit)
        # end
    end
end

function application(rng, registry, history, agents, voteFunc)
    candidate = getRegistryCandidate(rng)
    push!(history, candidate)
    # println("Candidate: $candidate")
    if voteFunc(registry, registryMean(registry), candidate, agents)[1]
        push!(registry, candidate);
    end
end