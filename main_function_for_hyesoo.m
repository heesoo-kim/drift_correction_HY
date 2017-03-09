pdir = 'Hyesoo';

% % CROP_17
% d = 'crop_17/';
% file_start = 0;
% file_end = 449;
% starting_z = [1 2 3 4 5];


% % CROP_1
% d = 'crop_1/';
% file_start = 0;
% file_end = 549;
% starting_z = [1 2 3 4];


% % CROP_2
% d = 'crop_2/';
% file_start = 0;
% file_end = 549;
% starting_z = [1 2 3 4 5];

% % CROP_3
% d = 'crop_3/';
% file_start = 0;
% file_end = 549;
% starting_z = [1 2 3 4 5];

% % CROP_8
% d = 'crop_8/';
% file_start = 0;
% file_end = 449;
% starting_z = [1 2 3 4 5 6];

% CROP_23
d = 'crop_23/';
file_start = 0;
file_end = 449;
starting_z = [1 2 3 4 5 6 7 8];






[output good_z] = correct_drift(d, file_start, file_end, starting_z);

save good_z good_z
imagesc(good_z)
colorbar

cd(pdir)
write_out_time_series(good_z, d, file_start, file_end);
cd(pdir)
