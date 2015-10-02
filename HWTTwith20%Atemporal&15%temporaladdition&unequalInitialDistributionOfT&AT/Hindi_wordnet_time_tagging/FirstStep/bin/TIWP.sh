#!/bin/sh
pAccuracy=0
cAccuracy=1
j=0
time="time"
while[pAccuracy<cAccuracy]
do
 j=$j+1
 time=$time$j
 for (( i=1; i <= 11; i++ ))
 do
	#-------------------------------Training -----------------------------------------------------------
	java -classpath /usr/share/java/weka.jar:/usr/share/java/libsvm.jar weka.classifiers.meta.FilteredClassifier -t /home/dipawesh/workspace/Hindi_wordnet_time_tagging/Expanded_Training_data/NaiveBayes/0gram/trainingSetforAtemporal-TemporalTwoStep_2Class.arff -x 10 -c last -i -d /home/dipawesh/workspace/Hindi_wordnet_time_tagging/Models/SVMx10_iteration$i$time.model -F 'weka.filters.unsupervised.attribute.StringToWordVector -R 1 -W 3000 -N 0 -stemmer weka.core.stemmers.NullStemmer -T -I -M 1 -tokenizer weka.core.tokenizers.WordTokenizer -C'  -W weka.classifiers.functions.LibSVM >/home/dipawesh/workspace/Hindi_wordnet_time_tagging/Performance/SVM_x10_iteration$i$time.txt
        if(i==1) then pAccuracy=$(java -cp /home/dipawesh/workspace/Hindi_wordnet_time_tagging/src/AccuracyFinder.jar AccuracyFinder /home/dipawesh/workspace/Hindi_wordnet_time_tagging/Performance/SVM_x10_iteration$i$time.txt)
        fi
	echo 'iteration' $i$time 'Training over';
	if(i==11)
        then
              
             cAccuracy=$(java -cp /home/dipawesh/workspace/Hindi_wordnet_time_tagging/src/AccuracyFinder.jar AccuracyFinder /home/dipawesh/workspace/Hindi_wordnet_time_tagging/Performance/SVM_x10_iteration$i$time.txt )
             break
        fi
	#------------------------------Training  Over-------------------------------------------------------------------
	#-------------------------------Testing -----------------------------------------------------------------------
	java -classpath /usr/share/java/weka.jar:/usr/share/java/libsvm.jar weka.classifiers.meta.FilteredClassifier -T /home/dipawesh/workspace/Hindi_wordnet_time_tagging/TestData/DatasetInChunks/ngram_data_set$i.arff  -l /home/dipawesh/workspace/Hindi_wordnet_time_tagging/Models/SVMx10_iteration$i$time.model -p 0  > /home/dipawesh/workspace/Hindi_wordnet_time_tagging/Predictions/SVM_iteration$i$time.txt
	echo 'iteration' $i$time 'Testing over';
	#-------------------------------Testing over-------------------------------------------------------------------------------
	#-------------------------------------------------------Expansion of training set------------------
	java -cp /home/dipawesh/workspace/Hindi_wordnet_time_tagging/src/FindInstancesForProbabilisticExpansion.jar FindInstancesForProbabilisticExpansion /home/dipawesh/workspace/Hindi_wordnet_time_tagging/Predictions/SVM_iteration$i$time.txt /home/dipawesh/workspace/Hindi_wordnet_time_tagging/TestData/DatasetInChunks/dataset$i /home/dipawesh/workspace/Hindi_wordnet_time_tagging/Expanded_Training_data/NaiveBayes/0gram/trainingSetforAtemporal-TemporalTwoStep_2Class.arff /home/dipawesh/workspace/Hindi_wordnet_time_tagging/Expanded_Training_data/NaiveBayes/0gram/Temporal_atemporal_seed_words_2Class.txt 8 >/home/dipawesh/workspace/Hindi_wordnet_time_tagging/Expansion1_Details/Expansion$i$time.txt
	echo 'iteration' $i$time 'Expansion over';
 done
done

