function [dataCell] = readData()
% This function reads the given data from .dat file.
    fid = fopen('sampleData.dat','r');
    dataCell = textscan(fid, '%f%f%f');
    fclose(fid);    
end

