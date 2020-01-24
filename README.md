# TrainModelCluster
 Executing Batch Jobs on a High Performance Computing ClusterMarek Grze ́sJanuary 20, 20201    High Performance ComputingIn this exercise, you will use the Hydra cluster.  Hydra is the School of Computing’s High Performance Computing cluster.  The CPU partition of theHydra’s cluster contains 17 servers each with 2x Intel Xeon E5520 CPUs running at 2.27GHz.  Each server has 8 cores (16 threads), and between 12GBand 24GB of RAM. There are also GPUs available on Hydra, but we will not use them in this exercise because they are heavily used by researchers in theSchool.Your cluster directory (/cluster$HOME) onraptoris shared between all the compute nodes; if your software and data are in that folder, the computenodes can access them when your jobs are executed.  Theraptorserver is available via SSH.In this exercise, you will use the standard cluster software for submitting and managing batch jobs.  This process will be briefly introduced during ourseminar, but you are expected to read the documentation that is available here:•https://www.cs.kent.ac.uk/systems/hydra/•https://slurm.schedmd.com/archive/slurm-17.11.2/quickstart.html•https://slurm.schedmd.com/archive/slurm-17.11.2/sbatch.htmlDon’t usesrunto do this assignment.The default partition on the Hydra cluster is namedtest, and you can use it for testing your small jobs.  You should use thecpupartition for realexperiments.  We can see a partition as a queue where the jobs are submitted.2    ObjectivesImagine that you have program X, and you wish to run it on N different datasets, where N is relatively large and the time to run X on one dataset can beseveral hours or more.  When X is executed on one dataset, the result is a numerical score that is printed by X to the standard output.  The numerical score1 indicates what was the performance of X on that particular dataset.  You would like to compute an average score across all N datasets.  If N was small, youcould potentially execute X N times on your desktop computer using graphical user interface.  The average values of your runs could be computed in Excel.However, when N is large, running such an experiment on a desktop machine becomes tedious if not impossible.  For that reason, batch processing on apowerful cluster could be advantageous.  In this assignment, you will learn how to run such an experiment on our Hydra cluster.  In your experiment, Xwill be a machine learning programme called Weka, which will be executed on N datasets found in directoryuci-data/*.arff.  After doing this exercise,you will know how to run such experiments, and you will have a chance to see advantages of batch processing on computing clusters.Methodologically,  this experiment (in its current version) does not make much sense from the machine learning point of view.  It will be sufficient,however, to demonstrate the benefits of batch processing.3    SSH Access to Linux ServesTo do this assignment, you will need to use your UNIX password.  If you’ve forgotten your Unix password, visit this page (https://www.cs.kent.ac.uk/systems/newuser/) to change it.  Having your UNIX password, you can try tosshtoraptor.kent.ac.ak.  If raptor lets you in, it means that your loginname and password are correct.  If you work in Windows, you can useputty.exeto make ssh connections.  You don’t need VPN to ssh toraptor.4    Assignment—Executing Batch JobsIn this assignment, you will simultaneously run multiple jobs on the Hydra cluster.  Each job is a sequential program, i.e., it does not use concurrency;however, the fact that you will run dozens of such jobs will show the benefit of batch processing on a (multi-core/ multiprocessor) computing cluster.4.1    Task DescriptionYour objective is to run Weka on N datasets located in directoryuci-data/*.arff.  This means that Weka will be executed N times usingsbatchonthe  cluster.   Every  execution  will  produce  a  text  file  with  Weka’s  standard  output,  which  will  contain  the  result  of  a  particular  run.   Your  goal  is  toextract numerical results from the individual output files and to put them in one text file.  This file will contain two columns of data.  The first columnwill be the name of the dataset, and the second column will be score of the algorithm on that dataset.  The second goal is to write another bash scriptthat will compute the average score and save it to a text file.  Note that the average should be computed using the scripts written inbashor any otherUNIX/LINUX shell that is available onraptor.  This means that languages like Python or Java should not be used in this assignment.All jobs should be submitted to thecpupartition and executed with a time limit of 45 minutes and 1GB of RAM. These restrictionscan be specified as parameters to thesbatchcommand.  You will need to read the manual to see how to do that.2 4.2    Detailed InstructionsIf  not  explicitly  stated  otherwise,  all  the  commands  that  are  shown  below  should  be  executed  in  your  cluster  directory  onraptor;  the  directory  is/cluster$HOME.1.Log intoraptor2.cd /cluster$HOMENote thatls /cluster$HOMEwill not show any files before you docd /cluster$HOMEbecause this is a network drive.3.Install weka(a)  You can download weka from my website using:wget http://www.cs.kent.ac.uk/people/staff/mg483/documents/teaching/CO890/assignment1/weka-3-6-13.tar.bz2(b)  Then bunzip2 the bz2 file.  This will create a new directory called weka-3-6-13.  You can do that using:tar xjf weka-3-6-13.tar.bz2(c)  If you’d like to check if Weka was installed correctly, you can type:java -Xmx1000M -cp weka-3-6-13/weka.jar weka.classifiers.trees.J48 -hThis command will print help for classifierweka.classifiers.trees.J48which is one of the classification algorithms available in Weka.(d)  At this point, Weka is installed in your cluster directory in/cluster$HOME/weka-3-6-134.Download data(a)  Datasets can be obtained from my web-site using:wget http://www.cs.kent.ac.uk/people/staff/mg483/documents/teaching/CO890/assignment1/uci-data.tar.bz2(b)  Then bunzip2 the bz2 file.  This will create a new directory called uci-data.  You can do that using:tar xjf uci-data.tar.bz2This directory should contain a number of files with the*.arffextension.5.Local testBefore you continue, you can run weka from your terminal to see if it works fine on a small dataset.  You can do that using:java -Xmx1000M -cp weka-3-6-13/weka.jar weka.classifiers.trees.RandomForest -t uci-data/iris.arff -iThis is a tiny example, and its output should be as follows:3 Random  forest  of 100 trees , each  constructed  while  considering 3 random  features.Out of bag  error: 0.06Time  taken to  build  model: 0.21  secondsTime  taken to test  model  on  training  data: 0.04  seconds===  Error  on  training  data  ===Correctly  Classified  Instances           150                 100       %Incorrectly  Classified  Instances           0                   0       %Kappa  statistic                               1Mean  absolute  error                           0.0142Root  mean  squared  error                      0.0598Relative  absolute  error                      3.19    %Root  relative  squared  error                12.6925 %Total  Number  of  Instances                 150===  Detailed  Accuracy  By  Class  ===TP Rate    FP Rate    Precision    Recall   F-Measure    ROC  Area   Class1           0            1           1           1            1          Iris -setosa1           0            1           1           1            1          Iris -versicolor1           0            1           1           1            1          Iris -virginicaWeighted  Avg.     1           0            1           1           1            1===  Confusion  Matrix  ===a   b   c    &lt;-- classified  as50   0   0 |   a = Iris -setosa4 0 50   0 |   b = Iris -versicolor0   0 50 |   c = Iris -virginica===  Stratified  cross -validation  ===Correctly  Classified  Instances           143                  95.3333 %Incorrectly  Classified  Instances           7                   4.6667 %Kappa  statistic                                0.93Mean  absolute  error                           0.0393Root  mean  squared  error                      0.1556Relative  absolute  error                      8.85    %Root  relative  squared  error                33.0021 %Total  Number  of  Instances                 150===  Detailed  Accuracy  By  Class  ===TP Rate    FP Rate    Precision    Recall   F-Measure    ROC  Area   Class1           0            1           1           1            1          Iris -setosa0.94        0.04         0.922      0.94        0.931        0.991     Iris -versicolor0.92        0.03         0.939      0.92        0.929        0.991     Iris -virginicaWeighted  Avg.     0.953      0.023        0.953      0.953      0.953        0.994===  Confusion  Matrix  ===a   b   c    &lt;-- classified  as50   0   0 |   a = Iris -setosa0 47   3 |   b = Iris -versicolor0   4 46 |   c = Iris -virginica5 This example uses one of the Weka’s algorithms that is called ‘random forest’ and is implemented inweka.classifiers.trees.RandomForest.  Forthe purpose of this exercise, you do not need to worry about these details; however, you should know how to find the final numerical score of thisexecution.  Note that in the middle of the above output, you can see this line:===  Stratified  cross -validation  ===Below that line, we have the results that we are interested in.  Specifically, we are interested in the percentage ofCorrectly Classified Instances,i.e., we are interested in numerical values that are at the end of the lineCorrectly Classified Instances 143 95.3333 %.  In our experiment,you will be extracting those lines from every (successful) execution of Weka.  If Weka fails on a particular dataset, we will ignore such a result.  Notethat Weka may be terminated by the cluster software if a particular run exceeds your time or memory limit.  So, we expect that some jobs will fail.6.Cluster TestNow, you can run the previous test usingsbatch.  For that, you will need my bash scriptrunweka-sbatch.sh:#!/bin/bash#SBATCH  --nodes=1 # number  of  cluster  nodes , abbreviated  by -N#SBATCH  -o slurm -%j-%N.out # name of the  stdout , using  the  job  number  (%j) and  the  first  node (%N)#SBATCH  -e slurm -%j-%N.err # name of the  stderr , using  job  and  first  node  values#SBATCH  --ntasks =1 # number  of  SLURM  tasks , abbreviated  by -nif [ $# -ne 1 ]then(>&amp;2 echo "Usage: ‘basename $0‘ {1 arg  expected}")(>&amp;2 echo "         a path to your  data  file is  required  as a command  line  parameter")(>&amp;2 echo "         error  message  generated  by runweka -sbatch.sh")exit 1fiexport  DATASETNAME=‘basename  $1 .arff ‘# the  first  line in the  output  is the  name of the  data  fileecho "$DATASETNAME"java -Xmx1000M  -cp weka -3-6-13/ weka.jar  weka.classifiers.trees.RandomForest  -t $1 -i -I 10000  -K 1006 You can download this script from my web site using:wget http://www.cs.kent.ac.uk/people/staff/mg483/documents/teaching/CO890/assignment1/runweka-sbatch.shThis example bash script can be used to submit jobs to the cluster’s queuing system using:sbatch runweka-sbatch.sh uci-data/iris.arffThe script takes a path to your data file as a parameter.  Note that by default thetestpartition is used.  After you have submitted this job, i.e.,after you have executedsbatch, you should be able to see this job in the queue usingsqueue.  The output ofsqueuewill be similar to:mg483@raptor  [/ cluster/home/cur/mg483/CO890/a1 -execution] $ squeueJOBID  PARTITION      NAME      USER ST         TIME   NODES  NODELIST(REASON)42048         cpu  ex_30.sh    nobody   R    21:09:44       1 cloud0242060         cpu    run.sh    nobody   R    21:07:28       1 legacy1442061         gpu  run_clt.    nobody   R    21:06:56       1 pascal0242062         gpu  resnet_a    nobody   R    21:00:52       1 pascal0142168        test  runweka -     mg483   R         0:01       1 cloud01The last job in this example is the job that we have just started.  After your job has been finished, you will see two files in your cluster directory:slurm-*-*.outandslurm-*-*.err.  The first one contains the standard output whereas the second one the standard error of the process (Wekaand the bash script in this case) that was submitted as your job.  The content of the file that contains standard output should be the same as whatyou had on your screen when you executed the local test above, except for the first line that contains the name of the data file printed by the bashscript.Before you proceed to the next step, you should take care to notice that theslurm-*-*.outfile produced above contains the name of the dataset inthe first line, and that after the following line=== Stratified cross-validation ===there is a line with the result that we are interested in, i.e.,Correctly Classified Instances         143               95.3333 %.Note that the expressionCorrectly Classified Instancesappears twice in the output.  You will need to address this fact explicitly in your bashscripts below.7.Main Task (1)—Submitting JobsYour task is to use therunweka-sbatch.shfile in conjunction withsbatchto submit one job for every data file that can be found in theuci-datadirectory.  This process should be automated, and you should implement it in bash.  Your bash script should submit all the jobs in one execution (onejob corresponds to executing Weka on one dataset).  Note that you will need to make sure that your jobs satisfy the constraints specified in Sec. 4.1.8.Main Task (2)—Extracting Individual ResultsAfter all the jobs started by your script that you will write for the previous step have been computed (i.e.  when you don’t see any of your jobswaiting in the queue), you will need to parse the output files and compute the results.  The output files areslurm*.outandslurm*.errin thedirectory in which you submitted the jobs to the queue.  You are interested in the standard output, i.e., in theslurm*.outfiles.7 Your goal is to write a bash script that will be executed, for example, as follows:bash resultsweka.sh slurm*.outwhere the argument to the script specifies the output files that should be processed by the script.  Note that this corresponds to the names of filesthat contain standard output of your jobs.  Your script has to process all filesslurm*.out, and for every*.outfile, it has to print one line that willcontain two values:(a)  The name of the dataset that is in the first line of theslurm*.outfile(b)  The last numerical number in the line that containsCorrectly Classified Instances, but for the instance of that line that appears after the following line=== Stratified cross-validation ===Specifically, for the example output for the iris dataset computed in our test above, the line should be:iris 95.3333.Your script should produce a result like this line for every file that matches this patternslurm*.out.Let’s  assume  that  when  this  script  is  executed  before  all  the  datasets  have  been  processed  (i.e.,  when  some  jobs  are  still  being  executed  on  thecluster), it will print the lines for those datasets for which the experiment has been completed.  The lines for the datasets for which the results arenot available should not be printed.9.Main Task (3)—Average PerformanceHaving results from the previous step,  your task is to write a tiny bash script that will compute the average result,  and it will save the averagevalue to a separate file.  Specifically, your script will read the file produced in the previous step, and it will compute the average value for the secondcolumn that contains numerical values.  The result of this task (i.e.  one number that represents the average) should be saved in a text file.Note that the file with individual results may contain empty lines, for example, the following file contains three lines where the second line is empty.iris  95.3333&lt;- empty  linediabetes  68.5Or here the third line can be empty:iris  95.3333diabetes  68.5&lt;- empty  line8 In these cases,  the average should be81.91and not54.61,  which would be returned when the empty line was counted incorrectly.  Your scriptshould return a correct value for such input.10.Main Task (4)—Second RunIn the final task, you won’t need to do any coding.  The goal of this task is to run the entire experiment again with different settings of the Weka’smachine learning algorithm.  This is basically for you to appreciate how easy it is to run such experiments after you have set up your environment,i.e., after you have written required scripts.For the second run, you will just need to change Weka’s parameters inrunweka-sbatch.sh.  For that, you need to replace the last line of that scriptwith the following line:java -Xmx1000M -cp weka-3-6-13/weka.jar weka.classifiers.trees.J48 -t $1 -iand then you simply run the entire experiment again, i.e., you use your updated script on all datasets, extract the results, and compute the averagevalue.Hopefully, at this point, you will see the benefit of the entire exercise where you can run the experiment with new parameters again, and the processof running the experiment as well as processing the results are fully automated.  Imagine that you need to repeat this experiment 100 times (eachtime with different parameters), on all N datasets, and report the average performance on each of those 100 parameter settings.  Would the softwarewe created in this exercise make your life easier?4.3    DeliverablesThe following files (as one archive gz, zip, bz2, rar or similar) should be uploaded to Turnitin:1.  All files that contain any bash code that you had to write to do this exercise.2.  All output files generated by all your jobs (both the standard output as well as the standard error).3.  A text file that contains the names of datasets and the numeric values extracted from individual jobs (two columns:  name of dataset and a numericalvalue).4.  A text file that contains the average value across all datasets.5.  A text file (max 150 words) with your critical reflection on this task (your conclusion, your challenges, what you’ve learned etc.)Note that items 2–4 in the list above should be sent for the second run as well, i.e., you will have two sets of files described in items2–4.9 4.4    Additional Information1.  If you don’t know how to copy files between Linux servers and your desktop computer, you can trywinscporpscp.exeon Windows,scpon Macand Linux, orkonqueroron Linux.2.  Note that jobs of all students from your seminar group are likely to be submitted to the same queue.  Therefore, submit your jobs early because theymay not finish by the deadline if all the students submit on the last day.3.  The use of abstractions (e.g.  functions and variables whenever appropriate) and succinctness of the bash code will be taken into account duringmarking.  Try to make your code clear and use system tools such asawk,sed,grepetc.  The quality of comments that you will put in your bash fileswill influence your mark as well.  For example, all complex, non-standard steps in the bash code should be explained in comments.4.  Useful Slurm commands:sinfo,squeue,scontrol show partition.10