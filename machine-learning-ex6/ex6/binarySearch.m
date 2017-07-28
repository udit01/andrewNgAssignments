function [ index ] = binarySearch( str , start , last , vocabList, currentI )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
mid = (start+last)/2;
if(strcmp(str,vocabList(mid)==1)
   index = mid;
elseif (uint8( str(currentI) ) <  uint8(vocabList{mid}(currentI)))
    
% elseif

else
end
% HOW DO I COMPLETE IT ... DO I MAKE A CUSTOM STRCMP() FUNCTION I WANT IT C TYPE?


end

