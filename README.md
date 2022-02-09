# 简介

*QingMR* 将 Hadoop 生态圈重要组件包括 *Hadoop* , *Spark*  *Hive* 和 *Flink* 集成到一起，以云端应用的形式交付给用户使用。当前支持的组件及版本如下：

| | Hadoop | Spark | Hive | Flink |
| :------: | ------: | ------: | ------: | ------: |
| QingMR - Core 1.2.1 | 2.7.3 | 2.2.0 | 1.2.2 | - |
| QingMR - Core 1.3.0 | 2.7.3 | 2.2.0 | 2.3.4 | - |
| QingMR - Core 2.5.2 | 2.9.2 | 2.2.3 | 2.3.5 | 1.9.0 |
| QingMR - Core 2.6.1 | 3.1.3 | 2.4.8 | 3.1.2 | 1.13.1 | 

备注：*Kyligence Enterprise* 作为 *Kylin* 的企业版也是构建在 *QingMR* 之上，如需使用可以[点击这里](https://appcenter.qingcloud.com/apps/app-66xhycwj/Kyligence%20Enterprise%20%20-%20Apache%20Kylin%20%E4%BC%81%E4%B8%9A%E7%89%88)获取。
 > 更多组件，敬请期待 

## *QingMR* 的主要功能

- *Hadoop*  的 MapReduce、YARN、HDFS 等服务  
- *Spark* 的 Spark streaming、Spark SQL、DataFrame and DataSet、Structed Streaming、MLlib、GraphX、SparkR 等功能  
- *Flink* 的 DataStream and DataSet、CEP、Table、FlinkML、Gelly 等功能
- *Hive*  的以 SQL 语法读、写和管理分布式大规模数据集的 SQL on Hadoop 数据仓库功能  
- *Kyligence Analytics Platformn* 基于 Kylin 的企业级大数据智能分析平台
- 同时支持 Spark Standalone 和 Spark on YARN 两种模式
- 支持 Flink on YARN 模式
- 同时支持 Hive on MapReduce 和 Hive on Spark 两种模式
- 为了方便用户提交 Python Spark 应用，提供了 Anaconda 发行版的 Python 2.7.13 和 Python 3.6.1 。用户可以选择 Python Spark 应用的运行环境，支持在 Python2 和 Python3 之间进行切换
- 为了方便用户开发 Python Spark 机器学习类的应用， 分别在 Anaconda 发行版的 Python2 和 Python3 内提供了 Anaconda 发行版的数据科学包 numpy, scikit-learn, scipy, Pandas, NLTK and Matplotlib
- 为了方便用户开发 Spark R 应用，提供了R语言运行时。
- 支持上传自定义的 Spark 应用内调度器 Fair Schudeler，并支持 spark 应用内调度模式在 FIFO 和 FAIR 切换
- 支持用户自定义 Hadoop 代理用户及其能够代理哪些 hosts 和这些 hosts 中的哪些 groups
- 支持上传自定义的 YARN 调度器 CapacityScheduler 和 FairScheduler，并支持在 CapacityScheduler 和 FairScheduler 之间进行切换
- 支持基于 Spark 的分布式深度学习框架 BigDL
- 配置参数增加到70多个，定制服务更方便
- 针对 HDFS、YARN 和 Spark 服务级别的监控告警、健康检查与服务自动恢复
- Hadoop, Spark 和 Hive 与 QingStor 集成
- 指定依赖服务，自动添加依赖服务中的所有节点到 QingMR 所有节点的 hosts 文件中
- 支持水平与垂直扩容
- 可选 Client 节点（为了使用上述全部功能，建议 Client 节点为必选），全自动配置无需任何手动操作

> 更多介绍详见[用户指南](https://docs.qingcloud.com/product/big_data/QingMR/README.html)

> [QingMR试用](https://appcenter.qingcloud.com/apps/app-6iuoe9qs)

