
"""
Void placeholder communicating that there is no redistribution happening
"""
function noneRedistribution(votingResult, challenger, deposit,dispensation_pct)

end

"""
Redistribution model when only the challenger receives the reward
in the form of the initial applicant deposit and the challenge fee
both being the same amount
"""
function onlyChallengerRewardRedistribution(result, challenger, deposit,dispensation_pct)
    if (!result[1])
        challenger.balance += 2 * deposit
    end
end

"""
Redistribution model when the challenger is rewarded and all who voted
against him are punished according to the dispensation parameter who defines severity
"""
function punishmentRedistribution(result, challenger, deposit, dispensation_pct)
    if (!result[1])
        challenger.balance += (2+dispensation_pct) * deposit
        foreach(agent -> agent.balance -= dispensation_pct*deposit / length(result[2]), result[2])
    end
end

"""
Redistribution model when all of voters who supported him are rewarded
"""
function rewardRedistribution(result, challenger, deposit,dispensation_pct)
    if (!result[1])
        challenger.balance += (1+dispensation_pct)*deposit
        foreach(agent -> agent.balance += (1-dispensation_pct)*deposit / length(result[3]), result[3])
    end
end

"""
Redistribution model when both the challenger is rewarded and voters who supported
him are rewarded and all who voted against him are punished
"""
function punishmentAndRewardRedistribution(result, challenger, deposit,dispensation_pct)
    if (!result[1])
        challenger.balance += 2* deposit
        foreach(agent -> agent.balance -= deposit / length(result[2]), result[2])
        foreach(agent -> agent.balance += deposit / length(result[3]), result[3])
    end
end

"""
Redistribution model when both the challenger is rewarded with his deposit and dispensation percantage and his supporters are rewarded with a deposit
and the remains of the dispensation.
"""

function punishmentAndRewardRedistributionDispensation(result, challenger, deposit,dispensation_pct)
    if (!result[1])
        challenger.balance += (1+dispensation_pct)* deposit
        foreach(agent -> agent.balance -= deposit / length(result[2]), result[2])
        foreach(agent -> agent.balance += (2-dispensation_pct)*deposit / length(result[3]), result[3])
    end
end
