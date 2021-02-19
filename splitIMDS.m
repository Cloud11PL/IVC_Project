function [A, B, C] = splitIMDS()
    
    unzip('catdog.zip');
    
    AFiles = [];
    BFiles = [];
    CFiles = [];
    
    for i = 1:12
        path = strcat('catdog/CATS/cat_',string(i),'_*.png');
        catIMDS = imageDatastore(path,'LabelSource','foldernames');
        [catA,catB,catC] = splitEachLabel(catIMDS,0.33,0.33);
        
        path = strcat('catdog/DOGS/dog_',string(i),'_*.png');
        dogIMDS = imageDatastore(path,'LabelSource','foldernames');
        [dogA,dogB,dogC] = splitEachLabel(dogIMDS,0.33,0.33);
                            
        AFiles = cat(1,AFiles,dogA.Files,catA.Files);
        BFiles = cat(1,BFiles,dogB.Files,catB.Files);
        CFiles = cat(1,CFiles,dogC.Files,catC.Files);

    end
    
    A = imageDatastore(AFiles,'LabelSource','foldernames');
    B = imageDatastore(BFiles,'LabelSource','foldernames');
    C = imageDatastore(CFiles,'LabelSource','foldernames');
    
end