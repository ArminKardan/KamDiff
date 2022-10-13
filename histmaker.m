clear all
close all
clc

files = dir('hot_10cm_raw_images')
%fig = figure;
len = length(files);

raw_10cm = cell(1,len);
raw_org = cell(1,len);


for i=3:len
    path10cm = strcat('./hot_10cm_raw_images/',files(i).name);
    pathorg = strcat('./hot_original_raw_images/',files(i).name);
    raw_10cm(i-2) = {imread(path10cm)};
    raw_org(i-2) = {imread(pathorg)};
    %Show Progress
    disp(strcat('Progress1: %', sprintf('%.2f',(100*(i-2)/(len - 2)))))
end

files_sat = dir('sat_raw_images');
len2 = length(files_sat);
raw_sat = cell(1,len2);
for i=3:len2
    raw_sat(i-2) = {imread(strcat('./sat_raw_images/',strcat(int2str(i - 2),'.jpg')))};
    %Show Progress
    disp(strcat('Progress2: %', sprintf('%.2f',(100*(i-2)/(len2 - 2)))))
end

len3 = min(len,len2)
for i = 1:len3
    close all
    fig = figure
    value = cell2mat(raw_10cm(i));
    subplot(2,2,1)
    [counts, grayLevels] = imhist(value(value~=255),20);
    bar(grayLevels, counts, 'BarWidth', 1);
    
    hold on ;
    value = cell2mat(raw_org(i));
    subplot(2,2,2)
    [counts, grayLevels] = imhist(value(value~=255),20);
    bar(grayLevels, counts, 'BarWidth', 1);
    
    value = cell2mat(raw_sat(i));
    hold on ;
    subplot(2,2,3)
    [counts, grayLevels] = imhist(value(value~=255),20);
    bar(grayLevels, counts, 'BarWidth', 1);
    path_hist = strcat('./histograms/', files(i+2).name);
    hgexport(fig,path_hist,hgexport('factorystyle'),'format','jpeg');
    
    %Show Progress
    disp(strcat('Progress3: %', sprintf('%.2f',(100*(i-2)/(len3 - 2)))))
end

