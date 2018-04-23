# 简介

*QingMR* 将 Hadoop 生态圈重要组件包括 *Apache Hadoop* , *Apache Spark* ， *Apache Hive* 和 *Kylin* 集成到一起，以云端应用的形式交付给用户使用。当前支持的组件及版本如下：

-  *Apache Hadoop 2.7.3*

-  *Apache Spark 2.2.0*

-  *Apache Hive 1.2.2* （ QingMR 1.1.0 开始支持 ）

-  *Kyligence Analytics Platform 2.5.6* （ Kylin 的企业级产品，需单独购买 license，QingMR 1.2.0 开始支持 ）

  > 更多组件，敬请期待

## *QingMR* 的主要功能

- *Apache Hadoop*  的 MapReduce、YARN、HDFS 等服务  
- *Apache Spark* 的 Spark streaming、Spark SQL、DataFrame and DataSet、Structed Streaming、MLlib、GraphX、SparkR 等功能  
- *Apache Hive*  的以 SQL 语法读、写和管理分布式大规模数据集的 SQL on Hadoop 数据仓库功能  
- *Kyligence Analytics Platformn* 基于 Apache Kylin 的企业级大数据智能分析平台
- 同时支持 Spark Standalone 和 Spark on YARN 两种模式
- 为了方便用户提交 Python Spark 应用，提供了 Anaconda 发行版的 Python 2.7.13 和 Python 3.6.1 。用户可以选择 Python Spark 应用的运行环境，支持在 Python2 和 Python3 之间进行切换
- 为了方便用户开发 Python Spark 机器学习类的应用， 分别在 Anaconda 发行版的 Python2 和 Python3 内提供了 Anaconda 发行版的数据科学包 numpy, scikit-learn, scipy, Pandas, NLTK and Matplotlib
- 为了方便用户开发 Spark R 应用，提供了R语言运行时。
- 支持上传自定义的 Spark 应用内调度器 Fair Schudeler，并支持 spark 应用内调度模式在 FIFO 和 FAIR 切换
- 支持用户自定义 Hadoop 代理用户及其能够代理哪些 hosts 和这些 hosts 中的哪些 groups
- 支持上传自定义的 YARN 调度器 CapacityScheduler 和 FairScheduler，并支持在 CapacityScheduler 和 FairScheduler 之间进行切换
- 配置参数增加到近60个，定制服务更方便
- 针对 HDFS、YARN 和 Spark 服务级别的监控告警、健康检查与服务自动恢复
- Hadoop, Spark 和 Hive 与 QingStor 集成
- 指定依赖服务，自动添加依赖服务中的所有节点到 QingMR 所有节点的 hosts 文件中
- 支持水平与垂直扩容
- 可选 Client 节点（为了使用上述全部功能，建议 Client 节点为必选），全自动配置无需任何手动操作

> 更多介绍详见[用户指南](https://docs.qingcloud.com/product/big_data/QingMR/README.html)

> [QingMR试用](https://appcenter.qingcloud.com/apps/app-6iuoe9qs)
