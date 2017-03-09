
d = dir;

for i = 1:length(d)
    n = d(i).name;
    inx = strfind(n,'00.tif');
    if ~isempty(inx)
        system(['mv ' n ' ' n([1:inx-1 inx+2:end])]);
    end
end