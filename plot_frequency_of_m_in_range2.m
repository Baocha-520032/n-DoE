 load('m_in_range2.mat')
 rangeprs=range2;
 clear range2
 load('m_in_range2_krg.mat')
 rangekrg=range2;
 clear range2
 load('m_in_range2_rbfmq.mat')
 rangerbfmq=range2;
 clear range2
 load('m_in_range2_rbftps.mat')
 rangerbftps=range2;
 clear range2
 load('m_in_range2_svm.mat')
 rangesvm=range2;
 clear range2
 
 m_range=[rangeprs rangekrg rangerbfmq rangerbftps rangesvm];
 m=cell(40,1);
 m_tongji=[];
 for i=1:40
     m{i,1}=[m_range{i,1} m_range{i,2} m_range{i,3} m_range{i,4} m_range{i,5}];
     m_tongji=[m_tongji m{i,1}];
 end
 m_tongji(isnan(m_tongji))=[];

  TK = tabulate(m_tongji);
  figure
   bar(TK(:,1),TK(:,2))
 
 title('range2下m分布直方图')
   xlabel('m值')
   ylabel('频率')
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 