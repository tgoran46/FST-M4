--LOAD input file from HDFS
inputFile = LOAD 'hdfs:///user/thriveni/textInput.txt' AS (line);
--Tokenize each word in the file (Map)
words = FOREACH inputFile GENERATE FLATTEN(TOKENIZE(line)) AS word;
--GROUP BY WORD
grouped = GROUP words BY word;
--Count the number of words
counted = FOREACH grouped GENERATE group, COUNT(words);
--Store output in HDFS
STORE counted INTO 'hdfs:///user/thriveni/pigOutput';
