# Final Project
## Phishing URL detection
URLs are identified as phishing or legitimate by analyzing the URL features such as lexical features, host-based features etc.  
ID3 decision tree is used for classification. ID3 is a supervised classifier that uses a feature’s entropy value to split the data into left subtree and right subtree.
The entropy/information gain are calculated each time we traverse a branch in the decision tree.

### Data
The dataset has 10000 phishing and 10000 legitimate URLs. The phishing URLs are obtained from the open data set PhishTank and the legitimate URLs are obtained from Alexa.com.  
PhishTank (Link: https://www.phishtank.com/phish_search.php?verified=u&active=y)  
Alexa.com (Link: http://s3.amazonaws.com/alexa-static/top-1m.csv.zip).

### Coding
Python - URL Features are extracted in Python  
Matlab - ID3 Decision Tree is coded in Matlab
