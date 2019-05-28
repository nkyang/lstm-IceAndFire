function [iceAndFire,XTrain,YTrain] = readData()
parNum = 0;
newlineChar = compose("\x00B6");
spaceChar = compose("\x00B7");
endofTextChar = compose("\x2403");
tabChar = char(compose("\x3000"));
for ii = 1:5
    fid = fopen(['data\�����֮��' num2str(ii) '.txt'],'rt','n','UTF-8');
    currStr = [];
    while(~feof(fid))
        tmp = fgets(fid);
        % ȥ���Ʊ��
        tmp(tmp == tabChar) = []; 
        % ȥ�����׵Ŀո�
        while length(tmp)>=20 && tmp(1) == ' '
            tmp(1) = [];
        end
        if length(tmp)>=20
            currStr = [currStr tmp];
        end
        if length(currStr) >= 1000  %�����ַ���С��20����
            % categorical�����޷�ʶ���з��Ϳո�
            % ��Ҫ�Ƚ����з��滻���ض��ַ���
            % ����ı��л��б���޷�ʶ����ַ��������ֶ�ɾ��
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
% ���� ʹѵ��ʱͬһ�����г������
% ѵ��ʱͬһ��batch���Զ����
% [~,idx] = sort(seqLength);
% XTrain = XTrain(idx);
% YTrain = YTrain(idx);
end