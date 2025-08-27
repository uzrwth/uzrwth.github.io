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

引入了𝜺，我们想要知道𝜺=0.1效果好不好。应该怎么评测？

仿真。这种测试有一个专门术语: 10-armed testbed.
在一个standard normal distribution中 sample 10个值，作为这10个老虎机的真实reward mean。生成每次reward为该action对应的老虎机的真实reward mean + 一个normal distributed noise. 绘制greedy和near-greedy方法的对比图。
在这样的设定下，我们是知道最优老虎机的。所以可以评估做1000次选择中，greedy和near-greedy方法各自的命中率与对应的average reward。无论greedy还是near-greedy方法，我们都要考虑一个初始化的问题。如果初始化所有estimates为0，那就形成了ties，这样不利于test的进行。为了打破这些ties，我们可以初始化是给所有老虎机一个random estimate。在课本里我们看到的效果是，在这1000次的action选择中，一开始是greedy method领跑，但很快它就开始落后了，包括命中率和average reward。现在我们学到了action-value method，一种balance exploration和exploitation的方法。除此之外，还有什么方法？


关于10-armed testbed。

有几个数字: 0.1, 0.01, 1000, 2000, 0, 1, 10. 1000 time steps, 2000次实验，mean为0，方差为1，actions数为10，0.1和0.01是𝜺。
为什么说0.01的表现更好？从图上来看，在1000 time steps之内，0.01并没有超越0.1的表现。但是从趋势来看，随着time steps的增大，0.01的表现最终是会超越0.1的表现的。这里说的表现，包括了average reward和optimal action的比率。
图表中神奇的1.55是如何获得的：
- 每次从标准正态分布采样 10 个值。
- 选出这 10 个值的最大值。
- 重复 2000 次，收集所有最大值。
- 计算这 2000 个最大值的均值。

无论time step是1次还是1000次，我们期望的是发现真实的reward distribution mean，然后持续地exploit这个老虎机。这是最优的策略，这种做法用python程序仿真后，计算得到1.55左右。
这正好说明𝜺-greedy正在逼近最优策略。而greedy得到的效果是1 per action。



greedy得到的1 per action和one third optimal action是怎么得到的？

这个概率，应该是在当前time steps中，我们实际选中了最优老虎机的概率。然后做了2000次实验，算出的平均值（每个time step下都有一个平均值）。这个1 per action，以及上面的1.55，虽然仿真算出来了，但我并不明白。






