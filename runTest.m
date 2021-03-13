function runTest(bags,svms,nets,images,labels,vars,pert,t)

    %Initialize array for the bag and net accuracies
    accsBag = [];
    accsNet = [];

    %Loop over variables
    for i = 1:numel(vars)
         
        %Get variable at index
        var = vars(i);
        
        %Initialise sum of accuracies
        bagSum = 0;
        netSum = 0;
        
        %Loop over models
        for j = 1:numel(bags)
            %Apply pertubation on images with variables
            imgs = pert(images{j},var); 
            %Caclulate accuracy and add for both models
            bagSum = bagOfWordsTest(bags{j},svms{j},imgs,labels{j}) + bagSum;
            netSum = resNet18Test(nets{j},imgs,labels{j}) + netSum;
        end
        
        %Calculate averages accuracies for models
        accBag = bagSum/numel(bags);
        accNet = netSum/numel(bags);
                
        %add averages to the accuracies
        accsBag = cat(1,accsBag,accBag);
        accsNet = cat(1,accsNet,accNet);
       
    end
    
     %Plot the graphs for accuracies vs variables
     plot(vars,accsBag,vars,accsNet);
     legend('BagOfFeatures','ResNet18')
     title(t)
     xlabel('Variable Value') 
     ylabel('Accuracy')
    
end