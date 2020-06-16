function [fq] = and(fq1,fq2)
%AND Summary of this function goes here
%   Detailed explanation goes here
fq = fq1;
fq.query_string = [fq1.query_string ' and ' fq2.query_string];

end

