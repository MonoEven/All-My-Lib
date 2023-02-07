#Include <numahk\numahk>

np := numahk

class Bandit
{
    hyperparameters := map()
    
    __new(rewards, reward_probs, context := "")
    {
        assert len(rewards) = len(reward_probs)
        this.step := 0
        this.n_arms := len(rewards)
    }
    
    _pull(arm_id, context)
    {
        
    }
    
    tostring()
    {
        HP := this.hyperparameters
        params := ", ".join(oneloop(format.bind("{}={}"), HP.items(), 2, _(k, v) => k != "id"))
        return "{}({})".format(HP["id"], params)
    }

    pull(arm_id, context := "")
    {
        assert arm_id < this.n_arms
        this.step += 1
        return this._pull(arm_id, context)
    }
    
    reset()
    {
        this.step := 0
    }
}

class MultinomialBandit Extends Bandit
{
    __new(payoffs, payoff_probs)
    {
        super.__new(payoffs, payoff_probs)
        for r, rp in zip(payoffs, payoff_probs)
        {
            assert len(r) == len(rp)
            np.testing.assert_almost_equal(sum(rp), 1.0)
        }
        payoffs := np.array(oneloop(np.ndarray, payoffs))
        payoff_probs := np.array(oneloop(np.ndarray, payoff_probs))
        this.payoffs := payoffs
        this.payoff_probs := payoff_probs
        this.arm_evs := np.array(_(p, v) => sum(p * v), zip(payoff_probs, payoffs), 2)
        this.best_ev := np.max(this.arm_evs)
        this.best_arm := np.argmax(this.arm_evs)
        this.hyperparameters := map("id", "MultinomialBandit",
                                                        "payoffs", this.payoffs,
                                                        "payoff_probs", this.payoff_probs)
    }
    
    oracle_payoff(context := "")
    {
        return [this.best_ev, this.best_arm]
    }
    
    _pull(arm_id, context)
    {
        payoffs := this.payoffs[arm_id]
        probs := this.payoff_probs[arm_id]
        return np.random.choice(payoffs, , , probs)
    }
}

class BernoulliBandit Extends Bandit
{
    
}