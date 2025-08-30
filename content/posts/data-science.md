---
title: "Data Science"
date: 2025-08-30T07:44:47+02:00
---


maximum likelihood和least squares的关系？

我们假设有一些数据是由多项式方程生成的，但是采样过程中会有高斯噪声。我们想要对这些数据线性回归得到一个可以预测的模型。在这个过程中我们关注一个目标函数：sum-of-squares error（SSE）。目的是使这个函数最小化。
SSE是目标函数，而最小二乘是方法。最小二乘（least squares）思想是，找到一组参数使得预测值和真实值之间的平方误差和最小。为什么叫二乘？乘有“次方”的意思，二乘表示二次方。SSE里就是用的误差二次方和。$t_n$表示在$x_n$处的观测值。$x_n$处的真实值（模型预测）为$y(x_n;\mathbf{w})$。这里$x_n$和$\mathbf{w}$用分号隔开，而不用逗号，这是为什么？逗号表示两者都是自变量。而实际该函数只有$x_n$为自变量。在模型训练完毕以后，$\mathbf{w}$被确定，因此$\mathbf{w}$作为学习的参数在训练之后是固定的，它不是自变量。$\\mathbf{w}$这里用向量表示，因为它包含的是一些权重，而非单一数值。

maximum likelihood和least squares的关系？我们可以思考，直觉上least squares能找到最好的polynomial模型，但是这背后有理论支撑吗？为什么我要设计目标函数为最小二乘？为什么说最小二乘和最大似然是等价的？

最小二乘优化友好，是凸二次函数，易于求解。统计角度，符合“噪声为高斯分布”的假设。几何直观，最小化预测值与真实值之间的“距离”。


什么是线性回归模型？

线性回归模型是指一系列的线性函数，参数可调整。线性指的是对参数线性，对于自变量没有要求。自变量的非线性函数称为basis functions。它可以表达为

$y(\mathbf{x}; \mathbf{w}) = \mathbf{w}^{\intercal}\boldsymbol{\phi}(\mathbf{x})$

$\boldsymbol{\phi}$ 表示 $\mathbf{x}$ 的 basic functions向量。有M-1个basic functions，一个常数函数$f(\mathbf{x})=1$。常数函数用于搭配$w_0$，表示offset。函数向量和参数向量的维度都是M，所以可以内积。$\boldsymbol{\phi}$ 是基函数向量：

$\boldsymbol{\phi}(x) = [1, x, x^2, x^3, ..., x^M]^\top$


为什么要研究线性回归模型？

对于参数是线性的，这一点使得参数的学习便于分析。但是对参数的线性也带来了很大的限制。

什么是线性回归？

线性回归模型（linear regression models）指的是一类模型。线性回归（linear regression）则是从狭义上指的最简单的线性模型：对参数和对自变量都是线性的。当我们对自变量使用nonlinear function时，它们被称为basic functions。

常见basic functions？

polynomial，Gaussians，sigmoidal。


---

我要用polynomial functions fit数据集，有什么方法？

最小二乘法。构造损失函数：error function。求解方法有两种：正规方程和梯度下降。正规方程要求矩阵满足可逆。

$\Phi = [\phi(x_1),\phi(x_2)...]$，$x_1, x_2, ...$ 为样本。

要求 $\Phi^\top\Phi$ 可逆。
正规方程得到的是最优解。因为error function即目标函数或者损失函数是凸函数，存在全局最小值。正规解的思路是令梯度为0。缺点是要求矩阵可逆并且当样本数很多时，计算量很大。而且可能有过拟合的缺点。

梯度下降不必求解梯度为0的$\mathbf{w}^*$，而是直接使用梯度，再加上学习率，迭代收敛到最优解。
最小二乘指的是最小化目标函数。解决这个问题的方法可以是正规方程，也可以是梯度下降。


