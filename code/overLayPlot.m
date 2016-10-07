function overLayPlot(fignum, energy, energyFhf, corrFhf, color)

numframes = length(energy); %tbd

figure(fignum);
subplot(311);
hold on;
plot([1:numframes], energy, color);
xlabel('frame number')
ylabel('energy')

subplot(312);
hold on;
plot([1:numframes], energyFhf, color);
xlabel('frame number')
ylabel('energy hf')

subplot(313);
hold on;
plot([1:numframes], corrFhf, color);
xlabel('frame number')
ylabel('corr hf')
