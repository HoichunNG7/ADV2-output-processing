# ADV2-output-processing
## 基本信息
* Output data processing MATLAB program for YXDAQ-LV1000, an eddy current displacement sensor.
* （南京研旭电气科技有限公司）电涡流位移传感器YXDAQ-LV1000输出数据处理与图像绘制。

## 输入参数
1. filename 信号文件相对路径(输入的ADV2信号文件须为txt格式)
2. stft_wnd_size STFT窗口大小
3. time_frag_size 图表3&4时间窗口大小
4. channel_id 使用通道序号
5. sample_rate 采样率

## 输出图表
1. 输出信号时域图
2. 短时傅里叶变换(STFT)时频图
3. (逐时间窗口计算)峰峰值的最大值/平均值
4. (逐时间窗口计算)直流分量大小 -> 用于校准比对

## 相关配置
* 配套交互软件为ADV2.exe
