%��ͼ������40��ͼ��ÿ�����Ժ���һ������ K �� m �ĺ���ͼ�񣬼�m����k�ı仯ͼ��
clear
clc
load('5rd_R2end_mEND_of_200DoE_RBF_TPS.mat');
xlsfile_2 = 'test_function_for_R2.xlsx';
[xF,txt] = xlsread(xlsfile_2,1,'A2:E41');
n_func=size(R2_end,1);
n_k=size(K,2);
% %  ����Ϊ�˿� m �� K ��ʲô��ϵ���ǲ��Ǹ�ά���й�ϵ�ģ�Ҳ���ǳ�����ά�Ȼ᲻��
% %  �õ�����ƽ�ȵ�ͼ��Ҳ����M ��K �Ĺ�ϵ�᲻�������һ�㣬���ǲ�û��ʲô��
% %  ���Գ���ά��Ҳûʲô��
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
       grid on;%��ӱ��
       set(gca,'xTick',[3:4:60]);%������������
       set(gca,'yTick',[0:4:50]);
%        eval(sprintf( 'legend(''%s'');',my_FN ));
       axis([0, 60, 0, 50]); % ���������ʾ��Χ
       
    
end

