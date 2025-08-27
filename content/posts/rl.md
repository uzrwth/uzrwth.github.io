---
title: "Reinforcement Learning"
date: 2025-08-27T13:41:59+02:00
---

什么是n-armed bandit problem?

一个老虎机 （slot machine）是一个arm，n个老虎机就是n-armed bandit。每个老虎机有自己的reward distribution。我们对每个老虎机都有一个estimate，这个estimate是根据以往经验得到的。进入游乐场我们可以选择玩其中一个老虎机。通常我们会玩estimate最高回报的那个老虎机。但是我们的estimate并不是真实的reward distribution，所以我们也要给机会玩estimate不那么好的老虎机，然后通过新的经验，更新estimate,说不定会得到惊喜。

为什么研究n-armed bandit?

为了慢慢去接近现实中的RL问题。现实中，我们做完一个决定之后，就会去到新的situation，会面临不同的选择，然后我们继续做决定。游乐场老虎机的设定下，问题简化，我们做完决定之后（选择玩哪个老虎机），我们依然在游乐场，situation没有变化，我们仍然面临选择玩哪个老虎机的问题。但在现实中，情况更复杂，当我们玩了一次老虎机之后，我们可能决定再玩一次，可能玩同一个老虎机也可能玩其它老虎机。我们也可能决定玩其他博彩设备。也可能决定不玩了回家。因此，通过研究n-armed bandit，我们可以不用一上来就分析复杂的现实情形，从简单的情形入手，看下我们能学到什么。

