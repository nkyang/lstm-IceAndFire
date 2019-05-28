function [iceAndFire,XTrain,YTrain] = readData()
parNum = 0;
newlineChar = compose("\x00B6");
spaceChar = compose("\x00B7");
endofTextChar = compose("\x2403");
tabChar = char(compose("\x3000"));
for ii = 1:5
    fid = fopen(['data\冰与火之歌' num2str(ii) '.txt'],'rt','n','UTF-8');
    currStr = [];
    while(~feof(fid))
        tmp = fgets(fid);
        % 去掉制表符
        tmp(tmp == tabChar) = []; 
        % 去掉行首的空格
        while length(tmp)>=20 && tmp(1) == ' '
            tmp(1) = [];
        end
        if length(tmp)>=20
            currStr = [currStr tmp];
        end
        if length(currStr) >= 1000  %舍弃字符数小于20的行
            % categorical函数无法识别换行符和空格
            % 需要先将换行符替换成特定字符。
            % 如果文本中还有别的无法识别的字符，建议手动删除
            currStr = replace(currStr,[newline " "],[newlineChar spaceChar]);
            parNum = parNum+1;
            iceAndFire{parNum} = currStr;
            charShifted = [cellstr(currStr(2:end)')' endofTextChar];
            XTrain{parNum} = double(currStr);
            YTrain{parNum} = categorical(charShifted);
            seqLength(parNum) = size(XTrain{parNum},2);
            currStr = [];
        end
    end
    fclose(fid);
end
% 排序 使训练时同一批序列长度相近
% 训练时同一个batch会自动填充
% [~,idx] = sort(seqLength);
% XTrain = XTrain(idx);
% YTrain = YTrain(idx);
end