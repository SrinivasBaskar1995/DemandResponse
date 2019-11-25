avg = sum(predicted(1,1:24))/24;
peak=0;
offpeak=0;
for i=1:24
    if(predicted(1,i)>avg)
        peak=peak+(predicted(1,i)-avg)*60*60;
    else
        offpeak=offpeak+(-predicted(1,i)+avg)*60*60;
    end
end