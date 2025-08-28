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





Sample averaging方法有一个问题。

我们设想老虎机的reward distribution是stationary的。也就是说它的奖励概率分布是不变的。但现实中，这是不确定的。万一老板哪天就想要调整一下概率分布呢？这时，我们基于sample average的方法，greedy和𝜺-greedy，是否就无法再应用？
显然，我们希望最近获得的reward对于我们调整estimate起到更大的作用。这个问题称作: tracking a nonstationary problem。
首先，有一个概念用于计算estimate的更新，incremental updating rule: NewEstimate <- OldEstimate + StepSize[Target - OldEstimate]. 这里Target-OldEstimate也称作error。在sample average里step size为1/k，k表示当前的time step。可见，在sample averaging方法下，越到后面，step size越小，就需要越大的reward值才能对OldEstimate产生可观的更新作用。即使老板最近调整了机器，由于我们的estimate更依赖于历史，无法即时反应出老板的这个操作带来的影响。解决这个问题是不让step size随时间推移变小，用constant step size.

根据the law of large number，sample-average method会收敛到真实均值。然而当distribution不是stationary时，sample-average就行不通了。我们需要即时更新，以跟上distribution的变化。通过调整step size可以确保这一点。constant step size的效果是exponential recency-weighted average.
但是，假如underlying distribution确实是stationary的话，constant step size反而效果不好，会造成不必要的方差，这个方差也是可以计算出来的。但如果underlying distribution是non-stationary的话，sample-average又会导致estimate跟不上distribution变化的速度。

ERWA: exponential recency-weighted average放弃了“精确收敛”，换来了“快速适应”。



什么是weighted average？

ERWA展开递归，得到一个加权平均。加权平均的特点是权重之和为1。加权的内容是初始estimate和各个time step对应的reward。constant step size的效果：历史reward会随着时间推移，用越来越小的比重去影响estimate。如果constant step size为1，则会使历史reward对当前estimate无任何影响：Q = R，得到的极限快速适应。



stochastic approximation（SA） theory研究的是什么问题？

SA研究的是随机采样逼近某个目标的收敛问题。这里的incremental updating rule是一个迭代算法，也是随机采样为了逼近真实值的过程。
为了收敛，step size要满足怎样的条件？sample average的step size = 1/k是随着k变小的，它最终收敛到了真实值。constant step size显然是不收敛的。除了1/k和constant step size，step size还有很多变化的可能。所以数学家研究怎样的step size sequence才能达到收敛的效果。

两个针对步长的确保收敛的条件应该怎么理解？

在合适步长条件下（两个确保收敛的conditions），Q-Learning收敛到最优Q值。即Robbins–Monro 定理。这是什么意思？

什么是Robbins–Monro 定理？

他提出Stochastic Approximation（随机逼近）方法。他讲的是如何用随机样本逼近一个未知参数。他提出一个迭代公式，并且给出两个使之收敛的条件。迭代公式包含了步长和带噪音的观测。这一点和incremental update rule其实是一致的。实际上incremental update rule可以写成Robbins-Monro给出的迭代公式形式，它是Robbins-Monro的一个特例而已。所以结论中的两个使之收敛的条件适用于incremental update rule。（🎈补充证明过程）


证明sample average满足两个确保收敛的条件？

第一个条件：分组 (1) + (1/2) + (1/3 + 1/4) + (1/5+1/6+1/7+1/8) ... 这样的组有无穷多个，而每一个组都 >= 1/2，所以这些组之和为无穷大。
自然数平方->倒数->求和，结果是什么？
欧拉解决了这个问题（Basel problem），结果是𝛑 * 𝛑 / 6。所以sample average同时满足了两个conditions，从而我们在两个角度都验证了sample average的收敛性。但是constant step size只满足condition 1，不满足condition 2，所以它不是收敛的。constant step size本身也不应该应用在stationary distribution上，所以它是否收敛并不重要。它的核心是保持对新鲜数据的敏感性。“constant step size方法关注的是适应性而非精确收敛，因此在stationary环境下收敛并非评价它优劣的标准”。

sample average，constant step size，greedy，𝜺-greedy各自影响的是什么？

sample average和constant step size影响的是收敛、适应性，它们对动作决策没有影响。greedy和𝜺-greedy才是影响动作策略的因素，它们影响exploitation和exploration的均衡问题。动作并没有反映在incremental update rule迭代公式上。𝜺为0时，就退化为greedy算法了。

Q值是什么？

在incremental update rule里，Q值表示的是对一个动作的估值。后续研究到full reinforcement learning问题时，状态就不像n-armed bandit问题里的这么简单了。之后研究的Q是特定状态下的特定动作的估值。为什么用Q这个符号？Q表示quality，表示状态-动作对的质量。而V者表示状态的价值。

V值可以看作 Q值对动作的边际（加权平均或最大值）？

加权平均容易理解，但最大值是为什么？一个状态的价值，取决于采取的策略。如果采取最优策略（相当于最优动作的概率为1），那么这个状态的价值就等于在这个状态下，选择最优动作的价值。否则，在一般策略下（概率选择动作），状态的价值就是动作价值的加权平均。对动作的边际意思就是对动作积分或者求和，把动作这个变量消灭掉。

Initial action values对这些算法的影响是什么？

initial action values可能是低估值或者高估值。算法的分类由策略/更新方法决定如
- greedy + sample average
- greedy + constant
- 𝜺-greedy + sample average
- 𝜺-greedy + constant

通过分类讨论，总共有8种情形。讨论greedy + 高估值。无论是sample average还是constant，第一次action后，Q2(a) < Q1(a)，所以会探索其它action。因此每一个action被探索到的概率不小。𝜺-greedy会探索更多，因此，高估值有助于探索。考虑低估值。很有可能在第一次action之后，Q2(a) > Q1(a)，在这之后，greedy都会困在这个action中，不再探索。而𝜺-greedy还是有机会继续探索。因此，无论什么情形，高估值都是有利于探索的。虽然高估值在开始阶段可能性能不好，但它随着探索的增加，会表现得更好。使用高估值的方法有一个术语：optimistic initial values。对于stationary分布来说，这个技术是有效的。但现实的RL问题往往是non-stationary的。stationary往往只存在于理论研究。


stationary情况下可以用optimistic initial values，那么non-stationary呢？

首先，为什么说optimistic initial values不适合non-stationary情况呢？optimistic initial values技术探索的动机是暂时的，一旦各个action的estimates都收敛了，然后突然改变其中一些distribution也不会再引起探索了。non-stationary需要的适应性是持久而非暂时的。因此，任何通过调整初始估值的方法都只会影响暂时的探索，无法做到持久的探索。随着时间推移，开始是什么状态和价值已经不重要了。而sample average还在强调初始值的影响，这是与现实背道而驰的。sample average 方法实隐含了所有历史数据同等重要。在非平稳环境下，环境已经变了，但是估计还在收历史影响，导致僵化。constant step size则会让历史数据的影响以指数衰减的方式变化。为了更持久的适应性，我们应该怎么调整探索策略呢？

什么是Upper-Confidence-Bound？

