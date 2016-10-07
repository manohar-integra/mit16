close all;
clear all;
 
%%
%[x Fs bps] = wavread('..\database\train_003.wav');  
[x Fs bps] = wavread('..\database\no_train_001.wav');

 
%% energy
%Fs = 44100; %sps
freq= 1:10:22060;
framedur = 0.02; %s
overlap = 50; %percent
framelen = framedur * Fs; % samples
 
fftsize = 1024; 
 
numframes = floor( length(x)/(framelen * (100 - overlap)/100) - 2 )
energy = zeros(numframes, 1); %init energy to zero
 
%figure;
saved_Fhf = 0;
for fnum = [1:numframes]
    %stsample = ((fnum-1) * framelen + 1) - (overlap/100)*framelen;
    stsample = floor(((fnum-1) * ( (100 - overlap)/100)*framelen + 1));
    ensample = stsample + framelen;
    
    taxis = [stsample:ensample]/Fs;
    frame = x( stsample : ensample );
 
    %energy
    energy(fnum) = sum (frame.^2);
    
    %high freq energy
    F = abs(fft(frame, fftsize));
    bin5kHz = round(5000*(fftsize/Fs));
    bin8kHz = round(8000*(fftsize/Fs));
    Fhf = F(bin5kHz:bin8kHz);
    energy_hf(fnum) = sum(Fhf.^2);
    
    %correlation between HF spectra of adhjacent frames.
    corrFhf(fnum) = sum(Fhf .* saved_Fhf);
    
    
    saved_Fhf = Fhf;
    
    pause(0.1)
        
end

%% frame level signals
figure;
subplot(311);
plot([1:numframes], energy);
xlabel('frame number')
ylabel('energy')

subplot(312);
plot([1:numframes], energy_hf);
xlabel('frame number')
ylabel('energy hf')

subplot(313);
plot([1:numframes], corrFhf);
xlabel('frame number')
ylabel('corr hf')


%axis([0 35 -30 100]);

