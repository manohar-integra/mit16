function [energy energyFhf corrFhf] = getFrameLevelFeatures(x, Fs)
 
%% energy
framedur = 0.02; %s
overlap = 50; %percent
framelen = framedur * Fs; % samples
 
fftsize = 1024; 
 
numframes = floor( length(x)/(framelen * (100 - overlap)/100) - 2 )
energy = zeros(numframes, 1); %init energy to zero
 
%figure;
saved_Fhf = 0;
for fnum = [1:numframes]
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
    energyFhf(fnum) = sum(Fhf.^2);
    
    %correlation between HF spectra of adhjacent frames.
    corrFhf(fnum) = sum(Fhf .* saved_Fhf);
    
    saved_Fhf = Fhf;
end

