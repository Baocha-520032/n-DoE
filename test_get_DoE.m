%���40����ͬ���� �� ��ͬk��2:1:60��ֵ��ѵ������Ϊk*dim����ѵ���㣨xtrain��
clear
clc
%% 
% %��ȡcell�е�string���ݹؼ�����
% func_name={'forretal08','grlee12','branin','BRAN'};
% func1=func_name{:,1};
% eval(sprintf('func3=@%s;',func1));
% %��ȡexcel����е����ݵĹؼ�����
% xlsfile_2 = 'red_liu.xlsx';
% xF = xlsread(xlsfile_2,1,'A1:B56');
% xtrain_F = xF(:,1);
% ytrain_F = xF(:,2);

%% DoE_xDATAΪ����cell��functiong*KD  
%��ÿһ��Ϊͬһ��function�ڲ�ͬ��K��ȡֵ�µ�DOEȡ���ĵ� �� %%�б�ʾ��Kȷ����ȡ�������
xlsfile_2 = 'test_function_for_R2.xlsx';
[xF,txt] = xlsread(xlsfile_2,1,'A2:E41');%%%%%%%%%%%%%%%%��ʾ��ȡexcel������Щ������ͨ���ı䡮���е�����
nDoE=200;%%%%%%%%%%%%��ʾȡ���ٴ�DOE��Ԥ�ƶ��ٴ�DOE��R2�ܹ��ȶ�����
% K=[2,5,8,10,16,20,30,40];%%%%%%%%%%%%%%%%%%% KΪÿ��DOEȡ�ĵ�ĸ���Ϊ K*ndv
K=(2:1:60);
DoE_xDATA=cell(length(xF),size(K,2));%%%%%%%%%%%���ձ����cell��functiong*KD ��ÿһ���ֶ���һ��cell��
                                                 %����ΪΪĳ������ȡKD���㣬ȡ��nDOE�Σ���nDOE�εĵ�
for fi=1:length(xF)%ÿ�У���Ϊһ��function
    for ki=1:size(K,2)%ÿ�У���Ϊĳ��Kֵ��ȡ�����ΪK*ndv
        cellfiki=cell(1,nDoE);%Ԥ����DoE_xDATA{fi,ki}
        for doei=1:nDoE
            idx=fi;%��������ʾ40�������еĵڼ�������
            ndv=xF(idx,3);%ά��
            func=txt{idx,1};
            eval(sprintf( 'my_fn=@%s;',func ));%������Ϊmy_fn
            k=K(ki);
            ntrain=k*ndv;%ȡ�����
            lb=txt{idx,3};%�����½�
            ub=txt{idx,4};%�����Ͻ�
            eval(sprintf('designspace=[%s;%s];',lb,ub));%����designspace
            %����������ȡ��
            xtrain_pre=lhsdesign(ntrain,ndv);
            xtrain=xtrain_pre.*repmat(designspace(2,:)-designspace(1,:),ntrain,1)+repmat(designspace(1,:),ntrain,1);

            cellfiki{1,doei}=xtrain;%��ÿ��ȡ�ĵ����䵽cellfiki��
        end
        DoE_xDATA{fi,ki}=cellfiki;
    end
end

%������
 save('data_doe_maxm200_4rd','DoE_xDATA','K','nDoE');

%% ��cellΪ��Ϊfunction����Ϊÿ��doeȡ��ֵ������ÿһ��Ϊ��ͬK�µ�ȡ�ĵ�
% xlsfile_2 = 'test_function_for_R2.xlsx';
% [xF,txt] = xlsread(xlsfile_2,1,'A2:E5');%%%%%%%%%%%%%%%%��ʾ��ȡexcel������Щ������ͨ���ı䡮���е�����
% nDoE=100;%%%%%%%%%%%%��ʾȡ���ٴ�
% DoE_xDATA=cell(length(xF),nDoE);%����Ҫ��������cell������Ϊ���к�����nDoE��ȡ���Kȡ��ֵͬ��doeԭʼ����
% K=[2,5,8,10,16,20,30,40];%%%%%%%%%%%%%%%%%%%
% for fi=1:length(xF)
%     for DoEi=1:nDoE
%         Cellfidoei=cell(1,size(K,2));
%         for ki=1:size(K,2)
%             idx=fi;
%             ndv=xF(idx,3);%ά��
%             func=txt{idx,1};
%             eval(sprintf( 'my_fn=@%s;',func ));%������Ϊmy_fn
%             k=K(ki);
%             ntrain=k*ndv;
%             lb=txt{idx,3};
%             ub=txt{idx,4};
%             eval(sprintf('designspace=[%s;%s];',lb,ub));
%             
%             
%             
%             xtrain_pre=lhsdesign(ntrain,ndv);
%             xtrain=xtrain_pre.*repmat(designspace(2,:)-designspace(1,:),ntrain,1)+repmat(designspace(1,:),ntrain,1);
% 
%             Cellfidoei{1,ki}=xtrain;
%         end
%         
%         DoE_xDATA{fi,DoEi}=Cellfidoei;
%     end
% end





