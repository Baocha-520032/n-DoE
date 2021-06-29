%����Ҫ�����������ڼ�����Ϻ��40��������Ԥ����Ԥ��ֵyhat���ܵõ��ȶ�R2ʱ��Ҫ�ظ����ٴ�DOE�Ĵ���m���Լ�R2�������������
% Kֵ��ʾ��ѵ������Ϊ k*dim��ά�ȣ�
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
R2_mean_save=cell(n_f,n_k);%R2_mean��ʾǰ�����R2��ƽ��ֵ

for nf=1:n_f    %����ĳ�� ����
    func=txt{nf,1};
    eval(sprintf( 'my_FN=@%s;',func ));
    %  my_FN = str2func(txt{nf,1}); 
    for nk=1:n_k  %����ĳ�� K ��ֵ
        k=K(nk);

        deta_mean_R2=1;
        R2=[];
        R2_mean=[];
        nidx=1;
%         yhat_m_change=cell(n,1);%�м���
        yhat_m_change=cell(nidx,1);
        R2_m_change=[];%�м���
        R2_mean_m_change=[];%�м���
        while abs(deta_mean_R2)>0.001 && nidx<=nDoE %������ֹ��������Ϊǧ��֮һ
            %��ȡѵ����
            xtrain=DoE_xDATA{nf,nk}{1,nidx};
            ytrain=feval(my_FN,xtrain);
            %��ȡ���Ե�
            xtest=test_xDATA{nf,1};
            ytest=test_xDATA{nf,2};
            %kriging��ϣ���ȡ���Ե㴦��Ԥ��ֵ
            setopt_krg1=srgtsKRGSetOptions(xtrain, ytrain);
            model_krg1= srgtsKRGFit(setopt_krg1);
            yhat = srgtsKRGPredictor(xtest,model_krg1);
            %PRS��ϣ���ȡ���Ե㴦��Ԥ��ֵ
%             setopt_prs=srgtsPRSSetOptions(xtrain, ytrain);
%             model_prs=srgtsPRSFit(setopt_prs);
%             yhat=srgtsPRSPredictor(xtest,xtrain,model_prs);
            %RBF_MQ��ϣ���ȡ���Ե��Ԥ��ֵ
%             setopt_rbf=srgtsRBFSetOptions(xtrain, ytrain,@rbf_build,'MQ',0.1363,0);
%             model_rbf=srgtsRBFFit(setopt_rbf);
%             yhat=srgtsRBFEvaluate(xtest,model_rbf);
            %RBF_TPS��ϣ���ȡ���Ե��Ԥ��ֵ
%             setopt_rbf=srgtsRBFSetOptions(xtrain, ytrain,@rbf_build,'TPS',0.1363,0);
%             model_rbf=srgtsRBFFit(setopt_rbf);
%             yhat=srgtsRBFEvaluate(xtest,model_rbf);
            %SVR��ϣ���ȡ���Ե��Ԥ��ֵ
%             type = 'function approximation';
%             [~,~,~,~,~,model] = lssvm(xtrain,ytrain,type);
%             yhat=simlssvm(model, xtest);
            
            R2bei=1-sum((ytest-yhat).^2)/sum( (ytest-repmat(mean(ytest),[size(xtest,1),1] ) ).^2  );
            if R2bei<0
                R2bei=nan;
                R2(nidx,1)=R2bei;
                R2_mean(nidx)=nanmean(R2(1:nidx));%����mean_R2
                deta_mean_R2=1;
                yhat_m_change{nidx,1}=yhat;
                nidx=nidx+1;
            else
                
                R2(nidx,1)=R2bei;
                R2_mean(nidx)=nanmean(R2(1:nidx));%����mean_R2
                if size(R2_mean,2)==1
                    deta_mean_R2=R2_mean(end);
                else
                    if isnan(R2_mean(end-1))
                        deta_mean_R2=1;
                    else
                        deta_mean_R2 = (R2_mean(end) - R2_mean(end-1))/R2_mean(end-1);%deta �Ĺ�ʽ
                    end
                    
                end
                yhat_m_change{nidx,1}=yhat;
                nidx=nidx+1;
            end
%             R2bei(R2bei<0)=nan;
%             R2(nidx,1)=R2bei;
%             
%             R2_mean(nidx)=nanmean(R2(1:nidx));%����mean_R2
%             if size(R2_mean,2)==1
%                 deta_mean_R2=R2_mean(end);
%             else
%                 deta_mean_R2 = (R2_mean(end) - R2_mean(end-1))/R2_mean(end-1);
%                 %   deta_mean_R2 = R2_mean(end) - R2_mean(end-1);%deta �Ĺ�ʽ
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
       
       
         R2_save{nf,nk}=R2;%��ʱע�͵�����Ϊ�ڴ治��
        R2_mean_save{nf,nk}=R2_mean;
    end
    
    
end

   save('5rd_R2end_mEND_of_200DoE_KRG','K','m_end','nDoE','R2_end','R2_save','R2_mean_save','yhat_save');
