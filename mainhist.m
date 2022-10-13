clear all
close all
clc

files = dir('hot_10cm')
fig = figure;
len = length(files);
armin = colormap('gray');
armin(1,:) = [1,1,1];
colormap(armin);
for i=3:len
    if contains(files(i).name, '_SM')
        
        
        name = split(files(i).name,'T');
        name = char(name(1));
        
        %Fetching 10CM
        path_10cm = strcat('./hot_10cm/', files(i).name);
        festmap_10cm=dlmread(path_10cm,'',6,0);
        festmap_10cm(festmap_10cm==-9999)=nan;
        for j=1:numel(festmap_10cm)
            if festmap_10cm(j) < 0
                festmap_10cm(j) = 0;
            end
        end
        imagesc(festmap_10cm,'alphadata',not(isnan(festmap_10cm)));
        axis off
        path_diff = strcat('./hot_10cm_raw_images/',strcat(name,'.jpg'));
        hgexport(fig,path_diff,hgexport('factorystyle'),'format','jpeg');

        %Fetching Originals
        path_org = strcat('./hot_original/', files(i).name);
        festmap_org=dlmread(path_org,'',6,0);
        festmap_org(festmap_org==-9999)=nan;
        for j=1:numel(festmap_org)
            if festmap_org(j) < 0
                festmap_org(j) = 0;
            end
        end
        imagesc(festmap_org,'alphadata',not(isnan(festmap_org)));
        axis off
        path_diff = strcat('./hot_original_raw_images/',strcat(name,'.jpg'));
        hgexport(fig,path_diff,hgexport('factorystyle'),'format','jpeg');
        
        
        
        


        %Show Progress
        disp(strcat('Progress: %', sprintf('%.2f',(100*(i-2)/(len - 2)))))
    end
end

