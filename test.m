function test()
clear;
close all;
N=511;
% number=1000;
% code=randi(8,number,1)-1;
% QAM_mod=comm.RectangularQAMModulator('ModulationOrder',8);
% QAM_Demod=comm.RectangularQAMDemodulator('ModulationOrder',8);
% s_QAM=step(QAM_mod,code);
% s_QAM=abs(s_QAM)/(max(abs(s_QAM)));
mseq=m_seq(N);
% receive=[s_QAM;mseq;s_QAM;mseq;s_QAM;sin((1:100)')];
receive=(csvread('bpsk_-60dBm_recover.csv'));
receive=receive(:,1)+1i*receive(:,2);
% receive=receive(2041:end);
% po=mean(angle(receive));
% receive=receive*exp(-1i*po);
figure;
scatter(real(receive),imag(receive));axis equal;
grid on;
title('Constelation of original data');
[output,position,position_label]=syn_simple(receive,mseq);
[~,location]=findpeaks(abs(output),position_label,'MinPeakHeight',0.75*max(abs(output)));
    if numel(location)>=2
        length_of_frame=median(diff(location));
    else
        length_of_frame=numel(receive);
    end
    if location~=1
        receive_head=receive(1:location-1);
        receive_frame=receive(location:end);
        [output_head,position_head]=corr_part(receive_head,mseq);
        [output_frame,position_frame]=corr_frame(receive_frame,mseq,length_of_frame);
        output=[output_head;output_frame];
        position_2=[position_head;position_frame];
    elseif localtion==1
        receive_frame=receive(location:end);
        [output_frame,position_frame]=corr_frame(receive_frame,mseq,length_of_frame);
        output=output_frame;
        position_2=position_frame;
    end
    output=output/max(output);
% number_of_frame=((numel(receive)-position+1)-mod((numel(receive)-position+1),length_of_frame))/length_of_frame;
% output=Inf*ones(numel(receive),1);
% for counter=1:number_of_frame
%     if counter==1
%         position_iteration=position;
%         receive_iteration=receive(1:position_iteration-2+length_of_frame);
%     elseif counter>1&&counter<number_of_frame
%         position_iteration=1;
%         receive_iteration=receive(position_iteration-1+length_of_frame*(counter-1):position_iteration-1+length_of_frame*counter-1);
%     elseif counter==number_of_frame
%         position_iteration=1;
%         receive_iteration=receive(position_iteration-1+length_of_frame*(counter-1):end);
%     end
%     [output_iteration,~]=corr_in_segment(receive_iteration,mseq,position_iteration);
%     figure;
%     stem(1:numel(output_iteration),output_iteration,'.');grid on;
%     label_begin_to_wright=find(output==Inf);
%     label_head=label_begin_to_wright(1);
%     output(label_head:label_head+numel(output_iteration)-1)=output_iteration;
% end
fprintf(['Position is ',num2str(position),'\n']);
figure;
stem(1:numel(output),output,'.');
title(['The head of signal frame is ',num2str(position)]);
text(position+3,0.98,['\leftarrow peak is in ',num2str(position)]);
grid on;
end
function [c_norm,syn_position,position_label]=syn_simple(receive,local)
receive=reshape(receive,numel(receive),1);%convert the receive signal to column vector
local=reshape(local,numel(local),1);%convert the local m sequence to column vector
[c,position]=xcorr(receive,local);%calculate the cross-correlation between received signal and local m sequence to calculate the delay in time domain
position_label=position;
c_norm=c/max(c);%normalization
[~,location]=max(abs(c_norm));%search the summit of ross-correlation function
% position=position-min(position);
position=position.*(position>0);
syn_position=position(location)+1;%find out the postion of summit
fprintf(['\n','The delay in time domain is ',num2str(syn_position),'\n']);%print the screen
figure;
stem(position,abs(c_norm),'.');%figure out;
grid on;%
title(['The delay in time domain is ',num2str(syn_position)]);%
hold on;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [output,position]=corr_in_segment(receive,local,begin_position)
% if begin_position>1
    receive_previous=receive(1:begin_position-1);
    if begin_position-1<numel(local)
        [output_previous,position_previous]=corr_part(receive_previous,local);
    elseif begin_position-1>=numel(local)
        number_of_mseq=(numel(receive_previous)-mod(numel(receive_previous),numel(local)))/numel(local);
        previous_res=numel(receive_previous)-number_of_mseq*numel(local);
        receive_previous_previous=receive_previous(1:previous_res);
        receive_previous_end=receive_previous(previous_res+1:end);
        [output_previous_previous,position_previous_previous]=corr_part(receive_previous_previous,local);
        [output_previous_end,position_previous_end]=corr_middle(receive_previous_end,local);
        output_previous=[output_previous_previous;output_previous_end];
        position_previous=[position_previous_previous;position_previous_end];
    end
    receive_res=receive(begin_position:end);
    length_of_res=numel(receive_res);
    if length_of_res==mod(length_of_res,numel(local));
        receive_end=receive_res;
        [output_res,position_res]=corr_part(receive_end,local);
    end
    if length_of_res>mod(length_of_res,numel(local));
        length_of_end=mod(length_of_res,numel(local));
        length_of_middle=numel(receive_res)-length_of_end;
        receive_middle=receive_res(1:length_of_middle);
        receive_end=receive_res(length_of_middle+1:end);
        [output_middle,position_middle]=corr_middle(receive_middle,local);
        [output_end,position_end]=corr_part(receive_end,local);
        output_res=[output_middle;output_end];
        position_res=[position_middle;position_end];
    end
    if begin_position>1
    output=[output_previous;output_res];
    output=output/max(output);
    position=[position_previous;position_res];
    elseif begin_position==1
        output=[output_res];
        output=output/max(output);
        position=[position_res];
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [output,position]=corr_part(receive,local)
times_of_label=(numel(receive)-mod(numel(receive),numel(local)))/numel(local);
local_rep=repmat(local,times_of_label+1,1);
local_crap=local_rep(1:numel(receive));
 [output,position]=corr_mseq(receive,local_crap);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function [output,position]=corr_part(receive,local)
% local=local(1:numel(receive));
%  [output,position]=corr_mseq(receive,local);
% end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [output,position]=corr_middle(receive,local)
number_of_mseq=numel(receive)/numel(local);
output=nan*ones(numel(receive),1);
position=nan*ones(numel(receive),1);
for counter=1:number_of_mseq
    select_section=((counter-1)*numel(local)+1):((counter-1)*numel(local)+numel(local));
    [output(select_section),position(select_section)]=corr_mseq(receive(select_section),local);
end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [output,position]=corr_frame(receive,local,length_of_frame)
number_of_frame=(numel(receive)-mod(numel(receive),length_of_frame))/length_of_frame;
receive_full_frame=receive(1:number_of_frame*length_of_frame);
output=Inf*ones(numel(receive),1);
position=Inf*ones(numel(receive),1);
for counter=1:number_of_frame
    receive_select=receive_full_frame((counter-1)*length_of_frame+1:counter*length_of_frame-1);
    mseq_select=receive_select(1:numel(local));
    signal_select=receive_select(numel(local)+1:end);
    label_begin_to_wright=find(output==Inf);
    label_head=label_begin_to_wright(1);
    [output(label_head:numel(mseq_select)+label_head-1),position(label_head:numel(mseq_select)+label_head-1)]=corr_mseq(mseq_select,local);
    label_begin_to_wright=find(output==Inf);
    label_head=label_begin_to_wright(1);
    [output(label_head:numel(signal_select)+label_head-1),position(label_head:numel(mseq_select)+label_head-1)]=corr_part(signal_select,local);
end
receive_res=receive(number_of_frame*length_of_frame+1:end);
if numel(receive_res)<numel(local)
    label_begin_to_wright=find(output==Inf);
    label_head=label_begin_to_wright(1);
    [output(label_head:numel(receive_res)+label_head-1),position(label_head:numel(receive_res)+label_head-1)]=corr_part(receive_res,local);
elseif numel(receive_res)>numel(local)
    mseq_res=receive_res(1:numel(local));
    signal_res=receive_res(numel(local)+1:end);
    label_begin_to_wright=find(output==Inf);
    label_head=label_begin_to_wright(1);
    [output(label_head:numel(mseq_res)+label_head-1),position(label_head:numel(mseq_res)+label_head-1)]=corr_mseq(mseq_res,local);
    label_begin_to_wright=find(output==Inf);
    label_head=label_begin_to_wright(1);
    [output(label_head:numel(signal_res)+label_head-1),position(label_head:numel(signal_res)+label_head-1)]=corr_part(signal_res,local);
elseif numel(receive_res)==numel(local)
    mseq_res=receive_res(1:numel(local));
    label_begin_to_wright=find(output==Inf);
    label_head=label_begin_to_wright(1);
    [output(label_head:numel(mseq_res)+label_head-1),position(label_head:numel(mseq_res)+label_head-1)]=corr_mseq(mseq_res,local);
end
output=output.*(output<Inf);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%END OF PROGRAM