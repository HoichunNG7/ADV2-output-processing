function [] = graphing(filename, stft_wnd_size, time_frag_size, channel_id, sample_rate)
% graphing ����źſ��ӻ�����

% ��ͨ�ź�ʱ��ͼ
data=load(filename);

time=data(:,1);
time = time / sample_rate;
y = data(:,channel_id + 1);

plot(time,y)
xlabel('ʱ��/s');
ylabel('λ��/um');title('�ź�ʱ��ͼ');
end

