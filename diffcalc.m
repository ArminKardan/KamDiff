clear all
close all
clc

files = dir('10_cm')
fig = figure;
len = length(files);
for i=3:len

    %Fetching 10CM
    path_10cm = strcat('./10_cm/', files(i).name);
    festmap_10cm=dlmread(path_10cm,'',6,0);
    festmap_10cm(festmap_10cm==-9999)=nan;
    for j=1:numel(festmap_10cm)
        if festmap_10cm(j) < 0
            festmap_10cm(j) = 0;
        end
    end
    
    
    %Fetching Originals
    path_org = strcat('./Original/', files(i).name);
    festmap_org=dlmread(path_org,'',6,0);
    festmap_org(festmap_org==-9999)=nan;
    for j=1:numel(festmap_org)
        if festmap_org(j) < 0
            festmap_org(j) = 0;
        end
    end
    
    %Calculating Diffs
    festmap_diff = festmap_org - festmap_10cm;
    name = split(files(i).name,'T');
    name = string(name(1));
    imagesc(festmap_diff,'alphadata',not(isnan(festmap_diff)));
    path_diff = strcat('./Diffs/',strcat(name,'.jpg'));
    hgexport(fig,path_diff,hgexport('factorystyle'),'format','jpeg');
    
    %Show Progress
    disp(strcat('Progress: %', sprintf('%.2f',(100*(i-2)/(len - 2)))))
end

