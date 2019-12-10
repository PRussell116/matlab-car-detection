%--------------------------------------------------------------------------




%for instructions on how to use this test script please refer to the readme


%--------------------------------------------------------------------------
close all
prompt = 'Input the secnario you would like to test';
userInput = input(prompt,'s');

testOut = testCases(userInput);
disp(testOut); 

function testOutput = testCases(userInput)
carSpeeding = "false";
carOversize = "false";

if(userInput == "1")
    %case one compare speed of 001 vs 002 
    carSpeeding = findspeed('001.jpg','002.jpg');
    carOversize =detectSize('001.jpg');

 %case two compare speed of 001 vs 003 
elseif(userInput == "2")
     carSpeeding = findspeed('001.jpg','003.jpg');
    carOversize =detectSize('001.jpg');
    
  %case one compare speed of 001 vs 004    
elseif(userInput == "3")
     carSpeeding = findspeed('001.jpg','004.jpg');
    carOversize =detectSize('001.jpg');
    
    
elseif(userInput == "fire")
     carSpeeding = findspeed('fire01.jpg','fire02.jpg');
    carOversize =detectSize('fire01.jpg');
    
elseif(userInput == "oversized")
     
     carOversize =detectSize('oversized.jpg');
     
  %compare 2 user inputted file names must not include .jpg   
elseif(userInput == "custom")
    prompt = 'Input the first image name';
    im1 = input(prompt,'s')+".jpg";
    
    
    prompt = 'Input the second image name';
    im2 = input(prompt,'s') + ".jpg";
    
    
    carSpeeding = findspeed(im1,im2);
    carOversize =detectSize(im1');

end
%caroversize(2) contains the value for if it is a fire engine
%caroversize(3) contains the value for the color
%caroversize(4) contains rgb value of the vechile
if (carOversize(2) == "false")
    testOutput = "Speeding:" + carSpeeding + " Oversized:" + carOversize(1) + " Color:" + carOversize(3);
else
    testOutput = "this is a fire engine does not need to follow rules";
end

end