function writeDecentrStateToG2oFiles(TQM2,TQM3,n,jishu5,now1,before1,TQM,jishu4,now,before,query,match,jishu,sim_cp_c_,y2, sim_cp_c,y1, outputDir)
file_ids = fopen(...'
        [outputDir '/' '1.g2o'], 'w');
    file_ids1 = fopen(...'
        [outputDir '/' '0.g2o'], 'w');
    nr_poses = numel(y1);
    file_id = file_ids;
    file_id1 = file_ids1;
    
             nr_poses1 = numel(y2);
       query_id2 = 2260+97 * int64(2^56);
       match_id2 =1+98 * int64(2^56);
           if(n>2260)  
             for loop=2261:n
                 
      T_Q_M3(1,1:4)=[1,0,0,0];
      T_Q_M3(2,1:4)=[0,1,0,0];
      T_Q_M3(3,1:4)=[0,0,1,0];
      T_Q_M3(4,1:4)=[0,0,0,1];
          writeG2oConstraint(file_id1, match_id2,query_id2,  T_Q_M3, eye(6));
          writeG2oConstraint(file_id, match_id2,query_id2,  T_Q_M3, eye(6));
               query_id2=query_id2+1;
               match_id2= match_id2+1;
           
           end
           end
    for pose_i1 = 1:nr_poses1
        T_O_C1 = y2{pose_i1};
        T_W_C1=[];
        T_W_C1(1,1:4)=T_O_C1(1,1:4);
        T_W_C1(2,1:4)=T_O_C1(1,5:8);
        T_W_C1(3,1:4)=T_O_C1(1,9:12);
        frame_id1=pose_i1+97 * int64(2^56);
        writeG2oPose(file_id1,frame_id1, T_W_C1);
    end
    for pose_i1 = 1:nr_poses1-1
        relative_pose1 = sim_cp_c_{pose_i1};
                frame_idx1=pose_i1+97 * int64(2^56);
        frame_id1x1=frame_idx1+1;
        writeG2oConstraint(file_id1, frame_idx1, frame_id1x1,relative_pose1, eye(6));
    end
   %  query_id = 426+97 * int64(2^56);
      %  match_id =1160+98 * int64(2^56);
      %  matcha=0;
      %  if(n>1159 && n<1609)
     %       matcha=matcha+1;
      %  end
      %  if(n>1609)
      %      matcha=449;
    %    end
            
            
   %   if (n>1159)
    for matchi=1:jishu

     %   aaa=load('/home/caojf/test/test.txt')
  % Sim_M_Q(1,1:4)=aaa(1,1:4);
   % Sim_M_Q(2,1:4)=aaa(1,5:8);
   % Sim_M_Q(3,1:4)=aaa(1,9:12);
   % Sim_M_Q(4,1:4)=[0,0,0,1];
    % Sim_M_Q1=Sim_M_Q ^ -1;
      %T_Q_M = tInv(Sim_M_Q1);
       if (jishu<436)
          jk=1;
          T_Q_M=TQM{jk};
          jk=jk+1;
           T_Q_Mk=tInv(T_Q_M);
      end
      if(jishu>435)
        jk1=436;
          T_Q_M=TQM{jk1};
          jk1=jk1+1;
           T_Q_Mk=tInv(T_Q_M);
                   
      end

      query_id=query(matchi,1)+97 * int64(2^56);
      match_id =match(matchi,1)+98 * int64(2^56);
      
        
         writeG2oConstraint(file_id1, query_id, match_id, T_Q_Mk, eye(6));
          writeG2oConstraint(file_id, query_id, match_id, T_Q_Mk, eye(6));
      %   query_id=query_id+1;
       %  match_id=match_id+1;
         
    end
   %   end
    if(jishu5>0)
   for matchi2=1:jishu5
         jk2=1;
        T_Q_M3=TQM3{jk2};
        jk2=jk2+1;
      now_id1=now1(matchi2,1)+97 * int64(2^56);
      before_id1 =before1(matchi2,1)+97 * int64(2^56);
      
         writeG2oConstraint(file_id1, before_id1, now_id1, T_Q_M3, eye(6));
       
   end
%    for matchi2=1:jishu5
%        T_Q_M2(1,1:4)=[1,0,0,0];
%       T_Q_M2(2,1:4)=[0,1,0,0];
%       T_Q_M2(3,1:4)=[0,0,1,0];
%       T_Q_M2(4,1:4)=[0,0,0,1];
%       now_id1=now1(matchi2,1)+97 * int64(2^56);
%       before_id1 =before1(matchi2,1)+97 * int64(2^56);
%       
%          writeG2oConstraint(file_id1,  now_id1,before_id1, T_Q_M2, eye(6));
%        
%    end
   
   
    end
   
   
    for pose_i = 1:nr_poses
        T_O_C = y1{pose_i};
        T_W_C=[];
        T_W_C(1,1:4)=T_O_C(1,1:4);
        T_W_C(2,1:4)=T_O_C(1,5:8);
        T_W_C(3,1:4)=T_O_C(1,9:12);
        frame_id=pose_i+98 * int64(2^56);
        writeG2oPose(file_id, frame_id,T_W_C);
        
    end
      for pose_i = 1:nr_poses-1
        relative_pose = sim_cp_c{pose_i};
                frame_idx=pose_i+98 * int64(2^56);
        frame_id1x=frame_idx+1;
        writeG2oConstraint(file_id, frame_idx, frame_id1x,relative_pose, eye(6));
      end
%        for matchi=10:jishu
%       T_Q_M(1,1:4)=[1,0,0,0];
%       T_Q_M(2,1:4)=[0,1,0,0];
%       T_Q_M(3,1:4)=[0,0,1,0];
%       T_Q_M(4,1:4)=[0,0,0,1];
%       query_id=query(matchi,1)+97 * int64(2^56);
%       match_id =match(matchi,1)+98 * int64(2^56);
%       
%         % writeG2oConstraint(file_id, query_id, match_id, T_Q_M, eye(6));
%       %   writeG2oConstraint(file_id1, query_id, match_id, T_Q_M, eye(6));
%          
%       %   query_id=query_id+1;
%        %  match_id=match_id+1;
%          
%     end
      
      if (jishu4>0)
    for matchi1=1:jishu4

         jk3=1;
        T_Q_M2=TQM2{jk3};
        jk3=jk3+1;
      now_id=now(matchi1,1)+98 * int64(2^56);
      before_id =before(matchi1,1)+98 * int64(2^56);
      
         writeG2oConstraint(file_id, before_id, now_id, T_Q_M2, eye(6));
    

         
    end
      end
%        for matchi1=1:jishu4
% 
%       T_Q_M1(1,1:4)=[1,0,0,0];
%       T_Q_M1(2,1:4)=[0,1,0,0];
%       T_Q_M1(3,1:4)=[0,0,1,0];
%       T_Q_M1(4,1:4)=[0,0,0,1];
%       now_id=now(matchi1,1)+98 * int64(2^56);
%       before_id =before(matchi1,1)+98 * int64(2^56);
%       
%          writeG2oConstraint(file_id,now_id, before_id, T_Q_M1, eye(6));
%     
%          
%     end
       
    fclose(file_ids);
    fclose(file_ids1);
end