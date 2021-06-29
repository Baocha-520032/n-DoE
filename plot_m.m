%画图，最后出40个图，每个测试函数一个，是 K 与 m 的函数图像，即m随着k的变化图像
clear
clc
load('5rd_R2end_mEND_of_200DoE_RBF_TPS.mat');
xlsfile_2 = 'test_function_for_R2.xlsx';
[xF,txt] = xlsread(xlsfile_2,1,'A2:E41');
n_func=size(R2_end,1);
n_k=size(K,2);
% %  这是为了看 m 和 K 有什么关系，是不是跟维度有关系的，也就是除以了维度会不会
% %  得到更加平稳的图像，也就是M 和K 的关系会不会更清晰一点，但是并没有什么用
% %  所以除以维度也没什么用
% xlsfile_2 = 'test_function_for_R2.xlsx';
% [dididi] = xlsread(xlsfile_2,1,'A2:E41');
% dim=dididi(:,3);
% dim=repmat(dim,1,n_k);
% m_end=m_end./dim; 

for i=1:n_func
    M=m_end(i,:);
    
    figure
       plot(K,M,'-r');
       xlabel('K');
       ylabel('m');
     legend('m of function ');
       grid on;%添加表格
       set(gca,'xTick',[3:4:60]);%设置坐标轴间隔
       set(gca,'yTick',[0:4:50]);
%        eval(sprintf( 'legend(''%s'');',my_FN ));
       axis([0, 60, 0, 50]); % 坐标轴的显示范围
       
    
end

