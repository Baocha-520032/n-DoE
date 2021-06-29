%画图，由于get_max_of_every_dim得到的图震荡严重，尝试只画K为奇数或者K为偶数的k与maxm的图像
clear

load('m_of_RBF_TPS.mat')
n_k=size(K,2);
n_dim=size(m_of_dim,1);
max_m_every_dim=zeros(n_dim,n_k);
K_ou=K(1:2:end);
K_ji=K(2:2:end);
maxm_ou=zeros(n_dim,size(K_ou,2));
maxm_ji=zeros(n_dim,size(K_ji,2));
K_new_of_cusp=cell(n_dim,1);%尖点的Knew
m_new_of_cusp=cell(n_dim,1);%尖点
yhat=zeros(9,59);
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
    maxm_ou(i,:)=max_m_every_dim(i,1:2:end);
    maxm_ji(i,:)=max_m_every_dim(i,2:2:end);
    %开始求尖点
    mj_2=max_m_every_dim(i,1);%尖点的
    mj_1=max_m_every_dim(i,2);%尖点
    idx=1;%尖点
    for j=3:n_k
        mj=max_m_every_dim(i,j);
        if (mj_1>=mj_2)&&(mj_1>=mj)
            %提取出mj_1
            m_new_of_cusp{i,1}(1,idx)=mj_1;
            K_new_of_cusp{i,1}(1,idx)=K(j-1);

            idx=idx+1;
        end
        mj_2=mj_1;
        mj_1=mj;
    end
    %拟合尖点
    xtrain=K_new_of_cusp{i,1}';
    ytrain=m_new_of_cusp{i,1}';
    xtest=K';
    setopt_prs=srgtsPRSSetOptions(xtrain, ytrain); 
    model_prs=srgtsPRSFit(setopt_prs);
    yhat=srgtsPRSPredictor(xtest,xtrain,model_prs);
    
%        type = 'function approximation';
%        [~,~,~,~,~,model] = lssvm(xtrain,ytrain,type);
%        yhat(i,:)=simlssvm(model, xtest);
    
    %开始画图
    figure
    plot(K_ou,maxm_ou(i,:),'-r');%画图k_ou
    hold on
    plot(K_ji,maxm_ji(i,:),'-b');%画图k_ji
    plot(K,max_m_every_dim(i,:),'-g');%所有k
    plot(K_new_of_cusp{i,1}',m_new_of_cusp{i,1}','-r','LineWidth',1.5)%画尖点
    plot(K,yhat,'-k','LineWidth',2)
    formatSpec='max m of D %d';
    str=sprintf(formatSpec,dim(i));
    title(str)
    xlabel('K');
    ylabel('max m');
    legend('K is even number','K is odd number');
    grid on;%添加表格
    set(gca,'xTick',[3:4:70]);%设置坐标轴间隔
    set(gca,'yTick',[0:2:40]);
    axis([0, 70, 0, 40]); 
    
    
end
% for i=1:9
%         figure
%     plot(K_ou,maxm_ou(i,:),'-r');%画图k_ou
%     hold on
%     plot(K_ji,maxm_ji(i,:),'-b');%画图k_ji
%     plot(K,max_m_every_dim(i,:),'-g');%所有k
%     plot(K_new_of_cusp{i,1}',m_new_of_cusp{i,1}','-r','LineWidth',1.5)%画尖点
%     plot(K,yhat(i,:)','-k','LineWidth',2)
%     formatSpec='max m of D %d';
%     str=sprintf(formatSpec,dim(i));
%     title(str)
%     xlabel('K');
%     ylabel('max m');
%     legend('K is even number','K is odd number');
%     grid on;%添加表格
%     set(gca,'xTick',[3:4:70]);%设置坐标轴间隔
%     set(gca,'yTick',[0:2:30]);
%     axis([0, 70, 0, 30]); 
% end