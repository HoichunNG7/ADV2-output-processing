function [] = graphing(filename, stft_wnd_size, time_frag_size, channel_id, sample_rate)
% graphing 输出信号可视化函数

% 普通信号时域图
data=load(filename);

time=data(:,1);
time = time / sample_rate;
y = data(:,channel_id + 1);
N = size(y);
N = N(1);

subplot(1, 2, 1),plot(time,y);
xlabel('时间/s');
ylabel('位移/um');title('信号时域图');
grid on;

%（逐时间窗口）峰峰值max/avg计算
flag = 0;  % 趋势标志位：0-下降/1-上升
if(y(2) > y(1))
    flag = 1;
end
sample_per_wnd = sample_rate * time_frag_size;  % 单时间窗口采样点数
wnd_count = floor(N / sample_per_wnd);  % 时间窗口总数
max_peak2peak = zeros(1, wnd_count);
avg_peak2peak = zeros(1, wnd_count);
last_peak = y(1);

current_idx = 1;
for i = 1:wnd_count
    max = -1;
    sum = 0;
    peak2peak_count = 0;
    
    current_idx = current_idx + 1;
    for j = 2:sample_per_wnd
        if((y(current_idx) > y(current_idx-1) && (flag == 0))||(y(current_idx) < y(current_idx-1) && (flag == 1)))
            flag = 1 - flag;
            temp = abs(y(current_idx-1) - last_peak);
            last_peak = y(current_idx-1);
            sum = sum + temp;
            peak2peak_count = peak2peak_count + 1;
            
            if(temp > max)
                max = temp;
            end
        end   
        current_idx = current_idx + 1;
    end
    
    max_peak2peak(i) = max;
    avg_peak2peak(i) = sum / peak2peak_count;
end

time2 = 0:time_frag_size:((wnd_count-1) * time_frag_size);
subplot(1, 2, 2),plot(time2, max_peak2peak, '-*r', time2, avg_peak2peak, '-ob');
legend('max peak-to-peak value', 'avg peak-to-peak value');
xlabel('时间/s');
ylabel('峰-峰值/um');
title('逐时间窗口峰峰值统计');
grid on;

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