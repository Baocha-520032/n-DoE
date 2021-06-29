%��ͼ������ͬһ��ά�ȵ����к�����ĳһ��kֵ�µ�m�����ֵ��Ȼ����ά����ͼ��һ�����ɾŸ�ͼ
load('m_of_SVM.mat')
n_k=size(K,2);
n_dim=size(m_of_dim,1);
max_m_every_dim=zeros(n_dim,n_k);
for i=1:n_dim
    m_of_dimi=m_of_dim{i,1};
    m_of_dimi=sort(m_of_dimi,'descend');%�������ٸ����ޱȽϣ���������޴󣬾�pass����Ȼ����ʣ������������ֵ
    n_func_of_dimi=size(m_of_dimi,1);%ÿһά���ж��ٸ�����
    for j=1:n_k
        mij=m_of_dimi(:,j);
        Q3=prctile(mij,75);
        Q1=prctile(mij,25);
        IQR=Q3-Q1;
        neixian=Q3+IQR;
        mij = mij( mij<=neixian);
        max_m_every_dim(i,j)=mij(1);
    end
    figure
    plot(K,max_m_every_dim(i,:),'-r');%��������K������������һ��ά�ȵ�����m_end����λ��
    formatSpec='max m of D %d';
    str=sprintf(formatSpec,dim(i));
    title(str)
    xlabel('K');
    ylabel('max m');
    legend('max m');
    grid on;%��ӱ��
    set(gca,'xTick',[3:4:70]);%������������
    set(gca,'yTick',[0:2:30]);
    axis([0, 70, 0, 30]); 
    
end

