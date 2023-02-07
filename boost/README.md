# 库名称：Boost

如名称所示，封装了有关Boost的一些函数，通过DllCall调用的方式实现。

---

## 目录

1. 库简介
2. 库使用方法
3. 库依赖
4. 库结构
5. 关于作者
6. 更新日志（已更新至1.0.0）

---

## 库简介
### 版本信息
2023.01.24 发布1.0.0版本

---

## 库使用方法
按照库结构中所描述的层次调用函数，具体函数参数请查阅相关C++函数文档。

## 库依赖
lib内所有dll，通过官方Boost源码直接封装，故无源码。

## 库结构
### 抽象模型，具体结构见源代码
```
Boost
├── Math/Math.Double/Math.Float // 主要数学函数
│   ├── acosh(number) // 计算反双曲余弦值
│   ├── asinh(number) // 计算反双曲正弦值
│   ├── assoc_laguerre(n, m, x) // 计算n阶、m阶和参数x的相关拉盖尔多项式
│   ├── assoc_legendre(n, m, x) // 计算n阶、m阶和参数x的相关勒让德多项式
│   ├── atanh(number) // 计算反双曲正切值
│   ├── beta(x, y) // 计算Y在X上的回归系数的最小二乘估计
│   ├── cbrt(number) // 计算立方根
│   ├── comp_ellint_1(k) // 计算k的第一类完整椭圆积分
│   ├── comp_ellint_2(k) // 计算k的第二类完整椭圆积分
│   ├── comp_ellint_3(k) // 计算k的第三类完整椭圆积分
│   ├── copysign(number1, number2) // 返回带有第二个参数符号的第一个参数
│   ├── cyl_bessel_i(v, x) // 计算ν和x的正则修正圆柱贝塞尔函数
│   ├── cyl_bessel_j(v, x) // 计算ν和x的第一类柱面贝塞尔函数
│   ├── cyl_bessel_k(v, x) // 计算ν和x的第二类柱面贝塞尔函数
│   ├── cyl_neumann(v, x) // 计算 n 和 x 的柱诺依曼函数
│   ├── ellint_1(k, f) // 计算k和t的第一类不完全椭圆积分
│   ├── ellint_2(k, f) // 计算k和t的第二类不完全椭圆积分
│   ├── ellint_3(k, v, f) // 计算k、v和t的第三计算arg的互补误差函数类不完全椭圆积分
│   ├── erfc(number) // 计算互补误差函数
│   ├── erf(number) // 计算误差函数
│   ├── expint(number) // 计算指数积分
│   ├── expm1(number) // 计算将e（欧拉数，2.7182818）提升到给定的幂，减去1.0
│   ├── fmax(number1, number2) // 返回较大值
│   ├── fmin(number1, number2) // 返回较小值
│   ├── hermite(n, x) // 计算x的n次埃尔米特多项式
│   ├── hypot(number1, number2) // 计算x和y的平方和的平方根，在计算的中间阶段没有过度上溢或下溢
│   ├── laguerre(n, x) // 计算x的n次非关联拉盖尔多项式
│   ├── legendre(n, x) // 计算x的n次非关联勒让德多项式
│   ├── lgamma(number) // 计算伽马函数绝对值的自然对数
│   ├── llround(number) // 计算与参数最接近的整数
│   ├── log1p(number) // 计算1+number的自然对数
│   ├── lround(number) // 计算与参数最接近的整数
│   ├── nextafter(number1, number2) // 如果number1等于number2，则返回number2
│   ├── nexttoward(number1, number2) // 如果number1等于number2，则返回从double转换为double/float，而不损失范围或精度的number2
│   ├── riemann_zeta(number) // 计算黎曼zeta函数
│   ├── round(number) // 计算与参数最接近的整数
│   ├── sph_bessel(n, x) // 计算n和x的第一类球面贝塞尔函数
│   ├── sph_legendre(l, m, t) // 计算l度、m阶和极角t的球面相关勒让德函数
│   ├── sph_neumann(n, x) // 计算n和x的第二类球面贝塞尔函数，也称为球面诺依曼函数
│   ├── tgamma(number) // 计算伽马函数
│   ├── trunc(number) // 返回整数部分
```

---

## 关于作者
Mono，另名MonoEven，Mono919。

---

## 更新日志
### 已更新至1.0.0
1. 更新了README.md