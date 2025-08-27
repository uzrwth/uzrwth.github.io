---
title: "Reinforcement Learning"
date: 2025-08-27T13:41:59+02:00
---

什么是n-armed bandit problem?

bandit是土匪。去游乐场玩，就是去让土匪抢我们的钱，所以老虎机也叫bandit。
一个老虎机 （slot machine）是一个arm，n个老虎机就是n-armed bandit。每个老虎机有自己的reward distribution。我们对每个老虎机都有一个estimate，这个estimate是根据以往经验得到的。进入游乐场我们可以选择玩其中一个老虎机。通常我们会玩estimate最高回报的那个老虎机。但是我们的estimate并不是真实的reward distribution，所以我们也要给机会玩estimate不那么好的老虎机，然后通过新的经验，更新estimate,说不定会得到惊喜。

为什么研究n-armed bandit?

为了慢慢去接近现实中的RL问题。现实中，我们做完一个决定之后，就会去到新的situation，会面临不同的选择，然后我们继续做决定。游乐场老虎机的设定下，问题简化，我们做完决定之后（选择玩哪个老虎机），我们依然在游乐场，situation没有变化，我们仍然面临选择玩哪个老虎机的问题。但在现实中，情况更复杂，当我们玩了一次老虎机之后，我们可能决定再玩一次，可能玩同一个老虎机也可能玩其它老虎机。我们也可能决定玩其他博彩设备。也可能决定不玩了回家。因此，通过研究n-armed bandit，我们可以不用一上来就分析复杂的现实情形，从简单的情形入手，看下我们能学到什么。


能学到什么？

虽然探索有助于更新estimate，从而找到最好的老虎机。但是我们应该逐个玩一次吗？即使所有老虎机都玩一次，也还是无法得到真实的reward distribution，而我们的每一次操作都是把即时奖励累计到最终奖励的，那我们应该用什么策略来操作？其实这就是一个balancing问题。我们是选择一直exploit，还是偶尔explore一下。在这里我们要解决两个问题：1. 怎么量化和更新动作价值。2. 在某个time step下，我们应该exploit还是explore？对于第一点，最简单的方法是sample average。当sample足够大时，由大数定理，average会收敛到真实reward distribution的mean。对于第二点，最简单的方法是greedy。一直选择estimate最好的老虎机，再更新。当这个estimate不如其他老虎机时，就greedy到其他的estimate最好的老虎机。但这个方法有一个问题是，当所有老虎机都初始化estimate为0时，我们选中其中一个作为开始，然后它的estimate就会更新为大于0的数值，以后它会被一直选中，estimate的更新也会一直保持为大于0的数值。这意味着其它老虎机没有一点机会。𝜺-greedy解决了这个问题。它也被称为near-greedy。𝜺是一个small probability。当它发生时，我们不考虑任何estimate，而是随机选择一个老虎机。当它没有发生时，我们保持greedy。near-greedy的好处是当time steps无穷大时，所有老虎机的estimate都会收敛到真实reward distribution的mean。



