% function output=corr_mseq(mseq)
% mseq=reshape(mseq,numel(mseq),1);
% output=Inf*ones(2*numel(length(mseq))-1,1);
% for position=-length(mseq)+1:length(mseq)-1
%     output(position+length(mseq))=sum(mseq.*circshift(mseq,position));
% end
% output=output/max(output);
% end
function [output,position]=corr_mseq(mseq_receive,mseq_local)
mseq_receive=reshape(mseq_receive,numel(mseq_receive),1);
mseq_local=reshape(mseq_local,numel(mseq_local),1);
output=nan*ones(2*numel(length(mseq_receive))-1,1);
% for position=-length(mseq_receive)+1:length(mseq_receive)-1
for position=0:length(mseq_receive)-1
    output(position+1)=abs(sum(mseq_receive.*circshift(mseq_local,position)));
end
% output=output/max(output);
output=reshape(output,numel(output),1);
[~,position]=max(output);
% figure;
% stem(0:numel(output)-1,output,'.');
% grid on;
end
