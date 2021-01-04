#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sat Jan  2 11:56:16 2021

@author: avery
"""

import os 
import pandas as pd


#os.getcwd()
os.chdir('/Users/avery/Desktop/D-Lab_Fellow/HIV_narative')

# read in data. 
data_one = pd.read_table('NoMoreSilence_ProjectData.tsv')
# convert to df. 

# check column values. 
# for col in data_one.columns:
#  print(col)
 
# check categories of collection data type, "text or image"    
# data_one.Type.unique()

# Select text, could specify just text or ' ' rows. 
#data_two = data_one[(data_one.Type == 'text') | (data_one.Type == ' ')]

#convert to string
ocr = data_one['Ocr text'].to_string()

# regular expressions and cleaning tasks. 
import re
digit_pattern = '\d+'
whitespace_pattern = r'\s+'
single_letter_pattern = r'\b\w\b'


clean = re.sub(digit_pattern, '', ocr)
clean = re.sub('\n', '', clean)
clean = re.sub('·', '', clean)
clean = re.sub('•', '', clean)
clean = re.sub('«', '', clean)
clean = re.sub('»', '', clean)
clean = re.sub('—', '', clean)
clean = re.sub('■', '', clean)

# punctuation 
from string import punctuation
no_punct = ''.join([ch for ch in clean if ch not in punctuation])

# strip whitespace and lower. 
clean_text = re.sub(whitespace_pattern, ' ', no_punct)
clean_text = clean_text.strip().lower()
clean_text = re.sub('pgnbr', '', clean_text)
clean_text = re.sub(single_letter_pattern, ' ', clean_text).strip()


# tokenize 
from nltk.tokenize import word_tokenize
tokens = word_tokenize(clean_text)


# remove stop words
from nltk.corpus import stopwords
import nltk
nltk.download('stopwords')
stop = stopwords.words('english')

# for loop removing stop words
tokens_stopped = []
for token in tokens:
    if token not in stop:
        tokens_stopped.append(token)
  
tokens_stopped

# Count most common words. 
from collections import Counter
freq = Counter(tokens_stopped)


# Reomving out of vocalbulary word. 
OOV = 'OOV'
tokens_done = []
for token in tokens_stopped:
    if freq[token] == 1:
        tokens_done.append(OOV)
    else:
        tokens_done.append(token)


while OOV in tokens_done:
    tokens_done.remove(OOV)


# check frequencies.      
freq_2 = Counter(tokens_done)
freq_2.most_common(30)   
        

tokens_done
joined_string = ", ".join(tokens_done)

        
# write file to eyeball, evaluate. 
text_file = open('ocr_text.txt', 'w')
text_file.write(joined_string)
text_file.close()

# Note: so far there are many words shmooshed together, not sure if pre-processing or ocr error. 



