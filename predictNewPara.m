function [genText,net] = predictNewPara(net,firstChar)
% 一个段落的最大字符数
maxLength = 2000;
genText = firstChar;
X = double(char(firstChar));
% 词汇表
vocabulary = string(net.Layers(end).ClassNames);
newlineChar = compose("\x00B6");
spaceChar = compose("\x00B7");
endOfTextChar = compose("\x2403");
while strlength(genText) < maxLength
    [net,charScores] = predictAndUpdateState(net,X,'ExecutionEnvironment','cpu');
    % charScores作为权重，从词汇表中随机抽取字符
    newChar = datasample(vocabulary,1,'Weights',charScores);
    % 如果生成了文本结束符，就结束生成
    if newChar == endOfTextChar
        break;
    end
    genText = genText + newChar;
    X = double(char(newChar));
end
% 换回换行符和空格
genText = replace(genText,[newlineChar spaceChar],[newline " "]);
end