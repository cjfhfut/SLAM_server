function writeDecentrStateToG2oFiles1(jishu4,now,before, sim_cp_c,y1, outputDir2)
file_ids = fopen(...'
        [outputDir2 '/' '0.g2o'], 'w');
    nr_poses = numel(y1);
    file_id = file_ids;

    
    for pose_i = 1:nr_poses
        T_O_C = y1{pose_i};
        T_W_C=[];
        T_W_C(1,1:4)=T_O_C(1,1:4);
        T_W_C(2,1:4)=T_O_C(1,5:8);
        T_W_C(3,1:4)=T_O_C(1,9:12);
        frame_id=pose_i+98 * int64(2^16);
        writeG2oPose(file_id, frame_id,T_W_C);
        
    end
      for pose_i = 1:nr_poses-1
        relative_pose = sim_cp_c{pose_i};
                frame_idx=pose_i+98 * int64(2^16);
        frame_id1x=frame_idx+1;
        writeG2oConstraint(file_id, frame_idx, frame_id1x,relative_pose, eye(6));
      end
      
    for matchi1=1:jishu4

      T_Q_M1(1,1:4)=[1,0,0,0];
      T_Q_M1(2,1:4)=[0,1,0,0];
      T_Q_M1(3,1:4)=[0,0,1,0];
      T_Q_M1(4,1:4)=[0,0,0,1];
      now_id=now(matchi1,1)+98 * int64(2^16);
      before_id =before(matchi1,1)+98 * int64(2^16);
      
         writeG2oConstraint(file_id, before_id, now_id, T_Q_M1, eye(6));
    

         
    end
       for matchi1=1:jishu4

      T_Q_M1(1,1:4)=[1,0,0,0];
      T_Q_M1(2,1:4)=[0,1,0,0];
      T_Q_M1(3,1:4)=[0,0,1,0];
      T_Q_M1(4,1:4)=[0,0,0,1];
      now_id=now(matchi1,1)+98 * int64(2^16);
      before_id =before(matchi1,1)+98 * int64(2^16);
      
         writeG2oConstraint(file_id,now_id, before_id, T_Q_M1, eye(6));
    

         
    end
      
      
    
  
        

        
    fclose(file_ids);
end