close all;
clear all;
 
%%
x=wavread('..\database\train_001.wav');  
 
%% energy
Fs = 44100; %sps
freq= 1:10:22060;
framedur = 0.05; %s
overlap = 10; %percent
framelen = framedur * Fs; % samples
 
numframes = floor( length(x)/(framelen * (100 - overlap)/100) - 2 )
energy = zeros(numframes, 1); %init energy to zero
 
%figure;
for fnum = [1:numframes]
    %stsample = ((fnum-1) * framelen + 1) - (overlap/100)*framelen;
    stsample = floor(((fnum-1) * ( (100 - overlap)/100)*framelen + 1));
    ensample = stsample + framelen;
    
    taxis = [stsample:ensample]/Fs;
    frame = x( stsample : ensample );
 
    %energy
    energy(fnum) = sum (frame.^2);
   
    
    %if fnum == 17
       % plot(taxis, frame);
   % end
    pause(0.1)
        
end

%% frame level signals
figure;
plot([1:numframes], energy);
xlabel('frame number')
ylabel('energy')
%axis([0 35 -30 100]);

