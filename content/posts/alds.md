---
title: "Algorithmic foundations of data science"
date: 2025-09-06T23:41:07+02:00
---

# Markov

initial distribution 和 stationary distribution？

distribution是$1 x n$。

stationary distribution：从某个时刻开始，probability distribution on S不再发生变化

系统的状态分布在t时刻可以用一个概率向量表示。

状态之间转化的概率用矩阵表示。

线性代数上看，矩阵表示线性变换：缩放、投影（投影到某个子空间）、旋转。

向量乘以矩阵，就是把向量送入一个线性变换中。

转移矩阵，它规定了每个状态的概率质量如何流向其它状态。

从分解的角度：向量乘以矩阵，结果是加权平均。

线性代数里，向量一般为列向量，矩阵的本质是线性变换，作用于向量上。Markov chain里向量则是行向量，矩阵的作用是计算加权平均。

Linear algebra Lay教材中，使用列向量表示概率分布，所以转移矩阵就放在左边。大多数Markov相关教材里会用行向量表示概率分布，所以转移矩阵在右边。这种区别也导致了前者的转移矩阵中，列向量才是probability vector。而常见的教材里，行向量才是probability vector。

收敛的定义？

极限不断逼近一个固定值。

Stochastic and Markovian modeling在很多领域有应用。包括物理、生物、工程、经济、金融和
社会科学。

什么是强连通？

strongly connected是图论里的概念。表示任意两个状态，都存在一条路径，使得i可以到达j，j可以到达i。

强连通并不要求每个状态都有正概率直接自环 $P(i, i)$。路径允许存在长度为零的平凡路径（零步路径）

什么是aperiodic？

我们关心从一个状态出发，再回到自身所需步数。所有这样的路径（cycles），如果gcd为1，那么这个状态就是aperiodic。如果至少一个状态是aperiodic，那么Markov Chain是aperiodic。

什么是概率空间？

样本空间，事件集合，概率测度（probability function）。（𝛀, F, P）。F是𝛀的σ-algebra。掷两个骰子，样本空间为36个点。事件集合F为幂集，大小为2^36。概率测度为F中每个事件赋予的概率。f

幂集：P(A)所有 A 的子集的集合。P表示power set。

事件空间和样本空间的幂集的关系？

只有在有限/可数的情况下，事件空间才等于样本空间的幂集。

空集对应的事件含义？

空集：不可能事件

样本空间：必然事件。


幂集是最大事件空间。

{空集, 样本空间}是最小事件空间。

也可以定义事件空间为{空集，样本空间，和为偶数，和为奇数}（满足σ-algebra （运算封闭））。


probability measure：在样本空间上为事件分配概率的数学对象。P: F -> [0,1]

事件集合：𝛀上的一个σ-algebra （运算封闭），保证并、交、补集运算后，依然是事件。（事件族）。事件集合必然包含样本空间和空集。

sample space: 所有可能出现的结果。我们研究一个随机试验，其所有可能出现的结果构成一个集合，这就是样本空间，记作𝜴。如，定义随机试验为扔两个骰子，事件定义为和为偶数。

event: sample space的子集

stochastic process而random experiment的区别？

random和stochastic都表示随机的意思。random一般指单个事件（single event）的随机性。stochastic describes a process or system where random events unfold over time or space.

random variable和stochastic process？

A random variable can become a stocastic process when it is a function of time.

什么是随机变量？

它要满足：

1. 随机变量是一个函数：X: 𝛀 -> R

2. 它的取值形成的集合是事件（可以计算概率）


比如掷两个色子，样本空间为36种搭配。可以定义随机变量为两骰子点数之和，也可以定义为两骰子点数最大值。

定义顺序：

1. 定义样本空间

2. 定义事件空间

3. 定义概率测度

4. 定义随机变量（必须是F-可测）


为什么wiki中，probability space中P是probability funciton，而这里我们却说的是probability measure？

A random variable is a function. A random variable assigns a value to each outcome. A probability measure assigns a value to each event.

我们只会谈论事件的概率，而不是outcome的概率。

Komogorov奠定了概率论的基础。

The reader should do well not to fall into a false sense of security because of his previous familiarity with them. Instead he should try to refine his own use of these terms and watch for the natural context within which each term appears.


概率论最基础的概念：random experiment。意思：an experiment whose outcome cannot be determined in advance.

A sample space is the set of all possible outcomes of an experiment.

An event is a subset of a sample space.

An event A is said to occur if and only if the observed outcome w of the experiment is an element of the set A.

𝛀: certain event

empty set: empty event

probability measure的本质是function：assign a value to each event


This task (putting in their natural place (theory of probability)) would have been a rather hopeless one before the introduction of Lebesgue's theories of measure and integration.

However, after lebesgue's publication of his investigations, the analogies between measure of a set and probability of an event, and between integral of a function and mathematical expectation of a random variable, became apparent.


Conditional probabilities as Random variables, Markov Chains

Borel Fields of probability

为什么事件集合用F表示？

F表示field.

事件集合也会用$\mathcal{E}$，表示events.

$\mathcal{F}, \mathcal{A}, \mathcal{E}, \mathcal{B}$

B表示Borel σ-代数。

sample space也可以称为：the space of elementary events.

σ-代数的定义？


定义：The stochastic process X is called a Markov chain provided that 

P{Xn+1 = j | X0, ..., Xn} = P{Xn+1 = j | Xn}}

recurrent和transient state。

recurrent（常返）: Pj{T < inf} = 1，对于某个状态i，从i出发，最终必然会再次返回到i。

trainsient: Pj{T = +inf} > 0

P是transition matrix

periodic：周期的。

aperiodic: 不定期的。

Q is aperiodic if the greatest common divisor of all cycles in G is 1.

隐马尔可夫模型：HMM （Markov Hidden Model），属于生成模型。

随机生成观测序列的过程。

HMM的概率统计算法、学习算法、预测算法。
HMM在语音识别、自然语言处理、生物信息、模式识别等领域有广泛应用。



# Map-Reduce

cost measures？

wall-clock time: total time for the MR-process to finish

number of rounds

communication cost: sum of the input sizes of all tasks

replication rate: total number of key-value produced by all map tasks divided by the input size

maximum load/reducer size: maximum input length for a single reducer/reduce task.


处理大数据的例子?

ranking of webpages

searches in social networks

counting frequencies of words in collections of documents.


computing clusters？

由switches连接的商品硬件（commodity hardware），非专用并行计算机。


怎么分发计算？


怎么编写分布式程序？



怎么应对硬件故障？

当机器很多时，期望故障也就变大了。


分布式文件系统？DFS

把数据移动到计算中心

为了可靠性，存储多个副本，副本一般存储在不同的rack

文件大，读和追加频繁，更新少

master node存储metadata，metadata找到文件存储位置（file chunks）

Google's GFS、Hadoop's HDFS.



Map-Reduce阶段？

map: 从input file提取信息并生成kv对，每个map任务处理一个file chunk或者多个

shuffle: kv对分组，这一步不需要用户操作

reduce: combine（aggregate，summarise，filter），输出结果，每个reduce任务处理一个或多个keys.


input/output都是kv对。这是为了能组合多个Map-Reduce processes.

map的输入是一个单kv对（on input），输出（emit）一些kv对。

reduce的输入是一个key和相关的values，输出一些kv对。同样的key会分发到同一个reducer。



relational algebra？

术语：tuple

ERM: empirical risk minimization （PAC）

PAC属于statistical learning theory里的内容。

We aim to give statistical estimates on the generalization capabilities of an ML model.

什么是泛化能力（generalization capabilities）？

generalization：扩展延伸。模型在训练集的预测效果扩展到所有未知数据的预测效果。

比如，一个模型在训练集上准确率 99%，但在测试集上只有 60%，说明它泛化能力差。

什么是统计估计（statistical estimates）？

用统计方法来对模型的泛化能力进行估计。

有哪些方法？

cross-validation

 VC 维：Vapnik and Chervonenkis (VC theory)
 
 confidence intervals for accuracy, error rate
 
 What is the basic assumptions of statistical learning theory?
 
 i.i.d. Assumption, independently and identically distributed
 
unknown distribution, we assume there exists a true but unknown probability distribution P(X,Y). The learner never sees this distribution directly -- only samples from it.

Hypothesis space: we define a class of candidate functions (hypothesis space), e.g., linear classifiers, neural networks, decision trees.


What is the PAC learning framework?

Probably approximately correct.

A concept (target function) is PAC-learnable if a learning algorithm can, with high probability, find a hypothesis that is approximately correct with respect to the true distribution of data -- using only a finite number of training examples.

vol(X) is not defined for all sets X (only for measurable X).

在谈论volume时，我们要定义一个measure function，它对集合里的每一个元素都映射到一个非负实数。通常我们使用Lebesgue measure （勒贝格测度）。

比如Vitali set是不可测度的。


power iteration algorithm？

it is used to approximate the dominant eigenvalue (the one with the largest absolute value) and its corresponding eigenvector of a matrx.

steps: 1. initialization (pick a random nonzero vector b0), 2. iterative update (multiply by A, then normalize), 3. convergence (the vector sequence b converges to the eigenvector corresponding to the dominant eigenvalue)

normalize几乎总是默认使用二范数（Euclidean norm），但理论上也可以使用最大norm和其它norm，依然能收敛到正确方向。

特征向量（principal components）不受n-1的影响，因为乘以一个标量不会改变方向。但是特征值会缩放，受到除以n-1的影响。

除以n-1的目的是得到无偏估计。

计算covariance matrix时，首先要对数据进行中心化处理。即每个点都减去平均值。除以n-1或者n，或者不除，都不会影响它的eigenvector的方向，只会影响eigenvector的值。

在 PCA（Principal Component Analysis） 中，principal components（主成分）关心的是方向，而不是具体数值大小。

主成分是数据中方差最大的方向（单位向量），PCA的核心目标是找到数据中最重要的方向。

主成分（principal component）就是数据变化最大方向的单位向量。它是一个方向，所以用线性表达式表示是，必然是经过原点的。ax+by=c，c必定是0。

第一主成分：数据投影到这个方向后，投影点的方差最大。也就是数据沿该方向“最分散”。

第二主成分：在与第一主成分正交的方向上，方差最大。

后续主成分：依次寻找方差最大的正交方向。

换句话说：主成分就是数据中“最长的云团”或者“最拉伸的方向”。

主成分指的是数据变化最大方向的单位向量。即它是一个数据集的属性，而不是这个数据集的covariance matrix的属性。


PCA目标：找一个方向w，使得投影后的方差最大。maximize Var(Xw) = wCw

这是一个 Rayleigh 商问题，解就是 协方差矩阵的最大特征值对应的特征向量。


PCA?

principal component analysis.

In PCA, the first principal component is the direction (a unit vector) along which the data has the maximum variance.

The first principal component is the eigenvector of C corresponding to the largest eigenvalue.

C是covariance matrix.


power iteration和PCA的关系？

Power iteration 是一种求矩阵 最大特征值及对应特征向量 的迭代方法。

PCA目标是找到一个方向w，使得投影后的方差最大。maximize Var(Xw) = wCw。

这是一个 Rayleigh 商问题，解就是 协方差矩阵的最大特征值对应的特征向量。于是用power iteration求解获得的特征向量就是主成分。

怎么理解 The first principal component of A is the span of the dominant eigenvector （第一主成分） of ATA？

span：任何非零倍的向量都表示同一个方向。

所以说第一主成分是ATA的主特征向量的span。

肉眼看到的数据拉伸趋势，其实就是方差最大的方向。

投影：向量和方向向量的点积（dot product）。投影可以是标量scalar projection（点积，表示x在w方向上的长度），也可以是向量vector projection（方向和w相同，长度等于标量投影的绝对值）。

PCA中，投影后的方差最大值，是标量的方差。

投影后的方差计算：由于数据已经中心化，无论在哪个方向上投影，得到的投影也都是中心化的，因此均值为0，这样就能简化方差公式。点积的平方和可以写成向量范数平方。向量范数平方可以写成二次型。得到wXXw。而XX就是covariance matrix。二次型：quadratic form。

---

Briefly explain the concepts of batch and online learning in the context of supervised learning. What is the difference?

For batch learning all training data is received initially in one batch. On the other hand, in online learning, training data arrives over time and we have to gradually improve the classifier.


What is the property of the hypothesis returned by an Empirical Risk Minimization algorithm?

An ERM algorithm will choose a hypothesis that minimizes the training error. （empirical risk和training errors是同一个概念）

training error是0-1损失。empirical risk中的损失函数可以是0-1损失、平方损失、交叉熵损失。hypothesis就是我们从假设空间（hypothesis space）里选出来的一个具体函数。一开始我们要确定假设空间，比如为所有线性函数，那么$h(x) = wx + b$，学习过程就是在训练数据上优化w和b，最终选出一个最优的h。

learning = 在假设空间里寻找最优假设的过程。
在大多数机器学习方法里，你通常需要一开始就选择一个假设空间（hypothesis space），因为学习算法只能在这个空间里寻找最优函数。


Where is the volume of high-dimensional balls concentrated? Name the intuitive meaning of both bounds we considered in the lecture.

The volume of an high-dimensional object is concentrated near the surface. Moreover, the volume of an high-dimensional ball is also concentrated near the equator


Name two applications of the Multiplicative Weight Update Algorithm discussed in the lecture.

Boosting, Bandit Learning, Stock Market Predictions.


Give the definitions of connectedness, aperiodicity, and ergodicity of Q (a Markov chain)

Q is connected if $G_Q$ is strongly connected

Q is aperiodic if the greatest common divisor of all cycles in $G_Q$ is 1

Q is ergodic if Q is both connected and aperiodic.



Name and describe three cost measures that are used in the analysis of Map-Reduce algorithms.

Wall-clock time: total time for the MR-process to finish

Number of rounds: total number of MR-rounds

Communication cost: sum of the input sizes of all tasks

Replication rate: total number of key-value produced by all map tasks divided by the input size

Maximum load / reducer size: maximum input length for a single reducer / reduce task.

---

ERM和MLE的关系？

MLE是ERM的一个特例。ERM是一种思想和原则。

如果我们选择的损失函数是“负对数似然损失”，那么ERM就等价于MLE。

最大和最少之间的转换：取负对数。最大似然就转换为求最小负对数。

PRML并没有直接讲解ERM，它更倾向于概率建模/贝叶斯方法。
主线是，假设数据来自于某个概率分布。通过MLE或MAP来估计模型参数。延伸到完整的贝叶斯推断。书中大量的例子（线性回归、逻辑回归、神经网络）都以似然函数出发。

ERM是一种思想，隐含存在于在PRML的多个地方。（线性回归（MLE，用平方损失做ERM）、逻辑回归（MLE，最小化交叉熵损失，用对数损失做ERM）、神经网络训练（目标函数是对数似然））

也而就是说，PRML的损失函数来源是概率分布，而不是从ERM的“风险最小化”角度去抽象。

PRML重在概率论视角（MLE/MAP/Bayes），ERM隐藏在MLE的形式里。

统计学习方法（李航）/Understanding ML，重在学习理论视角（泛化、风险、ERM、SRM）


损失：loss

损失是对单一样本的预测误差度量。训练误差（training error/empirical risk）是所有样本损失的平均。

---

统计学习方法

监督学习方法，包括感知机、k近邻法、朴素贝叶斯、决策树、logistic regression与最大熵模型、支持向量机（SVM）、提升方法、EM算法、隐马尔可夫模型和条件随机场。

---
