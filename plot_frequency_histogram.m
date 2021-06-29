% plot frequency histogramƵ��ֱ��ͼ
%��ͼ�����ÿ��m���ֵĴ�����Ƶ�ʣ�������40�������Լ�5�д���ģ�ͷ���
%���ÿ��Kֵ��һ��Ƶ�ʷֲ�ֱ��ͼ

% xlabel is m, which is No. DOE
% ylabel is 40�����Ժ����У�m���ֵĴ���
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
   xlabel('DOE����')
   ylabel('Ƶ��')
    
end