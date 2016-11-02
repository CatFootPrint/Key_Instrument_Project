function output=manage_data(input,number_column)
    complex_input=input*[1;1i];
    reg_input=reshape(complex_input,number_column,numel(complex_input)*2/number_column);
    output=kron(real(reg_input),[1;0])+kron(imag(reg_input),[0;1]);
end