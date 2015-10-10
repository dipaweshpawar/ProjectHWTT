# ProjectHWTT
In this project we are trying to annotate each synset of Hindi Wordnet with time sense it denotes i. e. classifying each synset among five classes which are past, present, future, neutral and atemporal.

Temporality is playing a key role in NLP & IR as time is one of five points which determines document's credibility. Also, time  determines the value of available information. Present research works in this domain are using language dependent constructs  for extracting time related information, e. g. Using keywords like today, now, before, after, etc. But these lists of keywords are limited and may be absent in given context. So our aim is - 

	i.   To provide temporal resource which can be used for effective temporal information retrieval
	ii.  Remove the need of presence of explicit timexes (mention of time) in order to detect temporality of sentence.
	iii. Facilitate research in T-IR

We are using a two step process for classifying entire Hindi Wordnet. In the first step, each synset is classified among two classes, temporal and atemporal. The Temporal  denotes presence of time sense and atemporal denotes its absence. In second step these synsets which are classified as temporal in preceding step are further to be classified among four classes past, present, future, neutral.

 In the training set of each step, seed words  representing corresponding classes are  used. Gloss associated with each synset is the only feature used for classification tasks
