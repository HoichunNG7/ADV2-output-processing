function [] = graphing(filename, stft_wnd_size, time_frag_size, channel_id, sample_rate)
% graphing ����źſ��ӻ�����

% ��ͨ�ź�ʱ��ͼ
data=load(filename);

time=data(:,1);
time = time / sample_rate;
y = data(:,channel_id + 1);
N = size(y);
N = N(1);

plot(time,y)
xlabel('ʱ��/s');
ylabel('λ��/um');title('�ź�ʱ��ͼ');

%STFT��ʱ����Ҷ�任����
y2 = wextend(1, 'sym', y, round(N/2));  % ��������
hop = 1;  % ÿ��ƽ�ƵĲ���
y2 = wkeep1(y2, N+stft_wnd_size);  % �ض�

h = hamming(stft_wnd_size);  % ����������
f = 0:2:200;  % Ƶ�ʿ̶�

[tfr2,f,t2]=spectrogram(y2,h,stft_wnd_size-hop,f,sample_rate);
tfr2=tfr2*2/stft_wnd_size*2;
figure;
imagesc(t2-stft_wnd_size/sample_rate/2,f,abs(tfr2));title('STFTƵ��ͼ');

end