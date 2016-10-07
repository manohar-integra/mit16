
[x1 Fs bps] = wavread('..\database\no_train_001.wav');
[energy energyFhf corrFhf] = getFrameLevelFeatures(x1, Fs);
overLayPlot(1, energy, energyFhf, corrFhf, 'b');

[x2 Fs bps] = wavread('..\database\train_003.wav');  
[energy energyFhf corrFhf] = getFrameLevelFeatures(x2, Fs);
overLayPlot(1, energy, energyFhf, corrFhf, 'r');


