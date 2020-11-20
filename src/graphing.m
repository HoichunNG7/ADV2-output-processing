function [] = graphing(filename, stft_wnd_size, time_frag_size, channel_id, sample_rate)
% graphing 输出信号可视化函数

% 普通信号时域图
data=load(filename);

time=data(:,1);
time = time / sample_rate;
y = data(:,channel_id + 1);

plot(time,y)
xlabel('时间/s');
ylabel('位移/um');title('信号时域图');
end

