%画图，先求同一个维度的所有函数在某一个k值下的m的最大值，然后按照维度作图，一共生成九个图
load('m_of_SVM.mat')
n_k=size(K,2);
n_dim=size(m_of_dim,1);
max_m_every_dim=zeros(n_dim,n_k);
for i=1:n_dim
    m_of_dimi=m_of_dim{i,1};
    m_of_dimi=sort(m_of_dimi,'descend');%先排序，再跟内限比较，如果比内限大，就pass掉，然后找剩下所有项的最大值
    n_func_of_dimi=size(m_of_dimi,1);%每一维度有多少个函数
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
    plot(K,max_m_every_dim(i,:),'-r');%横坐标是K，纵坐标是这一个维度的所有m_end的中位数
    formatSpec='max m of D %d';
    str=sprintf(formatSpec,dim(i));
    title(str)
    xlabel('K');
    ylabel('max m');
    legend('max m');
    grid on;%添加表格
    set(gca,'xTick',[3:4:70]);%设置坐标轴间隔
    set(gca,'yTick',[0:2:30]);
    axis([0, 70, 0, 30]); 
    
end

