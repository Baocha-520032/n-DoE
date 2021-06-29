%画图，m和R2在某个固定的K 值下 的关系图，最后生成一张图，有40条曲线,
load('5rd_R2end_mEND_of_200DoE_RBF_TPS.mat')


for i=1:40
    m=(2:1:m_end(i,9)+1)';
    r2=R2_mean_save{i,9};%k=10
    
    if i<=3
        plot(m,r2,'-r')
        xlabel('m');
        ylabel('R2-mean');
        hold on
    end
    if (i>3)&&(i<=17)
        plot(m,r2,'-g')
        xlabel('m');
        ylabel('R2-mean');
        hold on
    end
    if (i>17)&&(i<=19)
        plot(m,r2,'-b')
        xlabel('m');
        ylabel('R2-mean');
        hold on
    end
    if (i>19)&&(i<=26)
        plot(m,r2,'-k')
        xlabel('m');
        ylabel('R2-mean');
        hold on 
    end
    if (i>26)&&(i<=30)
        plot(m,r2,'-y')
        xlabel('m');
        ylabel('R2-mean');
        hold on
    end
   if i>30
        plot(m,r2,'-r')
        xlabel('m');
        ylabel('R2-mean');
        hold on
   end
end










