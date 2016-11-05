function center=draw_cluster(data,IDX,k)
   center=Inf*ones(k,1);
   for label=1:k
   execution=['cluster',num2str(label),'=find(IDX==label);'];
   eval(execution);
   string_temp=['temp=cluster',num2str(label),';'];
   eval(string_temp);
   signal_of_k=data(temp);
   scatter(real(signal_of_k),imag(signal_of_k),'.');
   center(label,1)=mean(temp);
   hold on;
   axis equal;
   grid on;
   end
end