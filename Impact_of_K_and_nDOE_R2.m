%最重要的主程序，用于计算拟合后的40个函数的预测点的预测值yhat，能得到稳定R2时需要重复多少次DOE的次数m，以及R2，并将其存下来
% K值表示，训练点数为 k*dim（维度）
clear all
close all
clc

load('data_save\data_doe_maxm200_5rd_1000ntest.mat');
load('data_save/data_xtest_5rd_1000ntest.mat');

xlsfile_2 = 'test_function_for_R2.xlsx';
% [xF,txt] = xlsread(xlsfile_2,1,'A38:E41');
[xF,txt] = xlsread(xlsfile_2,1,'A2:E41');


[n_f,n_k]=size(DoE_xDATA);% K  nDoE
m=zeros(n_f,n_k);
R2_end=zeros(n_f,n_k);
m_end=zeros(n_f,n_k);
yhat_save=cell(n_f,n_k);
R2_save=cell(n_f,n_k);
R2_mean_save=cell(n_f,n_k);%R2_mean表示前几项的R2的平均值

for nf=1:n_f    %访问某个 函数
    func=txt{nf,1};
    eval(sprintf( 'my_FN=@%s;',func ));
    %  my_FN = str2func(txt{nf,1}); 
    for nk=1:n_k  %访问某个 K 的值
        k=K(nk);

        deta_mean_R2=1;
        R2=[];
        R2_mean=[];
        nidx=1;
%         yhat_m_change=cell(n,1);%中间存的
        yhat_m_change=cell(nidx,1);
        R2_m_change=[];%中间存的
        R2_mean_m_change=[];%中间存的
        while abs(deta_mean_R2)>0.001 && nidx<=nDoE %迭代终止条件精度为千分之一
            %获取训练点
            xtrain=DoE_xDATA{nf,nk}{1,nidx};
            ytrain=feval(my_FN,xtrain);
            %获取测试点
            xtest=test_xDATA{nf,1};
            ytest=test_xDATA{nf,2};
            %kriging拟合，获取测试点处的预测值
            setopt_krg1=srgtsKRGSetOptions(xtrain, ytrain);
            model_krg1= srgtsKRGFit(setopt_krg1);
            yhat = srgtsKRGPredictor(xtest,model_krg1);
            %PRS拟合，获取测试点处的预测值
%             setopt_prs=srgtsPRSSetOptions(xtrain, ytrain);
%             model_prs=srgtsPRSFit(setopt_prs);
%             yhat=srgtsPRSPredictor(xtest,xtrain,model_prs);
            %RBF_MQ拟合，获取测试点的预测值
%             setopt_rbf=srgtsRBFSetOptions(xtrain, ytrain,@rbf_build,'MQ',0.1363,0);
%             model_rbf=srgtsRBFFit(setopt_rbf);
%             yhat=srgtsRBFEvaluate(xtest,model_rbf);
            %RBF_TPS拟合，获取测试点的预测值
%             setopt_rbf=srgtsRBFSetOptions(xtrain, ytrain,@rbf_build,'TPS',0.1363,0);
%             model_rbf=srgtsRBFFit(setopt_rbf);
%             yhat=srgtsRBFEvaluate(xtest,model_rbf);
            %SVR拟合，获取测试点的预测值
%             type = 'function approximation';
%             [~,~,~,~,~,model] = lssvm(xtrain,ytrain,type);
%             yhat=simlssvm(model, xtest);
            
            R2bei=1-sum((ytest-yhat).^2)/sum( (ytest-repmat(mean(ytest),[size(xtest,1),1] ) ).^2  );
            if R2bei<0
                R2bei=nan;
                R2(nidx,1)=R2bei;
                R2_mean(nidx)=nanmean(R2(1:nidx));%计算mean_R2
                deta_mean_R2=1;
                yhat_m_change{nidx,1}=yhat;
                nidx=nidx+1;
            else
                
                R2(nidx,1)=R2bei;
                R2_mean(nidx)=nanmean(R2(1:nidx));%计算mean_R2
                if size(R2_mean,2)==1
                    deta_mean_R2=R2_mean(end);
                else
                    if isnan(R2_mean(end-1))
                        deta_mean_R2=1;
                    else
                        deta_mean_R2 = (R2_mean(end) - R2_mean(end-1))/R2_mean(end-1);%deta 的公式
                    end
                    
                end
                yhat_m_change{nidx,1}=yhat;
                nidx=nidx+1;
            end
%             R2bei(R2bei<0)=nan;
%             R2(nidx,1)=R2bei;
%             
%             R2_mean(nidx)=nanmean(R2(1:nidx));%计算mean_R2
%             if size(R2_mean,2)==1
%                 deta_mean_R2=R2_mean(end);
%             else
%                 deta_mean_R2 = (R2_mean(end) - R2_mean(end-1))/R2_mean(end-1);
%                 %   deta_mean_R2 = R2_mean(end) - R2_mean(end-1);%deta 的公式
%             end
% %             yhat_m_chage(nidx,1)=yhat;
%             yhat_m_change{nidx,1}=yhat;
%             nidx=nidx+1;
        end
        R2_end(nf,nk)=R2_mean(end);
        m_end(nf,nk)=nidx-1;
        if ~isnan(R2bei)
             yhat_save{nf,nk}=yhat_m_change;
            
        end
       
       
         R2_save{nf,nk}=R2;%暂时注释掉，因为内存不足
        R2_mean_save{nf,nk}=R2_mean;
    end
    
    
end

   save('5rd_R2end_mEND_of_200DoE_KRG','K','m_end','nDoE','R2_end','R2_save','R2_mean_save','yhat_save');
