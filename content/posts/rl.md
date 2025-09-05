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

Upper confidence bound和𝜺-greedy一样，是一种策略。由于𝜺-greedy是无差别随机，它的效果往往不如Upper confidence bound（通过计算average reward来比较两种方法的表现）。Upper confidence bound是一个更细化的随机策略。Upper confidence bound方法倾向于优先尝试估值高或者采样次数少的action。估值和采样次数两者看似使用不同的计数单位，无法糅合为一个指标。但是通过概率统计里的置信区间方法，可以把两者糅合，得到一个在给定置信等级（confidence level）下的区间。
non-stationary环境下，optimistic initial values仅仅停留在初始阶段的探索，为了增加探索，我们使用𝜺-greedy。但是𝜺仅仅是一个概率，当它发生之后我们放弃greedy action，从non-greedy actions中选择一个来执行。那么这种选择是否有讲究呢？显然由于这些non-greedy actions的estimate各自不同，我们应该有一定的倾向性。比如有的non-greedy action的estimate比较优秀，那是否优先考虑随机到使用它呢？另外地，各个action都有自己的统计信息，我们是可以知道一个action当前的estimate值以及它的样本方差的。如何利用这些信息是我们需要研究的。
我们需要一个数学表达式把三个要素（action的estimate，action被采样了多少次，当前的time step）结合在一起，然后输出一个action使得这个表达式的值最大。被采样的次数应该作为分母，这样未被探索过的action具有无穷大的优先级。action的estimate越大，该表达式的值也应该越大，这是greedy策略。为什么time step也要放进表达式里？我们要考虑这三个要素用的是不同的单位，如何衡量各自在这个表达式里的地位是关键。考虑到每个action的estimate其实是符合某个正态分布的，于是，有置信区间的概念。这个区间和样本方差有关。而time step和该action被采样次数两个信息可以算出样本方差。取根后得到标准差。
各自action的采样数不同，也就导致同样的置信下，各自的区间不一样。计算中有一个参数决定confidence level。Upper Confidence Bound在于根据眼前信息，通过统计概率手段，找出潜力最大的action。upper bound指的是action可能的真值上界。
虽然Upper confidence bound往往比𝜺-greedy性能更好，但是它适应的设定更严格，扩展性不好。置信区间上界项。"Upper Confidence Bound (UCB) 算法经典版本主要是针对 stationary（平稳）环境 的。" 另外地，UCB也不适合large state space。设想状态空间很大的情况下，UCB需要为每一个状态-动作对保存对应的统计信息，也就是tabular的方法，是不可行的。所以就需要用function approximation来解决这个问题。function approximation的思想是不用存储统计信息，而是用一个参数化模型近似表示价值函数（V）或策略函数（Q）。UCB：选“上置信界”最大的动作。

为什么平时学的方法里要包含discount？

平时学的方法是应用在非平稳环境（现实中基本上都是非平稳的），upper confidence bound只适合平稳环境。upper confidence bound的扩展：sliding-window/discounted UCB则适合非平稳环境。
discounted UCB里的discount是为了应对非平稳环境的。但是RL里的折扣因子并不是为了非平稳设计的，它是问题建模需要。我们目前学到的方法里，考虑的单次选择回报都是即时回报，这回报不会对以后有任何影响。但是实际问题中，单次选择可能在日后会产生更大的作用，因此在未来它是有回报的。折扣因子可以表达我们是更关注眼前奖励还是长期奖励。“想让 RL 算法重视布局棋这类延迟效果，就要把 γ 设得接近 1，甚至等于 1。”

_function approximation？_




什么是gradient bandit？

Gradient bandit是一种基于策略梯度（policy gradient）的bandit算法。Gradient bandit使用H表示偏好（hint from "preference/heuristic"），区分于V和Q。H(a)通过softmax可以转换为概率，从而得到Pr(a)。这样每个动作都有自己的概率被选中。所有动作的概率之和为1。

怎么更新偏好H？

Gradient bandit中，学习的核心是偏好H(a)。

什么是natural learning algorithm？

natural指的是natural gradient。考虑参数空间的几何结构，沿着“最自然的方向”更新策略。


gradient bandit包含了偏好迭代和概率转换，它和gradient有什么联系？

gradient bandit包含了两部分：偏好迭代（preference update）和概率转换（softmax）。为了解答这个问题，先问一个问题，偏好迭代的这个公式是怎么得到的？知道这个公式的来源，就明白了为什么这个算法要叫做gradient bandit了。更新公式和incremental update rule相似。由之前的偏好，这次选中action得到的奖励，step size，奖励均值，softmax算得的该动作概率，这几个因素一起计算出各个动作的最新偏好。基本思想是：以历史平均奖励作为基准，如果这次的选择带来了比基准高的收益，那么这个动作的偏好增加。增加多少？取决于step size和选择它的概率。那么这个逻辑是怎么和gradient扯上关系的？

gradient bandit为什么是stochastic gradient ascent？

exact gradient ascent需要知道q(b)。但是在期望上，gradient bandit更新偏好是等价于exact gradient ascent的更新的，所以称之为stochastic gradient ascent。我们可以把exact gradient ascent的表达式和gradient bandit的表达式放在一起，然后验证在期望下，两者相等。ascent或者descent指的是更新方向。这两个词的出现，应该能让你联想到它们表示某个迭代公式。那么什么是exact gradient ascent？假设我们明确知道一个几何结构，从某一点出发，我们总能找到上升或者下降最快的方向，从而以最快的速度优化到最大或最小值。这里的最快的方向，说的是natural方向。但是exact gradient ascent中的exact又是什么意思？stochastic gradient ascent （SGA）是不知道这个几何结构的，它只能通过采样估计梯度，存在噪声。但是如果明确知道这个几何结构，那么在任何一个点上，都能准确地计算出该点的梯度，也就是说梯度是精确值，没有噪声。

exact gradient ascent？

$H(a) \gets H(a) + \alpha \frac{\partial \mathbb{E}[R]}{\partial H(a)}$

$\mathbb{E}[R] = \sum \pi(b) q(b)$ 这里用小写q，表示真实动作价值。大写Q表示estimate。$H(a)$会影响$\pi$，从而影响期望奖励变化。这里的偏导表示的就是期望奖励随动作偏好$H(a)$的变化关系。如果考虑所有动作，那么这里就把偏导换成梯度。这里需要知道真实动作价值，即每个老虎机的奖励分布。现实中，我们并不知道。所以才有了stochastic gradient ascent的做法，用采样去毕竟梯度。

---

为什么the expected update of the gradient-bandit algorithm is equal to the gradient of expected reward？

$\Delta H(k) = H_{t+1}(k) - H_t(k)$

$\mathbb{E}[\Delta H(k)] = ?$

我们要证明算法的期望更新等于期望奖励函数的梯度。

要证明这一点，需要知道softmax的梯度，以及，baseline不影响梯度（它的期望更新为0）

---


natural gradient和普通gradient的区别？

普通gradient假设参数空间是欧几里得空间。自然梯度考虑参数空间的流形几何。

梯度的几何意义？

梯度向量不仅是各偏导的集合。它告诉你整体最陡的上升方向。梯度等于0表示达到了极值。梯度的方向表示上升最快的方向，梯度的大小表示沿这个方向上升的速度。

为什么不贪心地选择偏好最大的action，而要用softmax转换为概率？

选择H最大的action在短期收益大，但是缺乏探索，可能错过长期更优动作。

什么是soft-max distribution？

Gibbs、Boltzmann distribution.


什么是nonassociative和associative task？

nonassociative指的是动作不需要关联situation。n-armed bandit是单状态的，所以不存在状态-动作对的说法。复杂的RL方法则要考虑动作和状态的关联，称为associative task。task可以是stationary或non-stationary的。stationary下，需要寻找最优action。non-stationary下，则需要跟踪最优action（as it changes over time）。



gradient bandit，policy gradient，natural gradient，exact gradient ascent？

gradient bandit是策略梯度（policy gradient）思想的起点。policy gradient是gradient bandit的自然扩展（对于完整MDP/有状态问题的扩展），gradient bandit解决的的是非完整RL的策略问题。bandit 问题没有状态转移，只关心每个动作的即时奖励。
gradient bandit被成为stochastic gradient ascent。H，H(a)，Ht(a)。H(a)不关心是preference属于哪个time step，in general地去讨论action a的preference。Ht(a)带有time step，关注特定时刻action a的preference，研究它的更新迭代。H，以一个整体作为目标函数的参数，H包含了所有动作、所有时刻的preference。J(H)是目标函数，表示期望奖励。我们希望使J(H)最大化。既然J(H)是一个期望，那么就有一个distribution与之对应。H影响这个distribution，从而影响J(H)。优化参数H，使J(H)最大化，这就是要做的事情。J(H)应该被写成对一个序列的求和，这个序列的每一项是概率乘以该概率对应的动作的期望奖励。就是说，按照策略H，有概率选择a1、a2等动作，这些动作各自的期望奖励，在加权平均之后，就是J(H)。J(H)表示的是策略性能的期望值。

如何理解这句话：each preference $H_t(a)$ would be incrementing proportional to the increment's effect on performance？

each preference would be incrementing proportional to：$H_{t+1}(a) - H_{t}(a)$ 和某个东西成比例。和the increment's effect on performance成比例。什么是increment's effect，什么是performance？这里performance是the expected reward。 proportional无非表示有一个比例step size，我们暂时不考虑。the increment's effect on performance则是自变量对performance产生的效果。
更新量 $\Delta H \propto \frac{\partial J(H)}{\partial H(a)}$

目标函数对动作a的偏好参数求偏导，表示什么意思？

表示动作a的偏好参数稍微调整，目标函数会变化多少。就是目标函数相对于动作函数的变化速度。换句话说，它就是 目标函数对动作偏好的敏感度。导数符号：$\frac{dy}{dx}$，偏导符号：$\frac{\partial f}{\partial x}$。导数符号用在一元函数（单变量函数）中，求导只有一种可能，就是因变量对自变量$x$求导。在多元函数中，偏导的因变量用$f$表示，指定对哪个自变量求导。偏导符号是为了区分导数符号。导数用$d$，表示differential。在exact gradient中，动作偏好迭代式中使用了偏导。期望奖励对动作偏好求偏导。迭代过程更新单个动作，因此仅对当前动作求偏导。如果对所有动作求偏导，那得到的是gradient。动作偏好的变化引起期望奖励的变化。期望奖励的变化受到所有动作偏好变化的影响，但是由于只考虑单个动作偏好的更新，所以仅对该动作求偏导。所得偏导代表了期望奖励在该动作偏好方向上的更新速度，因此自变量在迭代更新中变化的量应该与之proportional。proportional的程度在于step size。

怎么理解$\pi_\theta$？

$\pi$表示概率分布，也就是选择动作的概率（策略）。$\pi(a)$表示选中动作$a$的概率。$\theta$是参数。参数是我们要学习的内容。在gradient bandit中，参数就是$H$，我们要学习偏好。$\pi_\theta$表示策略依赖于参数偏好。

gradient ascent和gradient descent的区别？

gradient ascent用于最大化目标函数。gradient descent用于最小化目标函数。gradient bandit中学习H是为了最大化目标函数：期望奖励 J = E[R]。在RL中，用J表示期望回报（expected return），目标是最大化期望回报，更新方向是gradient ascent。在supervised learning中则用L（Loss）表示，目标是最小化损失函数，更新方向为gradient descent。

梯度上升和偏好迭代的关系？

梯度上升和偏好迭代更新公式是一致的，只不过前者考虑的是向量参数，而后者只是单个动作偏好。
现实中我们无法得知期望奖励的梯度，所以需要用采样的方式近似梯度。

如何求期望奖励的梯度？

期望奖励是一个求和式子。梯度的线性性，这相当于要对各个部分求梯度再求和。动作$a$的期望奖励为$R(a)$与动作偏好$\theta$或者$H$无关，因为参数是和策略相关的，策略一旦确定要执行的动作，奖励就再与策略无关。所以$\pi_\theta(a) * R(a)$求梯度就是$R(a) * \nabla_{\theta} \pi_{\theta}(a)$。用log-derivative trick可以把这个梯度变成$R(a) * \pi_\theta(a) * \nabla_\theta \log \pi_\theta(a)$。

梯度上升的采样形式每次更新参数都只是更新对应动作，而非所有动作？

是的。gradient bandit是stochastic gradient ascent方法。

$J(\theta) = \mathbb{E}_{a \sim \pi}[R(a)]$

$\nabla_\theta J(\theta) = \mathbb{E}_{a \sim \pi} [R(a) \nabla \log \pi (a)]$

$\hat{\nabla}_\theta J(\theta) = R(a)  \nabla \log \pi(a)$

$\hat{\nabla}_\theta J(\theta) \approx \frac{1}{N} \sum R(a_i) \nabla \log \pi(a_i)$

$\theta \gets \theta + \alpha \hat{\nabla}_\theta J(\theta)$

单样本更新：

$\theta \gets \theta + \alpha R(a) \nabla_\theta \log \pi_\theta(a)$

多样本平均更新：

$\theta \gets \theta + \frac{\alpha}{N} \sum_{i=1}^{N} R(a_i) \nabla_\theta \log \pi_\theta(a_i)$

可以引入基线baseline来减少方差。

$\theta \gets \theta + \alpha (R(a) - b) \nabla_\theta \log \pi_\theta(a)$

用采样奖励加权梯度 → 得到近似梯度。

沿梯度上升更新 $\theta$。

我知道梯度可以用于更新参数，但是为什么要用一个学习率去更新呢？怎么理解学习率$\alpha$？

小 $\alpha$ 可以防止梯度更新过猛，保证参数逐步靠近最优值。
梯度方向只是“上升最快的方向”，步长太大仍可能越过最优点或导致函数震荡。
学习率有两个作用：应对噪声和梯度更新本身收敛性需要。
如果已知真实梯度，理论上，可以选择直接沿梯度方向更新到最优点（假设凸函数和小步长条件满足）。
步长太大 → 一步跨越山顶，甚至滚下另一边。

什么是小步长条件？

小步长条件就是选择 $\alpha$ 使得二阶项足够小，不会抵消一阶增长，保证 $𝐽(\theta)$增加。和可二阶连续可微有关。

什么是二阶梯度？什么是Hessian？


怎么理解梯度是上升最快的方向？

梯度是一个向量。向量：大小和方向。


什么是SGD？

用近似梯度（采样）代替真实梯度，快速更新参数的一种通用方法。大量数据时，批量梯度下降计算代价高。SGD可以单样本或小批量，迭代快，适合在线学习（on-line）。使用于推荐系统。

---

容斥公式？

如果概率写成事件的交集或并集形式，可以考虑用容斥公式变换。如：

$P(A) + P(B) - P(A \cap B) = P(A \ cup B)$

$\sum P(A \cap B_i) = P(A \cap B_1) + P(A \cap B_2) + ...$

$P(A \cap B_1) + P(A \cap B_2) - P(A \cap B_1 \cap A \cap B_2) = P((A \cap B_1) \cup (A \cap B_2))$

如果$B_1 B_2$互斥，那么 $P(A \cap B_1 \cap A \cap B_2)$ 为0。
右边通过结合率可以写成：

$P(A \cap (B_1 \cup B_2))$， 如果已知 $\cup B_i = \Omega$，则$P(\Omega) = 1$。

差集：

$A \setminus B$ 表示属于A不属于B。


什么是Monotonicity of Probability Measures？

如果 $A \subseteq B$，那么$P(A) \leq P(B)$


证明 $P(\cup A_i) \leq \sum P(A_i) $：

定义 $\hat{A_i} := A_i \setminus \bigcup_{j=1}^{i-1} A_j $。注意$\hat{A_i}$的含义并非$A_i$和其他所有集合的差，而是与顺序排在它前面的差。

为什么 $P(\cup A_i) = P(\cup \hat{A_i})$ ？

右边求并集时，$\hat{A_1}$ 已经把 $A_1$的计算过。并上$\hat{A_2}$时，在原先基础上补充了$A_2$的新元素，并上$\hat{A_3}$时，并上$A_3$的新元素（新的意思是$A_3$中未出现在$A_1$和$A_2$的元素），这样一并下去得到的正好所$\cup A_i$。$\hat{A_i}$表示都是之前没有出现过的元素，所以$\hat{A_i}$之间互斥。

$P(\cup A_i) = P(\cup \hat{A_i})$，而$\hat{A_i}$各自disjoint，所以

$P(\cup A_i) = P(\cup \hat{A_i}) = \sum P(\hat{A_i})$

由于 $\hat{A_i} \subseteq A_i$，Monotonicity of Probability Measures得到，

$P(\cup A_i) = P(\cup \hat{A_i}) = \sum P(\hat{A_i}) \leq \sum P(A_i)$

为什么不用容斥公式证明以上结论？

因为容斥公式在多个集合时，后面的部分会有加有减，并不像只有两个集合时那样都是减。

$|A \cup B \cup C| = |A| + |B| + |C|- |A \cap B| - |A \cap C| - |B \cap C|+ |A \cap B \cap C|$

这个证明题考察了对差集和单调性的理解。

容斥公式有一个交替加减：

一个集合的和 - 二个集合交集所有组合的和 + 三个集合交集所有组合的和 - ...






---


Monte Carlo方法学习什么？

value functions和optimal policies。

什么是sample episodes？



Monte Carlo比DP的优势是什么？

DP需要完整的环境动态（environment dynamics）：转移概率和奖励函数，才能进行Bellman更新。


Monte Carlo是不需要环境模型吗？

是的，它基于采样。不依赖模型。它的作用是估计状态或状态-动作的价值。环境模型：1. 转移概率 （dynamics），2. 奖励函数。这两者都是不需要的。


什么是mean path TD-learning？

为什么说TD是RL最核心的思想？

TD和Monte Carlo、DP的关系？



---

为什么要用discount？

如果没有折扣，那么return被定义为

$G_t = R_{t+1} + R_{t+2} + ...$

目标是使$G_t$最大化。但是它已经是无穷大了，无解。结合现实来看，眼前的奖励比以后的奖励往往更重要，因为以后太多不确定性。加入折扣因子之后，表示未来的奖励没有那么重要。而且这也方便数学计算，$G_t$可以收敛。最大化问题才有意义。


什么是NPG？

Natural policy gradient method.


什么是feature mapping？




什么是off-policy TD(0)？

on-policy和off-policy的区别在于，on-policy不区分behavior和target policy。同一个policy，既用来estimate也用来control。


什么是Markov property？

在t+1时刻的奖励$R_{t+1}$和$S_{t+1}$只取决于在t时刻的状态和动作$A_t, S_t$。

什么是the environment's dynamics？（one-step dynamics of the environment）

$p(s',r|s,a)$ 等于

$Pr \{ R_{t+1} = r, S_{t+1} = s'|S_t,A_t \}$

p, P, Pr的区别？

p表示概率分布。上面定义the environment's dynamics是，左边是p，表示的是概率分布。

右边Pr表示计算。一般用$p(x) = Pr(X = x)$ 表示概率分布函数由右边定义。右边：随机变量等于特定值。

什么是MDP？

一个任务，如果满足Markov property，那它就是MDP。


policy的定义？

policy是一个mapping，$\pi(a|s)$，状态到动作的映射，映射出一个概率。

什么是value function？

value function，是在某个policy下，映射状态到expected return的函数。或者映射状态-动作对，到expected return的函数。
表示在一个状态下有多好，或者在一个状态下执行一个动作有多好。

能够获取多少expected return取决于policy，所以value function的定义是with respect to particular policies的。

$v_\pi(s)$表示从状态s开始，遵循policy $\pi$可以得到的expected return。

expected return 用$G_t$表示。

定义

$v_\pi(s)=\mathbb{E_\pi}[G_t|S_t=s]$

$G_t$无折扣定义如下：

$G_t = R_{t+1} + R_{t+2} + ...$

期望，定义上就是一个随机变量的期望。这里是对奖励这个随机变量的期望。前提是agent要遵循policy $\pi$。

terminal state的reward为0。$v_\pi$称作state-value function for policy $\pi$.

---

action-value function for policy $\pi$

$q_\pi(s,a)=\mathbb{E_\pi}[G_t|S_t=s, A_t=a]$

同样地，这个定义在计算时可以展开$G_t$变成一个求和表达式。

transition graph是理解dynamics of MDP的有用方法。分为两种节点：action nodes/state nodes。这个图可以用一个表格概况，
$s, s', a, p(s'|s,a), r(s,a,s'))$

这里

$p(s'|s,a)$: state-transition probabilities，计算方式 $\sum_r p(s',r|s,a)$. 在状态s下执行a动作之后，变成s'状态以及获得r奖励的概率，将r边际掉，就得到了状态转换概率。

如果要计算 $r(s,a)$，那么就把s'和r都边际掉，需要两个$\sum$.

$r(s,a,s')$，the expected rewards for state-action-next-state triples.

finite MDP中，finite的意思？

state和action spaces是有限的。

DP求解MDP value function？

在期望下，$R_{t+1}$可以进一步展开。

$v_\pi(s) = \mathbb{E}[G_t | S_t = s]$

$G_t = R_{t+1} + \gamma R_{t+2} + \gamma^2 R_{t+3} + ...$

最终会得到Bellman equation. 意义是：这是一个递推公式，DP的思路表达了value function在连续的两个前后的时间的期望奖励的关系。解Bellman equation有多种方式：approximate和learn $v_\pi$。

backup diagrams表示了更新操作。是RL中的核心内容。

optimal policy？

optimal policy就是policy space中使得$v_\pi(s)$对于任意状态都是最大的策略。表示为$\pi_{*}$


optimal value functions

optimal state-value function

$v_{*}(s) = \max_{\pi} v_{\pi}(s)$

optimal action-value function

$q_{*}(s,a) = \max_{\pi} v_{\pi}(s,a)$


什么是Bellman optimality equation？

由于已知所有environment dynamics，在求最优状态函数$v_{*}(s)$时，无需再探索。也就是策略$\pi(a|s)$不再需要用概率去求期望。而是已知最优$q_{*}$，把它的概率置1。

所有有 $v_{*}(s) = \max_{a} q_{\pi *}(s, a)$.

Bellman optimality equation实际是一系列函数。每个状态都有一个。
计算得到$v_{*}(s)$，就可以推导出$\pi_{*}$

tabular方法是针对状态数量很少，动作数量很少，从而计算量和存储量很少的解决方法，相当于把答案都存储在表格（table）里了。

但是对于复杂的场景，即使是下棋，也会造成很大的运算量。所以并不是不知道所有的dynamics，而是运算量太大，所以我们只能使用approximation方法。在这种情况下value functions，policies，models都只能使用approximation。



什么是Bellman operators？

映射。从一个价值函数到另一个价值函数。
Bellman operator分为$T^\pi$（策略Bellman operator）和$T$（最优Bellman operator）

算子的目的是用迭代方法找到价值函数。


PI为什么收敛？

我们一直迭代policy使得$v_\pi$更大。在有限的空间中policy总数是有限的，最终我们会找到最好的policy从而使得$v_\pi$最大。当策略不再改变时，该策略就是最优解。

exact solution methods中exact的含义？

能够得到精确的最优解，而不是近似解或启发式解。

exact solution methods有哪些？

VI/PI

approximate methods有哪些？

Q-learning，Monte Carlo，DQN

什么是TD方法？（时序差分）

TD方法结合了蒙特卡洛（MC）和动态规划（DP）的优点。所以TD是approximate method.

MC和DP的优点是什么？

MC的优点是不需要知道environment dynamics: P。DP：使用“当前估计”来更新价值函数，而不是等到一整个回合结束。


PI?

1. Policy Evaluation. 2. Policy Improvement. 直到policy不再变化。

缺点是每一次计算量大（要在policy evaluation阶段解线性方程组）。优点是迭代次数少。策略是固定的，$a = \pi(s)$，而不是探索的。没有概率。比如初始化状态s1下的策略为选择动作a2，然后解方程组，得到这个策略之下，状态价值函数。再用这个状态价值函数带入。

VI?

Bellman operator. 理论支撑是Bellman operator是contraction，fixed point theorem，有唯一解。

缺点是迭代次数多。优点是每一次迭代计算容易。

PI/VI都是在解非线性方程？

PI先固定policy，从而可以计算value function，然后再改进策略。
VI直接求解非线性Bellman operator. 逼近非线性方程的唯一解$v_{*}$
