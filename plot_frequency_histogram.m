% plot frequency histogram频率直方图
%画图，获得每个m出现的次数（频率），汇总40个函数以及5中代理模型方法
%最后每个K值画一个频率分布直方图

% xlabel is m, which is No. DOE
% ylabel is 40个测试函数中，m出现的次数
load('m_of_5_surrogatemodels_of_5rd_data.mat')
n_k=size(K,2);
n_f=size(m_end_krg,1);
xlsfile_2 = 'test_function_for_R2.xlsx';
[dididi] = xlsread(xlsfile_2,1,'A2:E41');
dim=dididi(:,3);
dim=repmat(dim,1,n_k);
m_end_prs=m_end_prs./dim;
m_end_krg=m_end_krg./dim;
m_end_rbf_mq=m_end_rbf_mq./dim;
m_end_rbf_tps=m_end_rbf_tps./dim;
m_end_svm=m_end_svm./dim;

m_collect=[m_end_prs;m_end_krg;m_end_rbf_mq;m_end_rbf_tps;m_end_svm];
for i=1:n_k
   Km = m_collect(:,i);
   TK = tabulate(Km);
   figure
   bar(TK(:,1),TK(:,2))
   formatSpec = 'K = %d';
   str = sprintf(formatSpec,i+1);
   title(str)
   xlabel('DOE次数')
   ylabel('频率')
    
end