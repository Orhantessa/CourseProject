Uploading from .txt:
1) Test
      test_y : data frame for all activities
      test_x : data frame for all measurments
      test_subj : data frame for all subjects
2) Train
      train_y : data frame for all activities
      train_x : data frame for all measurments
      train_subj : data frame for all subjects 



Additional Variables:
1) Test
      test_nc : width of measurments
      test_nr : length of measurments
      test_mean : means of each measurment
      test_stDiv : standard deviations of each measurmant
      test : cleaned data frame for test variables
      test_subjMean : means for each subject
      test_subjStDiv : standard deviations for each subject
      test_actMean : means for each activity
      test_actStDiv : standard deviations for each activity
2) Train
      train_nc : width of measurments
      train_nr : length of measurments
      train_mean : means of each measurment
      train_stDiv : standard deviations of each measurmant
      train : cleaned data frame for test variables
      train_subjMean : means for each subject
      train_subjStDiv : standard deviations for each subjec
      train_actMean : means for each activity
      train_actStDiv : standard deviations for each activity
3) Data Sets
      merderSet_bySubject : merged by subject data set
      MeanAverage : set of all average means for each activity and subject      
      StDivAverage : set of all average standard deviations for each activity and subject
      tidyDataSet : combination of average means and average standard deviations for each activity and subject



Functions:
      for (i in 1:test_nr) : Test : calculating means and standard deviations for each measurment + replacing activities numbers with names

      for (i in 1:train_nr) : Train : calculating means and standard deviations for each measurment + replacing activities numbers with names

      write.table : extracting tidy data set into TidyDataSet.txt