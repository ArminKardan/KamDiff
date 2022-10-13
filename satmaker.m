clear all
close all

sat=ncread('ssm_cop_2015-2020_utm33n.nc','ssm');    
sat_data=zeros(42,56,2012)+nan;
fest_data=sat_data;
resid=dlmread('tetar_sit_stazioni.asc','',6,0);
satur=dlmread('tetas_sit_stazioni.asc','',6,0);

fig = figure;

colormap gray
for t=1:size(sat,3)
    mat=sat(:,:,t);
    imagesc(mat,'alphadata',not(isnan(mat)));
    axis off
    path_sat = strcat('./sat/',strcat(int2str(t),'.jpg'));
    hgexport(fig,path_sat,hgexport('factorystyle'),'format','jpeg');
end

