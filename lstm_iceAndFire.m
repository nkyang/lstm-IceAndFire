% 读取文本文件并转换
% [iceAndFire,XTrain,YTrain] = readData();
% numWords = max([iceAndFire{:}]);
% 创建并训练网络
% net = createAndTrainNet(XTrain,YTrain,numWords);
% 
% 生成新文本
fid = fopen('1.txt','a+t','n','UTF-8');
for ii =1:10
    [genText,net] = predictNewPara(net,"S");
    fwrite(fid,genText,'char');
    net = resetState(net);
end
fclose('all');


    
    
    