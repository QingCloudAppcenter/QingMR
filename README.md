# 简介

*SparkMR on QingCloud AppCenter* 将 *Apache Hadoop* 和 *Apache Spark* 集成到同一个集群服务中，以AppCenter云应用的形式交付给用户使用。
>目前支持的Hadoop和Spark版本分别是 *Apache Hadoop 2.7.3* 和 *Apache Spark 2.2.0*  。


## *SparkMR* 的主要功能

- *Apache Hadoop*  提供的MapReduce、YARN、HDFS等功能
- *Apache Spark* 提供的Spark streaming、Spark SQL、DataFrame and DataSet、Structed Streaming、MLlib、GraphX、SparkR等功能
- 同时支持Spark Standalone和Spark on YARN两种模式。

>用户可以选择是否开启Spark Standalone模式（默认开启）。开启后用户可以以Spark Standalone模式提交Spark应用；关闭后用户可以Spark on YARN模式提交Spark应用。如仅以Spark on YARN模式提交Spark应用或者仅使用hadoop相关功能，则可以选择关闭Spark Standalone模式以释放资源。

- 为了方便用户提交Python Spark应用，提供了Anaconda发行版的Python 2.7.13和Python 3.6.1 。用户可以选择Python Spark应用的运行环境，支持在Python2和Python3之间进行切换。
- 为了方便用户开发Python Spark机器学习类的应用， 分别在Anaconda发行版的Python2和Python3内提供了Anaconda发行版的数据科学包numpy, scikit-learn, scipy, Pandas, NLTK and Matplotlib 。
- 为了方便用户开发Spark R应用，提供了R语言运行时。
- 支持上传自定义的Spark应用内调度器Fair Schudeler，并支持spark应用内调度模式在FIFO和FAIR切换
- 支持上传自定义的YARN调度器CapacityScheduler和FairScheduler，并支持在CapacityScheduler和FairScheduler之间进行切换
- 支持用户选择YARN调度器中用于计量资源的ResourceCalculator。默认的DefaultResourseCalculator在分配资源时只考虑内存，而DominantResourceCalculator则利用Dominant-resource来综合考量多维度的资源如内存，CPU等。
- 配置参数增加到近60个，定制服务更方便
- 针对HDFS、YARN和Spark服务级别的监控告警、健康检查与服务自动恢复
- Hadoop、Spark与QingStor集成
- 指定依赖服务，自动添加依赖服务中的所有节点到SparkMR所有节点的hosts文件中
- 支持水平与垂直扩容
- 可选Client节点（为了使用上述全部功能，建议Client节点为必选），全自动配置无需任何手动操作。
