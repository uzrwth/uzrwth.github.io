---
title: "Algorithmic foundations of data science"
date: 2025-09-06T23:41:07+02:00
---

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
