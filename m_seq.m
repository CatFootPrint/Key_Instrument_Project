%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%name:mseq
%detail:generate the m sequence
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Input:
%length_of_sequence:length of m sequence
%delay:delay in time domain
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%output:
%msequence:the m sequence
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%generating the m sequence
function msequence=m_seq(length_of_sequence)
%N=1000;%length of m sequence
index=ceil(log(length_of_sequence)/log(2));%index denotes the index of length of m sequence
if index==log(length_of_sequence)/log(2)
    index=index+1;
else
end
m_full=idinput((2^index-1),'prbs',[0,1],[-1,1]);%m_full is m sequence with length of 2^index
mseq=m_full(1:length_of_sequence);%mseq is m sequence with length of N
%testing the m sequence
% delay=20;%delay in time domain
% mseq_delay=[mseq,mseq];%combining two m sequence together
% mseq_delay=mseq_delay(delay+1:(delay+N));%mseq_delay denotes the m sequence with delay
% syn(m_full,mseq_delay);%test the m sequence
msequence=reshape(mseq,numel(mseq),1);
end