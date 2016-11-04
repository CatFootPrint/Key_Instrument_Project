function [reg_input,output]=manage_data(input,number_column)
    sps=100;
    complex_input=input*[1;1i];
    window_input=Windows_receive(complex_input,sps);
%     window_input=window_input(sps+1:end);
    reg_input=reshape(window_input,number_column/2,numel(window_input)*2/number_column);
    output=kron(real(reg_input),[1;0])+kron(imag(reg_input),[0;1]);
end