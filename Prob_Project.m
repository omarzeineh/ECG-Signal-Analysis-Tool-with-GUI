clear; clc;
format compact
close all

Fs = 128
n = 7680
Fcb = input('Please enter the cutoff frequency for the highpass filter (0.5Hz-0.6Hz): ');
Fcp = input('Please enter the cutoff frequency for the lowpass filter (50Hz-60Hz): ');

T1 = readmatrix('T1.xls');
T1_s = T1(1:7680, 1);
T1_v1 = T1(1:7680, 2);
T1_v2 = T1(1:7680, 3);

if (Fcb >= 0.5 && Fcb <= 0.6) && (Fcp >= 50 && Fcp <= 60)

F1_v1 = fftshift(fft(T1_v1));
Fd_1 = Fs/n*(-n/2:n/2-1);

% Remove Baseline Drift and noise
FF1_v1 = F1_v1;
for i = [1:n]
    if ((Fd_1(i) <= Fcb && Fd_1(i) >= -Fcb) | (Fd_1(i) <= -Fcp | Fd_1(i) >= Fcp))
        FF1_v1(i) = 0;
    end
end

figure
subplot(2, 1, 1)
plot(T1_s, T1_v1)
title('Time Domain ECG of T1 first reading')

subplot(2, 1, 2)
FT1_v1 = ifft(ifftshift(FF1_v1));
[pks,locs] = findpeaks(FT1_v1, Fs,'MinPeakDistance',0.29, 'MinPeakHeight', 0.1);
plot(T1_s, FT1_v1)
hold on
stem(locs, pks)
title('Time Domain ECG of T1 first reading (removed noise and baseline drift)')
hold off


figure
subplot(2, 1, 1)
plot(Fd_1, abs(F1_v1))
title('Frequency Domain ECG of T1 first reading')

subplot(2, 1, 2)
plot(Fd_1, abs(FF1_v1))
title('Frequency Domain ECG of T1 first reading (removed noise and baseline drift)')


% Find all R-R intervals and store them in an array
RR = [];
for i = 2:length(locs)
    RR(i-1) = locs(i)-locs(i-1);
end

% Find time for each RR interval
RR_s = cumsum(RR) + locs(1);

%claculations for RR interval
Avg_RR = mean(RR)
sd_RR = std(RR)
min_RR = min(RR)
max_RR = max(RR)
diff_min_max = max_RR-min_RR

%calculate heart rate
Heart_Rate = 60./RR; %heart rate for each RR interval
Avg_heart_rate = mean(Heart_Rate)
sd_heart_rate = std(Heart_Rate)

%Time Domain HRV analysis
SDRR = sd_RR
RMSRR = sqrt(mean(RR.^2))

%Frequency Domain HRV analysis
RR_f = fft(RR);
RR_f(1) = 0;
RR_ps = (abs(RR_f).^2)/(length(RR_f).^2);
FsRR = length(RR)/RR_s(length(RR));
Fd_RR = FsRR/length(RR)*(-length(RR)/2:length(RR)/2-1);

figure
subplot(3, 1, 1)
plot(RR_s, RR)
title('RR intervals')
subplot(3, 1, 2)
plot(Fd_RR, abs(RR_f))
title('RR in the frequency domain')

subplot(3, 1, 3)
plot(Fd_RR, abs(RR_ps))
title('Power spectra of RR')


n = length(Heart_Rate);
c = [0.4, -0.4];
noise = sd_heart_rate*rand(n, 1);
synth_heart_rate = zeros(n, 1);
synth_heart_rate(1:2) = Heart_Rate(1:2);
for i = 3:n
    synth_heart_rate(i) = Avg_heart_rate + c*synth_heart_rate(i-2:i-1) + noise(i);
end

figure
subplot(2,1,1)
plot(Heart_Rate)
title('Heart Rate Time Series From The ECG Signal')

subplot(2,1,2)
plot(synth_heart_rate)
title('Heart Rate Time Series Generated Using An Autoregressive Model')

co = corrcoef(Heart_Rate, synth_heart_rate)
rmse = sqrt(sum(mean((Heart_Rate - synth_heart_rate).^2)))

else

disp("Please Enter The Specified Frequencies")
end

%(1:ceil(((500/7860)*length(locs))))
