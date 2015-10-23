#---------------------------------------Reordering----------------------------------------
#-------------------------------------------------------------------------------------------
java -classpath /usr/share/java/weka.jar weka.filters.unsupervised.attribute.Reorder -R 2-last,1  -i  /home/dipawesh/workspace/Hindi_wordnet_time_tagging/Expanded_Training_data/NaiveBayes/Ngram/ngram_trainingSetforAtemporal-TemporalOneStep_set_iteration10.arff  -o  /home/dipawesh/workspace/Hindi_wordnet_time_tagging/Expanded_Training_data/NaiveBayes/Ngram/ngram_trainingSetforAtemporal-TemporalOneStep_set_iteration10_reordered.arff
#--------------------------------------------------------------------------------------------------
java -classpath /usr/share/java/weka.jar weka.filters.unsupervised.attribute.Reorder -R 2-last,1  -i /home/dipawesh/workspace/Hindi_wordnet_time_tagging/TestData/DatasetInChunks/Ngram/ngram_data_output_set1.arff  -o /home/dipawesh/workspace/Hindi_wordnet_time_tagging/TestData/DatasetInChunks/Ngram/ngram_data_output_set1_reordered.arff
#10th iteration of training --Train Naive Bayes on udated ngram_trainingSetforAtemporal-TemporalOneStep_set with x=5 
#---------------------------------------------------------------------------------------
java -cp /usr/share/java/weka.jar weka.classifiers.bayes.NaiveBayes -t /home/dipawesh/workspace/Hindi_wordnet_time_tagging/Expanded_Training_data/NaiveBayes/Ngram/ngram_trainingSetforAtemporal-TemporalOneStep_set_iteration10_reordered.arff -x 10 -c last -i -K -d /home/dipawesh/workspace/Hindi_wordnet_time_tagging/Models/OneStep/NaiveBayesx6Training_iteration11_2ndtime.model > /home/dipawesh/workspace/Hindi_wordnet_time_tagging/Performance/NaiveBayes_iteration11_TS_x10_2ndtime.txt


