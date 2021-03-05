% function runTest(bags,svms,nets,images,labels,vars,pert,t)
% 
%     accsBag = [];
%     accsNet = [];
% 
%      for i = 1:numel(vars)
%          
%         var = vars(i);
%         
%         bagSum = 0;
%         netSum = 0;
%         
%         for j = 1:numel(bags)
%                 
%             %Just testing on one use j index for more then one
%             imgs = pert(images{j},var); 
%             bagSum = bagOfWordsTest(bags{j},svms{j},imgs,labels{j}) + bagSum;
%             netSum = resNet18Test(nets{j},imgs,labels{j}) + netSum;
%         end
%         
%         accBag = bagSum/numel(bags);
%         accNet = netSum/numel(bags);
%                 
%         accsBag = cat(1,accsBag,accBag);
%         accsNet = cat(1,accsNet,accNet);
%         
%      end
%     
%      plot(vars,accsBag,vars,accsNet);
%      legend('BagOfFeatures','ResNet18')
%      title(t)
%      xlabel('Variable Value') 
%      ylabel('Accuracy')
%     
% end

function runTest(bags,svms,nets,images,labels,vars,pert,t)

    accsBag = [];
    accsNet = [];

     for i = 1:numel(vars)
         
        var = vars(i);
        
        bagSum = 0;
        netSum = 0;
        
        for j = 1:numel(bags)
                
            %Just testing on one use j index for more then one
            imgs = pert(images{j},var); 
            bagSum = bagOfWordsTest(bags{j},svms{j},imgs,labels{j}) + bagSum;
            netSum = resNet18Test(nets{j},imgs,labels{j}) + netSum;
        end
        
        accBag = bagSum/numel(bags);
        accNet = netSum/numel(bags);
                
        accsBag = cat(1,accsBag,accBag);
        accsNet = cat(1,accsNet,accNet);
        
     end
    
     plot(vars,accsBag,vars,accsNet);
     legend('BagOfFeatures','ResNet18')
     title(t)
     xlabel('Variable Value') 
     ylabel('Accuracy')
    
end