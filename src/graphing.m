function [] = graphing(filename, stft_wnd_size, time_frag_size, channel_id, sample_rate)
% graphing 输出信号可视化函数

% 普通信号时域图
data=load(filename);

time=data(:,1);
time = time / sample_rate;
y = data(:,channel_id + 1);
N = size(y);
N = N(1);

plot(time,y)
xlabel('时间/s');
ylabel('位移/um');title('信号时域图');

%STFT短时傅里叶变换处理
y2 = wextend(1, 'sym', y, round(N/2));  % 镜像延拓
hop = 1;  % 每次平移的步长
y2 = wkeep1(y2, N+stft_wnd_size);  % 截断

h = hamming(stft_wnd_size);  % 海明窗窗长
f = 0:2:200;  % 频率刻度

[tfr2,f,t2]=spectrogram(y2,h,stft_wnd_size-hop,f,sample_rate);
tfr2=tfr2*2/stft_wnd_size*2;
figure;
imagesc(t2-stft_wnd_size/sample_rate/2,f,abs(tfr2));title('STFT频谱图');

end