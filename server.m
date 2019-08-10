b=textread('/home/caojf/DSLAM_zu9_proj/GT/pose_gt_1.txt');
d=textread('/home/caojf/DSLAM_zu9_proj/GT/pose_gt_0.txt');
k1=cell(2287,1);
y1={};
y1y={};
z1=cell(2287,1);
netvlad1=[];
bheng=[];
bzong=[];
dheng=[];
dzong=[];
heng1=[];
i=20;
zong1=[];
now=[];
before=[];
now1=[];
before1=[];
k2=cell(2287,1);
y2={};
z2=cell(2287,1);
netvlad2=[];
heng2=[];
zong2=[];
c1=[];
b1=[];
decentr_state={};
decentr_state1={};
decentr_state2={};
sim_o_c=cell(2287,1);
sim_cp_c=cell(2287,1);
sim_cp_c_=cell(2287,1);
jishu=0;
outputDir = ['dgs_data/1'];
outputDir2 = ['dgs_data/2'];
mkdir(outputDir);
mkdir(outputDir2);

max_iters=20;
jishu=0;
jishu4=0;
jishu5=0;
jishu2=[];
jishu1=[];
jishu3=[];
query=[];
match=[];
a=textread('/home/caojf/DSLAM_zu9_proj/testdata/float_1.txt');
a_=textread('/home/caojf/DSLAM_zu9_proj/testdata/float_0.txt');
ax=textread('/home/caojf/DSLAM_zu9_proj/testdata/netvlad_1.txt');
ax_=textread('/home/caojf/DSLAM_zu9_proj/testdata/netvlad_0.txt');
output=textread('/home/caojf/DSLAM_zu9_proj/testdata/output.txt');
 output2=textread('/home/caojf/DSLAM_zu9_proj/testdata/output2.txt');
%output3=textread('/home/caojf/DSLAM_zu9_proj/testdata/output3.txt');
TQM={};
TQM2={};
TQM3={};
for p=1:4
    tqm=[];
    tqm(1,1:4)=output(p,1:4);
    tqm(2,1:4)=output(p,5:8);
    tqm(3,1:4)=output(p,9:12);
    tqm(4,1:4)=[0,0,0,1];
    TQM{p}=tqm;
    
end
for p2=1:1
    tqm2=[];
    tqm2(1,1:4)=output2(p2,1:4);
    tqm2(2,1:4)=output2(p2,5:8);
    tqm2(3,1:4)=output2(p2,9:12);
    tqm2(4,1:4)=[0,0,0,1];
    TQM2{p2}=tqm2;
    
end
% for p3=1:1
%     tqm3=[];
%     tqm3(1,1:4)=output3(p3,1:4);
%     tqm3(2,1:4)=output3(p3,5:8);
%     tqm3(3,1:4)=output3(p3,9:12);
%     tqm3(4,1:4)=[0,0,0,1];
%     TQM3{p3}=tqm3;
%     
% end

distributed_mapper_location='LD_LIBRARY_PATH=/usr/lib/x86_64-linux-gnu/:$LD_LIBRARY_PATH: ~/MApro/distributed-mapper/cpp/build/runDistributedMapper';
intra_mapper_location = 'LD_LIBRARY_PATH=/usr/lib/x86_64-linux-gnu/:$LD_LIBRARY_PATH: /home/yujc/g2o/bin/simple_optimize';

for n=1:2286
    %   while(  (~exist('/home/share/DSLAM/1895829676_data.txt','file') || exist('/home/share/DSLAM/1895829676_lock.txt','file') ))
    %    pause(0.1)
    %   disp('waiting\n')
    % end
    %    while(  (~exist('/home/share/DSLAM/1744834732_data.txt','file') || exist('/home/share/DSLAM/1744834732_lock.txt','file') ))
    %      pause(0.1)
    %   end
    disp(num2str(n))
    tmp=[];
    tmp(1,1:4)=a(n,1:4);
    tmp(2,1:4)=a(n,5:8);
    tmp(3,1:4)=a(n,9:12);
    tmp(4,1:4)=[0,0,0,1];
    sim_cp_c{n}=tmp;
    tmp_=[];
    tmp_(1,1:4)=a_(n,1:4);
    tmp_(2,1:4)=a_(n,5:8);
    tmp_(3,1:4)=a_(n,9:12);
    tmp_(4,1:4)=[0,0,0,1];
    sim_cp_c_{n}=tmp_;
    
    a1=a(n,1);
    b1=b(n,:);
    bheng=[bheng,b1(1,4)];
    bzong=[bzong,b1(1,12)];
    x(1,1)=b1(1,4);
    x(1,2)=b1(1,12);
    d1=d(n,:);
    dheng=[dheng,d1(1,4)];
    dzong=[dzong,d1(1,12)];
    if(n==1)
        
        a21=a(1,1:12);
        T_W_1=[];
        T_W_1(1,1:4)=a21(1,1:4);
        T_W_1(2,1:4)=a21(1,5:8);
        T_W_1(3,1:4)=a21(1,9:12);
        T_W_1(4,1:4)=[0,0,0,1];
    end
    
    if (n>1)
        a2=a(n,1:12);
        T_W_N=[];
        T_W_N(1,1:4)=a2(1,1:4);
        T_W_N(2,1:4)=a2(1,5:8);
        T_W_N(3,1:4)=a2(1,9:12);
        T_W_N(4,1:4)=[0,0,0,1];
        T_W_1=T_W_1*T_W_N;
        a2j(1,1:4)=T_W_1(1,1:4);
        a2j(1,5:8)=T_W_1(2,1:4);
        a2j(1,9:12)=T_W_1(3,1:4);
        
        
    end
    
    
    
    heng1=[heng1;T_W_1(1,4)];
    zong1=[zong1;T_W_1(3,4)];
    a3=ax(n,1:128);
    a4=a3';
    if rem(n,i) == 0
    netvlad1(1:128,n) =a4;
    end
        if rem(n,i) ~= 0
    netvlad1(1:128,n) =ones(128,1);
    end
    query_netvlad1 = a3';
    k1{n}=a1;
    y1{1}=a(1,1:12);
    if(n>1)
        y1{n}=a2j;
    end
    z1{n}=a3;
    %    delete('/home/share/DSLAM/1895829676_data.txt');
    disp('deleted\n')
    
    
    a1_=a_(n,1);
    if(n==1)
        a2_1=a_(1,1:12);
        T_W_2=[];
        T_W_2(1,1:4)=a2_1(1,1:4);
        T_W_2(2,1:4)=a2_1(1,5:8);
        T_W_2(3,1:4)=a2_1(1,9:12);
        T_W_2(4,1:4)=[0,0,0,1];
    end
    % sim_o_c_{n}=T_W_C_;
    % sim_cp_c_{1}=eye(4);
    % if(n>1)
    % sim_cp_c_{n}=sim_o_c_{n-1} ^ -1 * sim_o_c_{n};
    % end
    if(n>1)
        a2_=a_(n,1:12);
        T_W_X(1,1:4)=a2_(1,1:4);
        T_W_X(2,1:4)=a2_(1,5:8);
        T_W_X(3,1:4)=a2_(1,9:12);
        T_W_X(4,1:4)=[0,0,0,1];
        T_W_2=T_W_2*T_W_X;
        
        a2_j(1,1:4)=T_W_2(1,1:4);
        a2_j(1,5:8)=T_W_2(2,1:4);
        a2_j(1,9:12)=T_W_2(3,1:4);
        
    end
    
    heng2=[heng2;T_W_2(1,4)];
    zong2=[zong2;T_W_2(3,4)];
    y(1:n,1)=heng2;
    y(1:n,2)=zong2;
    a3_=ax_(n,1:128);
    a4_=a3_';
    if rem(n,i) == 0
    netvlad2(1:128,n) =a4_;
    end
      if rem(n,i) ~= 0
    netvlad2(1:128,n) =ones(128,1);
    end
    query_netvlad2 = a3_';
    k2{n}=a1_;
    y2{1}=a_(1,1:12);
    if(n>1)
        y2{n}=a2_j;
    end
    z2{n}=a3_;
    if rem(n,i) == 0
    
    [distance12, best_frame12] = ...
        pdist2(netvlad2(:, 1:n)', ...
        query_netvlad1', 'squaredeuclidean', 'Smallest', 1);
    if (distance12<0.01)
        G1=y2{best_frame12};
        G(1,1:4)=G1(1,1:4);
        G(2,1:4)=G1(1,5:8);
        G(3,1:4)=G1(1,9:12);
        G(4,1:4)=[0,0,0,1];
        T_0_N1=y1{n};
        T_0_N(1,1:4)=T_0_N1(1,1:4);
        T_0_N(2,1:4)=T_0_N1(1,5:8);
        T_0_N(3,1:4)=T_0_N1(1,9:12);
        T_0_N(4,1:4)=[0,0,0,1];
        jishu=jishu+1;
        query=[query;best_frame12];
        match=[match;n];
    end
    [distance11, best_frame11] = ...
        pdist2(netvlad1(:, 1:n-30)', ...
        query_netvlad1', 'squaredeuclidean', 'Smallest', 1);
    if (distance11 < 0.01)
        now=[now;n];
        before=[before;best_frame11];
        jishu4=jishu4+1;
    end
     
            [distance22, best_frame22] = ...
                pdist2(netvlad2(:, 1:n-60)', ...
                query_netvlad2', 'squaredeuclidean', 'Smallest', 1);
    if (distance22 < 0.01)
           now1=[now1;n];
           before1=[before1;best_frame22];
           jishu5=jishu5+1;
    end
    end
    
    
    
    
%         if (jishu4<10 && jishu<10)
%         hold on;
%         c = colormap('lines');
%         plot(heng1, zong1, '-', 'LineWidth', 3, ...
%             'Color', c(1, :));
%         plot(heng2, zong2, '-', 'LineWidth', 3, ...
%             'Color', [1 0 0]);
%         plot(bheng, bzong,  '--', ...
%             'Color', c(1, :));
%         
%         plot(dheng, dzong,  '--', ...
%             'Color', [0 1 0]);
%         if(n>30)
%             [distance11, best_frame11] = ...
%                 pdist2(netvlad1(:, 1:n-30)', ...
%                 query_netvlad1', 'squaredeuclidean', 'Smallest', 1);
%             if (distance11 < 0.01)
%                 to2=zong1(best_frame11,1);
%                 to1=heng1(best_frame11,1);
%                 plot([a2j(1,4) to1], [a2j(1,12) to2], 'k-x', 'LineWidth', 5);
%                 
%             end
%             
%             
%             
%             
%             [distance12, best_frame12] = ...
%                 pdist2(netvlad2(:, 1:n-10)', ...
%                 query_netvlad1', 'squaredeuclidean', 'Smallest', 1);
%             if (distance12 < 0.01)
%                 jishu1=[jishu1;n];
%                 jishu3=[jishu3;best_frame12];
%                 to4=zong2(best_frame12,1);
%                 to3=heng2(best_frame12,1);
%                 plot([a2j(1,4) to3], [a2j(1,12) to4], 'k-x', 'LineWidth', 5);
%             end
%             [distance21, best_frame21] = ...
%                 pdist2(netvlad1(:, 1:n-10)', ...
%                 query_netvlad2', 'squaredeuclidean', 'Smallest', 1);
%             if (distance21 < 0.01)
%                 jishu2=[jishu2;n];
%                 to5=zong1(best_frame21,1);
%                 to6=heng1(best_frame21,1);
%                 plot([a2_j(1,4) to6], [a2_j(1,12) to5], 'k-x', 'LineWidth', 5);
%             end
%             
%             [distance22, best_frame22] = ...
%                 pdist2(netvlad2(:, 1:n-30)', ...
%                 query_netvlad2', 'squaredeuclidean', 'Smallest', 1);
%             if (distance22 < 0.01)
%                 to7=zong2(best_frame22,1);
%                 to8=heng2(best_frame22,1);
%                 
%                 plot([a2_j(1,4) to8], [a2_j(1,12) to7], 'k-x', 'LineWidth', 5);
%             end
%             
%         end
%     end
    
%     if(jishu4>10 )
%         writeDecentrStateToG2oFiles1(jishu4,now,before, sim_cp_c,y1, outputDir2);
%         assert(system([intra_mapper_location ' -o ' pwd '/' ...
%             outputDir2 '/0_optimized.g2o '  pwd '/' ...
%             outputDir2 '/0.g2o ']) == 0);
%         
%         decentr_state2 = readDecentrStateFromOptG2oFiles2(...
%             n, decentr_state2);
%         
%     
%     m4=numel(decentr_state2);
%     bheng22_=[];
%     bzong22_=[];
%     
%     for m3=1:m4
%         zb1_=[];
%         zb1_=decentr_st1ate2{m3};
%         zb2(1,1:4)=zb1_(1,1:4);
%         zb2(1,5:8)=zb1_(2,1:4);
%         zb2(1,9:12)=zb1_(3,1:4);
%         y1y{m3}=zb2;
%         
%         x2_=zb1_(1,4);
%         y22_=zb1_(3,4);
%         bheng22_=[bheng22_,x2_];
%         bzong22_=[bzong22_,y22_];
%     end
%    if(jishu4>10 && jishu<25 )
%         clf;
%         
%         hold on;
%         c = colormap('lines');
%         
%         
%         plot(heng2, zong2, '-', 'LineWidth', 3, ...
%             'Color', [1 0 0]);
%         plot(bheng22_, bzong22_,  '-', 'LineWidth', 3, ...
%             'Color', [0 0 1]);
%         
%         plot(dheng, dzong,  '--', ...
%             'Color', [0 1 0]);
%         plot(bheng, bzong,  '--', ...
%             'Color', c(1, :));
%         [distance22, best_frame22] = ...
%             pdist2(netvlad2(:, 1:n-30)', ...
%             query_netvlad2', 'squaredeuclidean', 'Smallest', 1);
%         if (distance22 < 0.01)
%             to7=zong2(best_frame22,1);
%             to8=heng2(best_frame22,1);
%             
%             plot([a2_j(1,4) to8], [a2_j(1,12) to7], 'k-x', 'LineWidth', 5);
%         end
%         end
%     
%     end
    
    if(n>2283)
        writeDecentrStateToG2oFiles(TQM2,TQM3,n,jishu5,now1,before1,TQM,jishu4,now,before,query,match,jishu,sim_cp_c_,y2,sim_cp_c,y1, outputDir);
        %  distributed_mapper_location='~/MApro/distributed-mapper/cpp/build/runDistributedMapper';
        assert(system([distributed_mapper_location ' --dataDir ' pwd '/' ...
            outputDir '/ --nrRobots ' num2str(2)...
            ' --traceFile ' pwd '/' outputDir '/trace --maxIter ' ...
            num2str(max_iters)]) == 0);
        
        decentr_state = readDecentrStateFromOptG2oFiles(...
            n, outputDir, decentr_state, '_optimized');
        decentr_state1 = readDecentrStateFromOptG2oFiles1(...
            n, outputDir, decentr_state1, '_optimized');
        %  bheng11=[];
        %bzong11=[];
        %for i=1:n
        % N=y1{i};
        % A(1,1:4)=N(1,1:4);
        %A(2,1:4)=N(1,5:8);
        % A(3,1:4)=N(1,9:12);
        % A(4,1:4)=[0,0,0,1];
        %  T_K_N = tInv(T_0_N) * A;
        % M=G*T_K_N;
        %  x1=M(1,4);
        %  y11=M(3,4);
        %  bheng11=[bheng11,x1];
        % bzong11=[bzong11,y11];
        %end
        m1=numel(decentr_state);
        bheng11=[];
        bzong11=[];
        
        for m2=1:m1
            zb=[];
            zb=decentr_state{m2};
            
            x1=zb(1,4);
            y11=zb(3,4);
            bheng11=[bheng11,x1];
            bzong11=[bzong11,y11];
        end
        
        m1_=numel(decentr_state1);
        bheng11_=[];
        bzong11_=[];
        
        for m2_=1:m1_
            zb_=[];
            zb_=decentr_state1{m2_};
            
            x1_=zb_(1,4);
            y11_=zb_(3,4);
            bheng11_=[bheng11_,x1_];
            bzong11_=[bzong11_,y11_];
        end
        
        
        
        clf;
        
        hold on;
        c = colormap('lines');
        
        
        plot(bheng11_, bzong11_, '-', 'LineWidth', 3, ...
            'Color', [1 0 0]);
        plot(bheng11, bzong11,  '-', 'LineWidth', 3, ...
            'Color', [0 0 1]);
        
        plot(dheng, dzong,  '--', ...
            'Color', [0 1 0]);
        plot(bheng, bzong,  '--', ...
            'Color', c(1, :));
        [distance22, best_frame22] = ...
            pdist2(netvlad2(:, 1:n-30)', ...
            query_netvlad2', 'squaredeuclidean', 'Smallest', 1);
        if (distance22 < 0.01)
            to7=zong2(best_frame22,1);
            to8=heng2(best_frame22,1);
            
            plot([a2_j(1,4) to8], [a2_j(1,12) to7], 'k-x', 'LineWidth', 5);
        end
    end

    
    
    hold off;
    
    axis equal;
    
    pause(0.001)
end