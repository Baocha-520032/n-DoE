%画图，画同一维度中位数的拟合曲线，目前均使用PRS拟合，次数为3次
load('m_of_RBF_TPS.mat')
model_save=cell(9,1);
for i=1:9
    ytrain=medianm_of_same_dim_of40func(i,:)';
    xtrain=K';
    xtest=K';
           
            setopt_prs=srgtsPRSSetOptions(xtrain, ytrain,2,'Full');
%             setopt_prs=srgtsPRSSetOptions(xtrain, ytrain); 
            model_prs=srgtsPRSFit(setopt_prs);
            yhat=srgtsPRSPredictor(xtest,xtrain,model_prs);
%             setopt_rbf=srgtsRBFSetOptions(xtrain, ytrain,@rbf_build,'MQ',0.1363,0);
%             model_rbf=srgtsRBFFit(setopt_rbf);
%             yhat=srgtsRBFEvaluate(xtest,model_rbf);
%     yhat=ceil(yhat);
    model_save{i,1}=model_prs;                   
    figure
    plot(K,yhat,'-r')
    formatSpec='fit m of D %d of RBF_TPS';
    str=sprintf(formatSpec,dim(i));
    title(str)
    xlabel('K');
    ylabel('fit m');
%     legend('median m');
    grid on;%添加表格
    set(gca,'xTick',[3:4:60]);%设置坐标轴间隔
    set(gca,'yTick',[0:2:20]);
    axis([0, 60, 0, 20]);
end
