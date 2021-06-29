%获得尖点
load('m_of_RBF_TPS.mat')
n_dim=size(m_of_dim,1);
K_new_of_cusp=cell(n_dim,1);
m_new_of_cusp=cell(n_dim,1);
for i=1:n_dim
    n_k=size(K,2);
    mj_2=medianm_of_same_dim_of40func(i,1);
    mj_1=medianm_of_same_dim_of40func(i,2);
    idx=1;
    for j=3:n_k
        mj=medianm_of_same_dim_of40func(i,j);
        if (mj_1>=mj_2)&&(mj_1>=mj)
            %提取出mj_1
            m_new_of_cusp{i,1}(1,idx)=mj_1;
            K_new_of_cusp{i,1}(1,idx)=K(j-1);

            idx=idx+1;
        end
        mj_2=mj_1;
        mj_1=mj;
    end
    
    figure
    plot(K_new_of_cusp{i,1}',m_new_of_cusp{i,1}','-r','LineWidth',2)
    hold on
    plot(K,medianm_of_same_dim_of40func(i,:),'-b');
    formatSpec='cusp m of D %d of SVM';
    str=sprintf(formatSpec,dim(i));
    title(str)
    xlabel('K');
    ylabel('fit m');
%     legend('median m');
    grid on;%添加表格
    set(gca,'xTick',[3:4:60]);%设置坐标轴间隔
    set(gca,'yTick',[0:2:30]);
    axis([0, 60, 0, 30]);
    
    
    
end