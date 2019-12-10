#Readme


##How to use this program
To test a scenario you must run the testing script, you will be prompted for an input:



* input 1 : test image 001 vs image 002 

* input 2 : test image 001 vs image 003 
 
* input 3 : test image 001 vs image 004 
 
* input fire: test image fire01 vs image fire02  

* input oversized : find the size of the over sized vehicle 

* input custom : find the speed and distance of user entered image names (must not contain file extension)  
      * custom(filename1, filename2)


All inputs will prove speed and size except for the oversized scenario which will output only the size as there is no follow up image

### Using the functions separately 
The functions can be used separately their formats are:

* detectSize(image,image)

* findspeed(image)