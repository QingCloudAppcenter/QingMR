# 简介

*QingMR on QingCloud AppCenter* 将 *Apache Hadoop* 和 *Apache Spark* 集成到同一个集群服务中，以AppCenter云应用的形式交付给用户使用。
>目前支持的Hadoop和Spark版本分别是 *Apache Hadoop 2.7.3* 和 *Apache Spark 2.2.0* 


## *QingMR* 的主要功能

- *Apache Hadoop*  提供的MapReduce、YARN、HDFS等功能
- *Apache Spark* 提供的Spark streaming、Spark SQL、DataFrame and DataSet、Structed Streaming、MLlib、GraphX、SparkR等功能
- 同时支持Spark Standalone和Spark on YARN两种模式
- 为了方便用户提交Python Spark应用，提供了Anaconda发行版的Python 2.7.13和Python 3.6.1 。用户可以选择Python Spark应用的运行环境，支持在Python2和Python3之间进行切换
- 为了方便用户开发Python Spark机器学习类的应用， 分别在Anaconda发行版的Python2和Python3内提供了Anaconda发行版的数据科学包numpy, scikit-learn, scipy, Pandas, NLTK and Matplotlib 
- 为了方便用户开发Spark R应用，提供了R语言运行时。
- 支持上传自定义的Spark应用内调度器Fair Schudeler，并支持spark应用内调度模式在FIFO和FAIR切换
- 支持用户自定义Hadoop代理用户及其能够代理哪些hosts和这些hosts中的哪些groups
- 支持上传自定义的YARN调度器CapacityScheduler和FairScheduler，并支持在CapacityScheduler和FairScheduler之间进行切换
- 配置参数增加到近60个，定制服务更方便
- 针对HDFS、YARN和Spark服务级别的监控告警、健康检查与服务自动恢复
- Hadoop、Spark与QingStor集成
- 指定依赖服务，自动添加依赖服务中的所有节点到SparkMR所有节点的hosts文件中
- 支持水平与垂直扩容
- 可选Client节点（为了使用上述全部功能，建议Client节点为必选），全自动配置无需任何手动操作

> 更多介绍详见[用户指南](http://appcenter-docs.qingcloud.com/user-guide/apps/docs/QingMR/)

> [QingMR试用](https://appcenter.qingcloud.com/apps/app-6iuoe9qs)
