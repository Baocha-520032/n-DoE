%获得40个不同函数 在 不同k（2:1:60）值（训练点数为k*dim）的训练点（xtrain）
clear
clc
%% 
% %读取cell中的string内容关键代码
% func_name={'forretal08','grlee12','branin','BRAN'};
% func1=func_name{:,1};
% eval(sprintf('func3=@%s;',func1));
% %读取excel表格中的数据的关键代码
% xlsfile_2 = 'red_liu.xlsx';
% xF = xlsread(xlsfile_2,1,'A1:B56');
% xtrain_F = xF(:,1);
% ytrain_F = xF(:,2);

%% DoE_xDATA为最终cell，functiong*KD  
%（每一行为同一个function在不同的K的取值下的DOE取出的点 ， %%列表示由K确定的取点个数）
xlsfile_2 = 'test_function_for_R2.xlsx';
[xF,txt] = xlsread(xlsfile_2,1,'A2:E41');%%%%%%%%%%%%%%%%表示读取excel表中哪些函数，通过改变‘’中的内容
nDoE=200;%%%%%%%%%%%%表示取多少次DOE，预计多少次DOE后，R2能够稳定下来
% K=[2,5,8,10,16,20,30,40];%%%%%%%%%%%%%%%%%%% K为每次DOE取的点的个数为 K*ndv
K=(2:1:60);
DoE_xDATA=cell(length(xF),size(K,2));%%%%%%%%%%%最终保存的cell，functiong*KD 其每一项又都是一个cell，
                                                 %内容为为某个函数取KD个点，取了nDOE次，其nDOE次的点
for fi=1:length(xF)%每行，均为一个function
    for ki=1:size(K,2)%每列，均为某个K值，取点个数为K*ndv
        cellfiki=cell(1,nDoE);%预定义DoE_xDATA{fi,ki}
        for doei=1:nDoE
            idx=fi;%索引，表示40个函数中的第几个函数
            ndv=xF(idx,3);%维度
            func=txt{idx,1};
            eval(sprintf( 'my_fn=@%s;',func ));%函数名为my_fn
            k=K(ki);
            ntrain=k*ndv;%取点个数
            lb=txt{idx,3};%函数下界
            ub=txt{idx,4};%函数上界
            eval(sprintf('designspace=[%s;%s];',lb,ub));%定义designspace
            %拉丁超立方取点
            xtrain_pre=lhsdesign(ntrain,ndv);
            xtrain=xtrain_pre.*repmat(designspace(2,:)-designspace(1,:),ntrain,1)+repmat(designspace(1,:),ntrain,1);

            cellfiki{1,doei}=xtrain;%将每次取的点均填充到cellfiki中
        end
        DoE_xDATA{fi,ki}=cellfiki;
    end
end

%存下来
 save('data_doe_maxm200_4rd','DoE_xDATA','K','nDoE');

%% 大cell为行为function，列为每次doe取的值，其中每一项为不同K下的取的点
% xlsfile_2 = 'test_function_for_R2.xlsx';
% [xF,txt] = xlsread(xlsfile_2,1,'A2:E5');%%%%%%%%%%%%%%%%表示读取excel表中哪些函数，通过改变‘’中的内容
% nDoE=100;%%%%%%%%%%%%表示取多少次
% DoE_xDATA=cell(length(xF),nDoE);%最终要存下来的cell，内容为所有函数的nDoE次取点的K取不同值的doe原始数据
% K=[2,5,8,10,16,20,30,40];%%%%%%%%%%%%%%%%%%%
% for fi=1:length(xF)
%     for DoEi=1:nDoE
%         Cellfidoei=cell(1,size(K,2));
%         for ki=1:size(K,2)
%             idx=fi;
%             ndv=xF(idx,3);%维度
%             func=txt{idx,1};
%             eval(sprintf( 'my_fn=@%s;',func ));%函数名为my_fn
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





