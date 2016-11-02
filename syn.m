%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Name:syn.m
%Function:calculate the delay in time domain
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Input:
%receive:received signal
%local:local m sequence which is used to calculate the delay in time domain
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [output,position]=syn(receive,local)
head=10;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%convert the input data to column vector
receive=reshape(receive,numel(receive),1);%convert the receive signal to column vector
receive=[zeros(head,1);receive];
local=reshape(local,numel(local),1);%convert the local m sequence to column vector
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%Initiation
[~,begin_position]=scan(receive,local);
[output,~]=corr_in_segment(receive,local,begin_position);
output=output(head+1:end);
[~,position]=max(output);
output=output/max(output);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [max_iteration,begin_position]=scan(receive,local)
output_buffer=nan*ones(numel(local),numel(receive)-numel(local));%kth column is the kth element in one iteration, mth row is the mth iteration
position_buffer=nan*ones(numel(local),numel(receive)-numel(local));%kth column is the kth element in one iteration, mth row is the mth iteration
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%select a piece of signal
for position_select=1:numel(receive)+1-numel(local)
    position_select_in_iteration=position_select:(position_select+numel(local)-1);
    receive_select_in_iteration=receive(position_select_in_iteration);
    [output_in_iteration,position_in_iteration]=corr_mseq(receive_select_in_iteration,local);
    output_buffer(:,position_select)=output_in_iteration;
    position_buffer(:,position_select)=position_in_iteration;
end
[peaks_in_one_iteration,~]=max(output_buffer);
[max_iteration,position_max_iteration]=max(peaks_in_one_iteration);
begin_position=position_max_iteration;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [output,position]=corr_in_segment(receive,local,begin_position)
% if begin_position>1
    receive_previous=receive(1:begin_position-1);
    if begin_position-1+numel(receive)-mod(numel(receive),numel(local))<=numel(receive)
        receive_middle=receive(begin_position:begin_position-1+numel(receive)-mod(numel(receive),numel(local)));
        receive_res=receive(begin_position+numel(receive)-mod(numel(receive),numel(local)):end);
        local_rep=repmat(local,1+numel(receive)-mod(numel(receive_previous),numel(local)),1);
        [output_previous,position_previous]=corr_mseq(receive_previous,local_rep(1:numel(receive_previous)));
    %     [output_middle,position_middle]=corr_mseq(receive_middle,local(1:numel(receive_middle)));
    output_middle=nan*ones(numel(receive)-mod(numel(receive),numel(local)),1);
    position_middle=nan*ones(numel(receive)-mod(numel(receive),numel(local)),1);
        for times=1:(numel(receive)-mod(numel(receive),numel(local)))/numel(local)
            select_section=(times-1)*numel(local)+1:(times-1)*numel(local)+numel(local);
            receive_piece=receive_middle(select_section);
            [output_middle(select_section),position_middle(select_section)]=corr_mseq(receive_piece,local);
        end
        [output_res,position_res]=corr_mseq(receive_res,local(1:numel(receive_res)));
        output=[output_previous;output_middle;output_res];
        position=[position_previous;position_middle;position_res];
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if begin_position-1+numel(receive)-mod(numel(receive),numel(local))>numel(receive)
        receive_res=receive(begin_position+(numel(receive)-mod(numel(receive),numel(local))):end);
        local_rep=repmat(local,1+numel(receive)-mod(numel(receive_previous),numel(local)),1);
        [output_previous,position_previous]=corr_mseq(receive_previous,local_rep(1:numel(receive_previous)));
    %     [output_middle,position_middle]=corr_mseq(receive_middle,local(1:numel(receive_middle)));
        [output_res,position_res]=corr_mseq(receive_res,local(1:numel(receive_res)));
        output=[output_previous;output_res];
        position=[position_previous;position_res];
    end
% end
% if begin_position==1
% %         receive_previous=receive(1:begin_position-1);
%     if begin_position-1+numel(local)*mod(numel(receive),numel(local))<=numel(receive)
%         receive_middle=receive(begin_position:begin_position-1+numel(local)*mod(numel(receive),numel(local)));
%         receive_res=receive(begin_position+numel(local)*mod(numel(receive),numel(local)):end);
% %         local_rep=repmat(local,1+mod(numel(receive_previous),numel(local)),1);
% %         [output_previous,position_previous]=corr_mseq(receive_previous,local_rep(1:numel(receive_previous)));
%     %     [output_middle,position_middle]=corr_mseq(receive_middle,local(1:numel(receive_middle)));
%     output_middle=nan*ones(mod(numel(receive),numel(local)),1);
%     position_middle=nan*ones(mod(numel(receive),numel(local)),1);
%         for times=1:mod(numel(receive),numel(local))
%             select_section=(times-1)*numel(local)+1:(times-1)*numel(local)+numel(local);
%             receive_piece=receive_middle(select_section);
%             [output_middle(select_section),position_middle(select_section)]=corr_mseq(receive_piece,local);
%         end
%         [output_res,position_res]=corr_mseq(receive_res,local(1:numel(receive_res)));
%         output=[output_middle;output_res];
%         position=[position_middle;position_res];
%     end
%     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     if begin_position-1+numel(local)*mod(numel(receive),numel(local))>numel(receive)
%         receive_res=receive(begin_position+numel(local)*mod(numel(receive),numel(local)):end);
% %         local_rep=repmat(local,1+mod(numel(receive_previous),numel(local)),1);
% %         [output_previous,position_previous]=corr_mseq(receive_previous,local_rep(1:numel(receive_previous)));
%     %     [output_middle,position_middle]=corr_mseq(receive_middle,local(1:numel(receive_middle)));
%         [output_res,position_res]=corr_mseq(receive_res,local(1:numel(receive_res)));
%         output=[output_res];
%         position=[position_res];
%     end
% end
% [~,position]=max(output);
end
%END OF PROGRAM