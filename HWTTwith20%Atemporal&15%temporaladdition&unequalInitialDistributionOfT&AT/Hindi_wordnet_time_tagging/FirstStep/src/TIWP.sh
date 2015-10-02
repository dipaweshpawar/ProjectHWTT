#!/bin/sh
pAccuracy=0.0000
cAccuracy=1.0000
j=0
time="time"
for (( ; $(echo "$pAccuracy < $cAccuracy" | bc -l); ))
do
 j=$(echo "$j+1"|bc)
 time=$time$j
 for (( i=1; i <= 11; i++ ))
 do
	#-------------------------------Training -----------------------------------------------------------
	java -classpath /home/proj/navneet.mtcs14/Hindi_wordnet_time_tagging/weka.jar:/home/proj/navneet.mtcs14/Hindi_wordnet_time_tagging/libsvm.jar weka.classifiers.meta.FilteredClassifier -t /home/proj/navneet.mtcs14/Hindi_wordnet_time_tagging/Expanded_Training_data/NaiveBayes/0gram/trainingSetforAtemporal-TemporalTwoStep_2Class.arff -x 10 -c last -i -d /home/proj/navneet.mtcs14/Hindi_wordnet_time_tagging/Models/SVMx10_iteration$i$time.model -F 'weka.filters.unsupervised.attribute.StringToWordVector -R 1 -W 3000 -N 0 -stemmer weka.core.stemmers.NullStemmer -T -I -M 1 -tokenizer weka.core.tokenizers.WordTokenizer -C'  -W weka.classifiers.functions.LibSVM -- -B >/home/proj/navneet.mtcs14/Hindi_wordnet_time_tagging/Performance/SVM_x10_iteration$i$time.txt
        if [ $i == 1 ] 
	then 
	pAccuracy=$(java -cp /home/proj/navneet.mtcs14/Hindi_wordnet_time_tagging/src/AccuracyFinder.jar AccuracyFinder /home/proj/navneet.mtcs14/Hindi_wordnet_time_tagging/Performance/SVM_x10_iteration$i$time.txt)
        fi
	echo 'iteration' $i$time 'Training over'
	if [ $i == 11 ]
        then
              
         	cAccuracy=$(java -cp /home/proj/navneet.mtcs14/Hindi_wordnet_time_tagging/src/AccuracyFinder.jar AccuracyFinder /home/proj/navneet.mtcs14/Hindi_wordnet_time_tagging/Performance/SVM_x10_iteration$i$time.txt )
        else
  
        
		#------------------------------Training  Over-------------------------------------------------------------------
		#-------------------------------Testing -----------------------------------------------------------------------
		java -classpath /home/proj/navneet.mtcs14/Hindi_wordnet_time_tagging/weka.jar:/home/proj/navneet.mtcs14/Hindi_wordnet_time_tagging/libsvm.jar weka.classifiers.meta.FilteredClassifier -T /home/proj/navneet.mtcs14/Hindi_wordnet_time_tagging/TestData/DatasetInChunks/ngram_data_set$i.arff  -l /home/proj/navneet.mtcs14/Hindi_wordnet_time_tagging/Models/SVMx10_iteration$i$time.model -p 0  > /home/proj/navneet.mtcs14/Hindi_wordnet_time_tagging/Predictions/SVM_iteration$i$time.txt
		echo 'iteration' $i$time 'Testing over';
		#-------------------------------Testing over-------------------------------------------------------------------------------
		#-------------------------------------------------------Expansion of training set------------------
		java -cp /home/proj/navneet.mtcs14/Hindi_wordnet_time_tagging/src/FindInstancesForProbabilisticExpansion.jar FindInstancesForProbabilisticExpansion /home/proj/navneet.mtcs14/Hindi_wordnet_time_tagging/Predictions/SVM_iteration$i$time.txt /home/proj/navneet.mtcs14/Hindi_wordnet_time_tagging/TestData/DatasetInChunks/dataset$i /home/proj/navneet.mtcs14/Hindi_wordnet_time_tagging/Expanded_Training_data/NaiveBayes/0gram/trainingSetforAtemporal-TemporalTwoStep_2Class.arff /home/proj/navneet.mtcs14/Hindi_wordnet_time_tagging/Expanded_Training_data/NaiveBayes/0gram/Temporal_atemporal_seed_words_2Class.txt 8 /home/proj/navneet.mtcs14/Hindi_wordnet_time_tagging/Expansion1_Details/Expansion_Details.txt $i$time >/home/proj/navneet.mtcs14/Hindi_wordnet_time_tagging/Expansion1_Details/Expansion$i$time.txt
		echo 'iteration' $i$time 'Expansion over';
        fi
  done
      		echo 'iteration1 Accuracy=' $pAccuracy 'iteration11 Accuracy=' $cAccuracy

done
echo 'PROCESS OVER'
