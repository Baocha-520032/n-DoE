%��ͼ������get_max_of_every_dim�õ���ͼ�����أ�����ֻ��KΪ��������KΪż����k��maxm��ͼ��
clear

load('m_of_RBF_TPS.mat')
n_k=size(K,2);
n_dim=size(m_of_dim,1);
max_m_every_dim=zeros(n_dim,n_k);
K_ou=K(1:2:end);
K_ji=K(2:2:end);
maxm_ou=zeros(n_dim,size(K_ou,2));
maxm_ji=zeros(n_dim,size(K_ji,2));
K_new_of_cusp=cell(n_dim,1);%����Knew
m_new_of_cusp=cell(n_dim,1);%���
yhat=zeros(9,59);
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
    maxm_ou(i,:)=max_m_every_dim(i,1:2:end);
    maxm_ji(i,:)=max_m_every_dim(i,2:2:end);
    %��ʼ����
    mj_2=max_m_every_dim(i,1);%����
    mj_1=max_m_every_dim(i,2);%���
    idx=1;%���
    for j=3:n_k
        mj=max_m_every_dim(i,j);
        if (mj_1>=mj_2)&&(mj_1>=mj)
            %��ȡ��mj_1
            m_new_of_cusp{i,1}(1,idx)=mj_1;
            K_new_of_cusp{i,1}(1,idx)=K(j-1);

            idx=idx+1;
        end
        mj_2=mj_1;
        mj_1=mj;
    end
    %��ϼ��
    xtrain=K_new_of_cusp{i,1}';
    ytrain=m_new_of_cusp{i,1}';
    xtest=K';
    setopt_prs=srgtsPRSSetOptions(xtrain, ytrain); 
    model_prs=srgtsPRSFit(setopt_prs);
    yhat=srgtsPRSPredictor(xtest,xtrain,model_prs);
    
%        type = 'function approximation';
%        [~,~,~,~,~,model] = lssvm(xtrain,ytrain,type);
%        yhat(i,:)=simlssvm(model, xtest);
    
    %��ʼ��ͼ
    figure
    plot(K_ou,maxm_ou(i,:),'-r');%��ͼk_ou
    hold on
    plot(K_ji,maxm_ji(i,:),'-b');%��ͼk_ji
    plot(K,max_m_every_dim(i,:),'-g');%����k
    plot(K_new_of_cusp{i,1}',m_new_of_cusp{i,1}','-r','LineWidth',1.5)%�����
    plot(K,yhat,'-k','LineWidth',2)
    formatSpec='max m of D %d';
    str=sprintf(formatSpec,dim(i));
    title(str)
    xlabel('K');
    ylabel('max m');
    legend('K is even number','K is odd number');
    grid on;%��ӱ��
    set(gca,'xTick',[3:4:70]);%������������
    set(gca,'yTick',[0:2:40]);
    axis([0, 70, 0, 40]); 
    
    
end
% for i=1:9
%         figure
%     plot(K_ou,maxm_ou(i,:),'-r');%��ͼk_ou
%     hold on
%     plot(K_ji,maxm_ji(i,:),'-b');%��ͼk_ji
%     plot(K,max_m_every_dim(i,:),'-g');%����k
%     plot(K_new_of_cusp{i,1}',m_new_of_cusp{i,1}','-r','LineWidth',1.5)%�����
%     plot(K,yhat(i,:)','-k','LineWidth',2)
%     formatSpec='max m of D %d';
%     str=sprintf(formatSpec,dim(i));
%     title(str)
%     xlabel('K');
%     ylabel('max m');
%     legend('K is even number','K is odd number');
%     grid on;%��ӱ��
%     set(gca,'xTick',[3:4:70]);%������������
%     set(gca,'yTick',[0:2:30]);
%     axis([0, 70, 0, 30]); 
% end