% ��ȡ�ı��ļ���ת��
% [iceAndFire,XTrain,YTrain] = readData();
% numWords = max([iceAndFire{:}]);
% ������ѵ������
% net = createAndTrainNet(XTrain,YTrain,numWords);
% 
% �������ı�
fid = fopen('1.txt','a+t','n','UTF-8');
for ii =1:10
    [genText,net] = predictNewPara(net,"S");
    fwrite(fid,genText,'char');
    net = resetState(net);
end
fclose('all');


    
    
    