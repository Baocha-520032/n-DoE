%获得40个测试函数，每个测试函数得到一组测试点，（xtest，ytest）
clear
clc
xlsfile_2 = 'test_function_for_R2.xlsx';
[xF,txt] = xlsread(xlsfile_2,1,'A2:E41');%%%%%%%%%%%%%%%%表示读取excel表中哪些函数，通过改变‘’中的内容
%%%  1维到六维，取1000n，7维到10维，取5000n，15,16维，取10000n
test_xDATA=cell(length(xF),2);
for fi=1:length(xF)
    ndv=xF(fi,3);
%     if (ndv>=1)&&(ndv<=6)
%         ntest=1000*ndv;
%     
%     elseif(ndv>=7)&&(ndv<=10)
%         ntest=5000*ndv;
%     else
%         ntest=10000*ndv;    
%     end
    ntest=1000*ndv;
    
    func=txt{fi,1};
    eval(sprintf( 'my_fn=@%s;',func ));%函数名为my_fn
    lb=txt{fi,3};%函数下界
    ub=txt{fi,4};%函数上界
    eval(sprintf('designspace=[%s;%s];',lb,ub));%定义designspace
    xtest_pre=lhsdesign(ntest,ndv);
    xtest=xtest_pre.*repmat(designspace(2,:)-designspace(1,:),ntest,1)+repmat(designspace(1,:),ntest,1);
    ytest=feval(my_fn,xtest);
    test_xDATA{fi,1}=xtest;
    test_xDATA{fi,2}=ytest;
    
end
save('data_xtest_5rd_1000ntest','test_xDATA');
