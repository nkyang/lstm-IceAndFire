function [genText,net] = predictNewPara(net,firstChar)
% һ�����������ַ���
maxLength = 2000;
genText = firstChar;
X = double(char(firstChar));
% �ʻ��
vocabulary = string(net.Layers(end).ClassNames);
newlineChar = compose("\x00B6");
spaceChar = compose("\x00B7");
endOfTextChar = compose("\x2403");
while strlength(genText) < maxLength
    [net,charScores] = predictAndUpdateState(net,X,'ExecutionEnvironment','cpu');
    % charScores��ΪȨ�أ��Ӵʻ���������ȡ�ַ�
    newChar = datasample(vocabulary,1,'Weights',charScores);
    % ����������ı����������ͽ�������
    if newChar == endOfTextChar
        break;
    end
    genText = genText + newChar;
    X = double(char(newChar));
end
% ���ػ��з��Ϳո�
genText = replace(genText,[newlineChar spaceChar],[newline " "]);
end