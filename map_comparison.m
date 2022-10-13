clear all
close all

sat=ncread('ssm_cop_2015-2020_utm33n.nc','ssm');    sat_data=zeros(42,56,2012)+nan;
fest_data=sat_data;
resid=dlmread('tetar_sit_stazioni.asc','',6,0);
satur=dlmread('tetas_sit_stazioni.asc','',6,0);

n=0;
for t=1:size(sat,3)
    % satellite data
    mat=sat(:,:,t);
    sat_data(:,:,t)=rot90(mat);   % matrix rotation
    sat_data(:,:,t)=sat_data(:,:,t)/100.*(satur-resid)+resid;  % %Sat > m3 m-3
    datapoints=sum(sum(not(isnan(mat))));
    
    
    
    % FEST-EWB data
    date=datetime(2014,12,31)+t;
    %date
    if date<=datetime(2019,9,25)
    festname=strcar('./hot_original', strcat(datestr(date,'yyyy-mm-dd'),'T11-00-00_SM.asc'));
    festmap=dlmread(festname,'',6,0);
    %festmap(festmap==-9999)=nan;
    fest_data(:,:,t)=festmap;
    %if datapoints>0
        % .jpg printing
      delta=fest_data(:,:,t);%-sat_data(:,:,t);
        %delta=sat_data(:,:,t);
        %colorMap = [linspace(0,1,256)', zeros(256,2)]
        %colormap(colorMap);
        %colormap autumn
        armin = colormap('parula');
        armin(1,:) = [1,1,1];
        colormap(armin);
        imagesc(delta,'alphadata',not(isnan(delta)))
        %title('Soil Moisture-FEST');
        %xlabel(strcat('',datestr(date,'yyyy-mm-dd')));
        ax=gca;ax.XAxis.TickValues=[];ax.YAxis.TickValues=[];
        figname=strcat('fest_raw\', datestr(date,'yyyy-mm-dd'));
        %colorbar;ax.CLim=[-0.5 0.5];
       saveas(gcf,figname,'jpg')
        close all
        disp(figname);
      %time difference retrieval
       %n=n+1;
        %delta2=delta(:);
        %avg(n)=nanmean(delta2);
        %stdev(n)=nanstd(delta2);
        %datewithdata(n)=date;
    end
    end
    %end
    
    
 %% time plot
figure;
ee=scatter(datewithdata,avg,...
    'MarkerEdgeColor',[0 82 192]/255,...
    'MarkerFaceColor',[0 82 192]/255,...
    'MarkerFaceAlpha',0.5);
ylim([-0.5,0.5]);   hold on
plot(datewithdata,zeros(size(datewithdata)),...
    'Color',zeros(1,3)+0.35);
box on
%close all

%% comparison
deltatot=fest_data-sat_data;
delta_avg=nanmean(deltatot,3);
figure
imagesc(delta_avg,'alphadata',not(isnan(delta_avg)))
ax=gca;ax.XAxis.TickValues=[];ax.YAxis.TickValues=[];
colorbar;ax.CLim=[-0.5 0.5];

saveas(gcf,'global_average_difference','jpg');
%% 


%close all