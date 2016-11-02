% function test_function_kernel()
clear;
close all;
global signal_complex;
data=csvread('bpsk_-60dBm.csv');
number=1000;
fo=0.01;
QAM_mod=comm.RectangularQAMModulator('ModulationOrder',8);
QAM_Demod=comm.RectangularQAMDemodulator('ModulationOrder',8);
code=randi(8,number,1)-1;
% s_QAM=step(QAM_mod,repmat((0:7)',number,1));
s_QAM=step(QAM_mod,code);
s_QAM_offset=s_QAM.*transpose(exp(1i*fo*(0:(numel(s_QAM)-1))));
s_QAM_offset=awgn(s_QAM_offset,30);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
signal_receive=Windows_receive(data(:,1)+1i*data(:,2),100);
signal=[real(signal_receive),imag(signal_receive)];
signal=[real(s_QAM_offset),imag(s_QAM_offset)];
signal_complex=signal*[1;1i];
% signal_complex=1;
hx=signal(:,1);
hy=signal(:,2);
hx=median(abs(hx-median(hx)))/0.6745*(4/3/numel(signal)/2)^0.2;
hy=median(abs(hy-median(hy)))/0.6745*(4/3/numel(signal)/2)^0.2;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
bandwidth=hy;
% kernel = @(x)-ones(1,numel(signal_complex))*exp(-(abs(x(1)-signal_complex.*exp(1i*x(2)*(0:(numel(signal_complex)-1))'))).^2/bandwidth^2);




xstart = [median(abs(signal_complex))/2,median(abs(signal_complex))/2,0.01];
%     function output=kernel_add(x)
%         bandwidth=10;
% fun = -exp(-((abs(x(1)-real(signal_complex.*transpose(exp(1i*x(3)*(0:(numel(signal_complex)-1))))))).^2+(abs(x(2)-imag(signal_complex.*transpose(exp(1i*x(3)*(0:(numel(signal_complex)-1))))))).^2)/bandwidth^2)/numel(signal_complex);
% output=sum(fun);
%     end
% kernel=@kernel_add;
% kernel = @(x) -1*ones(1,numel(signal_complex))*exp(-((abs(x(1)-real(signal_complex.*transpose(exp(1i*x(3)*(0:(numel(signal_complex)-1))))))).^2+(abs(x(2)-imag(signal_complex.*transpose(exp(1i*x(3)*(0:(numel(signal_complex)-1))))))).^2)/bandwidth^2);
kernel = @(x) -1*ones(1,numel(signal_complex))*exp(-((abs(x(1)+1i*x(2)-(signal_complex.*transpose(exp(1i*x(3)*(0:(numel(signal_complex)-1))))))).^2)/bandwidth^2);

%     function output=kernel(x)
%         output =-ones(1,numel(signal_complex))*exp(-(abs(x(1)-signal_complex.*transpose(exp(1i*x(2)*(0:(numel(signal_complex)-1)))))).^2/bandwidth^2);
% %         signal_complex(1)
%     end


type brownfgh;

options = optimoptions(@fminunc,'Display','iter','Algorithm','quasi-newton','HessUpdate','steepdesc');



% x= fminunc(kernel,xstart);
% [x,value,exitflag] = fminsearch(kernel,[0,0.01]);
[x,value,exitflag] = fminunc(kernel,xstart,options);

% end
position=x(1)+1i*x(2);
frequency_offset=x(3);
fprintf(['position is ',num2str(x(1)),'+',num2str(x(2)),'i','\n']);
fprintf(['frequency offset is ',num2str(frequency_offset),'\n']);
fprintf(['flag is ',num2str(exitflag),'\n']);
fprintf(['valuse is ',num2str(value),'\n']);
signal_recover=signal_complex.*transpose(exp(1i*frequency_offset*(0:(numel(signal_complex)-1))));
figure(1);
scatter(real(signal_complex),imag(signal_complex),'.');
axis equal;
grid on;
title('original signal');
figure(2);
scatter(real(signal_recover),imag(signal_recover),'.');
axis equal;
grid on;
title('recovered signal');


% frequency_offset_adjust=frequency_offset+pi/7;
% signal_recover=signal_complex.*transpose(exp(1i*frequency_offset_adjust*(0:(numel(signal_complex)-1))));
% figure(3);
% scatter(real(signal_complex),imag(signal_complex),'.');
% axis equal;
% grid on;
% title('original signal');
% figure;
% scatter(real(signal_recover),imag(signal_recover),'.');
% axis equal;
% grid on;
% title('adjust signal');









% function bandwidth=band(data)
% global N A2 I
% if nargin<2
%     n=2^8;
% end
% n=2^ceil(log2(n)); % round up n to the next power of 2;
% N=size(data,1);
% if nargin<3
%     MAX=max(data,[],1); MIN=min(data,[],1); Range=MAX-MIN;
%     MAX_XY=MAX+Range/4; MIN_XY=MIN-Range/4;
% end
% scaling=MAX_XY-MIN_XY;
% if N<=size(data,2)
%     error('data has to be an N by 2 array where each row represents a two dimensional observation')
% end
% transformed_data=(data-repmat(MIN_XY,N,1))./repmat(scaling,N,1);
% %bin the data uniformly using regular grid;
% initial_data=ndhist(transformed_data,n);
% % discrete cosine transform of initial data
% a= dct2d(initial_data);
% % now compute the optimal bandwidth^2
%   I=(0:n-1).^2; A2=a.^2;
% 
%  t_star=fzero( @(t)(t-evolve(t)),[0,0.1]);
% 
% p_02=func([0,2],t_star);p_20=func([2,0],t_star); p_11=func([1,1],t_star);
% t_y=(p_02^(3/4)/(4*pi*N*p_20^(3/4)*(p_11+sqrt(p_20*p_02))))^(1/3);
% t_x=(p_20^(3/4)/(4*pi*N*p_02^(3/4)*(p_11+sqrt(p_20*p_02))))^(1/3);
% % smooth the discrete cosine transform of initial data using t_star
% a_t=exp(-(0:n-1)'.^2*pi^2*t_x/2/sigma^2)*exp(-(0:n-1).^2*pi^2*t_y/2/sigma^2).*a; 
% % now apply the inverse discrete cosine transform
% if nargout>1
%     density=idct2d(a_t)*(numel(a_t)/prod(scaling));
%     [X,Y]=meshgrid(MIN_XY(1):scaling(1)/(n-1):MAX_XY(1),MIN_XY(2):scaling(2)/(n-1):MAX_XY(2));
% end
% bandwidth=sqrt([t_x,t_y]).*scaling; 
% end
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function binned_data=ndhist(data,M)
% % this function computes the histogram
% % of an n-dimensional data set;
% % 'data' is nrows by n columns
% % M is the number of bins used in each dimension
% % so that 'binned_data' is a hypercube with
% % size length equal to M;
% [nrows,ncols]=size(data);
% bins=zeros(nrows,ncols);
% for i=1:ncols
%     [~,bins(:,i)] = histc(data(:,i),0:1/M:1,1);
%     bins(:,i) = min(bins(:,i),M);
% end
% % Combine the  vectors of 1D bin counts into a grid of nD bin
% % counts.
% binned_data = accumarray(bins(all(bins>0,2),:),1/nrows,M(ones(1,ncols)));
% end
% 
% function data = idct2d(data)
% % computes the 2 dimensional inverse discrete cosine transform
% [nrows,ncols]=size(data);
% % Compute wieghts
% w = exp(1i*(0:nrows-1)*pi/(2*nrows)).';
% weights=w(:,ones(1,ncols));
% data=idct1d(idct1d(data)');
%     function out=idct1d(x)
%         y = real(ifft(weights.*x));
%         out = zeros(nrows,ncols);
%         out(1:2:nrows,:) = y(1:nrows/2,:);
%         out(2:2:nrows,:) = y(nrows:-1:nrows/2+1,:);
%     end
% end
% 
% 
% function data=dct2d(data)
% % computes the 2 dimensional discrete cosine transform of data
% % data is an nd cube
% [nrows,ncols]= size(data);
% if nrows~=ncols
%     error('data is not a square array!')
% end
% % Compute weights to multiply DFT coefficients
% w = [1;2*(exp(-1i*(1:nrows-1)*pi/(2*nrows))).'];
% weight=w(:,ones(1,ncols));
% data=dct1d(dct1d(data)')';
%     function transform1d=dct1d(x)
% 
%         % Re-order the elements of the columns of x
%         x = [ x(1:2:end,:); x(end:-2:2,:) ];
% 
%         % Multiply FFT by weights:
%         transform1d = real(weight.* fft(x));
%     end
% end