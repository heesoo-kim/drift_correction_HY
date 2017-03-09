function write_out_time_series(good_z, d, file_start, file_end)
% function write_out_time_series(good_z, d, file_start, file_end
% Inputs:
%   good_z: a matrix telling the "good Z value" for each time point.
%   (output of correct_drift)
%   d: the directory you are currently looking at.
%   file_start: the # of the first time point (e.g. 0)
%   file_end: the # of the last time point (e.g. 449)
% This scripts goes through all the file_start to file_end tiff files in
% directory d and writes out a new tiff file for each Z level.

% go to the given directory.
cd(d)

% go through each z.
for z = 1:size(good_z,2)
    % Get Z_array
    array_z = good_z(:,z);
    % define name of file
    output_name = ['s_' helper_func(z)];
    
    % Go through each time point
    for i = file_start:file_end
        % Get current z value
        curr_z = array_z(i+1);
        
        % Get current tiff file name
        f_name = [helper_func(i) 'f'];
        
        % read in the correct z plane
        curr_img = imread(f_name,curr_z);
        
        % write out the file.
        imwrite(curr_img,output_name,'WriteMode','append');
    end
end

function output = helper_func(num)
if num < 10
    output = ['00' num2str(num) '.tif'];
elseif num < 100
    output = ['0' num2str(num) '.tif'];
else
    output = [num2str(num) '.tif'];
end

