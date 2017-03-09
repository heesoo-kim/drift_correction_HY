function [output good_z] = correct_drift(d, file_start, file_end, starting_z)
% functio [output, good_z] = 
%        correct_drift(d, file_start, file_end, starting_z)
% Input values:
%   d: the directory where all the tiff file are
%   file_start: the # of the first time point (e.g. 0)
%   file_end: the # of the last time point (e.g. 449)
%   starting_z: an array of the "correct" slices for first time point (e.g.
%   starting_z = [1 2 3 4 5];)
% Output values:
%   output: the difference values for each time point (compared to the
%   average between the preceeding timepoint and the first timepoint).
%
% This script goes through all the time points in directory d (as defined
% by file_start & file_end) and decides what the "good_z" values should be
% based on a comparison with the preceeding timepoint and the first
% timepoint.

tic
% go the correct directory
cd(d)

% get size of figures.
INFO = imfinfo(helper_func(file_start));
file_max = length(INFO);


smoothing_factor = ones(5,5)/25;
%smoothing_factor = ones(10,10)/100;

% read in the first files - the baseline
for z = 1:length(starting_z)
    temp = imread(helper_func(file_start), starting_z(z));
    temp = conv2(double(temp),smoothing_factor);
    first_img{z} = temp(:);
end


good_z(1,:) = starting_z;
counter = 2;
% Go from the first file to the last file
for i = file_start:file_end-1
    % Get the filenames:
    f_pre = helper_func(i);
    f_post = helper_func(i+1);
    
    if mod(i,25) == 0
        t = toc;
        disp(['File is at ' f_post '  time elapsed: ' num2str(t)])
    end
    
    %output_name = ['s_' f_post];
    
    % For the pre image, go through all the good z's:
    for z = 1:length(starting_z)
        
        curr_z = starting_z(z);
        
        curr_pre = imread(f_pre,curr_z);
        curr_pre = conv2(double(curr_pre),smoothing_factor);
        curr_pre = curr_pre(:);
        
        % Get the first image:
        curr_first = first_img{z};
        
        % difference window:
        diff_wind = [-1 0 1];
        % going through the difference window:
        for w = 1:3
            val = curr_z + diff_wind(w);
            
            if val > 0 & val <=file_max
                temp = imread(f_post,val);
                temp = conv2(double(temp),smoothing_factor);
                temp = temp(:);
            
                %V(z,w) = abs(mean(temp-curr_pre));
                V(z,w) = abs(mean(temp-((curr_pre+curr_first)/2)));
            end
        end
                
    end
 
    [min_val min_inx] = min(mean(V(2:end-1,:))); % might want to edit this...
    %V
    starting_z = starting_z + diff_wind(min_inx);
    
    if starting_z(1) == 0
        starting_z = starting_z + 1;
    end
    
    if starting_z(end) > file_max
        starting_z = starting_z - 1;
    end
    
    output{counter} = V;
    good_z(counter,:) = starting_z;
    counter = counter+1;
end

function output = helper_func(num)
if num < 10
    output = ['00' num2str(num) '.tiff'];
elseif num < 100
    output = ['0' num2str(num) '.tiff'];
else
    output = [num2str(num) '.tiff'];
end
            