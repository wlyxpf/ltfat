function gdout=filterbankrealdual(g,a,varargin);
%FILTERBANKREALDUAL  Dual filters of filterbank for real signals only 
%   Usage:  gd=filterbankdual(g,a);
%
%   `filterabankdual(g,a)` computes the canonical dual filters of *g* for a
%   channel subsampling rate of *a* (hop-size). The dual filters work only
%   for real-valued signals. Use this function on the common construction
%   where the filters in *g* only covers the positive frequencies.
%
%   The format of the filters *g* are described in the
%   help of |filterbank|.
%
%   To actually invert the output of a filterbank, use the dual filters
%   together with `2*real(ifilterbank(...))`.
%
%   See also: filterbank, ufilterbank, ifilterbank

if nargin<2
  error('%s: Too few input parameters.',upper(mfilename));
end;

[a,M,longestfilter,lcm_a]=assert_filterbankinput(g,a);

definput.keyvals.L=[];
[flags,kv,L]=ltfatarghelper({'L'},definput,varargin);

if isempty(L)
  L=ceil(longestfilter/lcm_a)*lcm_a;
else
  if rem(L,lcm_a)>0
    error(['%s: Specified length L is incompatible with the length of ' ...
           'the time shifts. L = %i, lcm_a = %i'],upper(mfilename),L,lcm_a);
  end;
end;

if all(a==a(1))
  % Uniform filterbank, use polyphase representation
  a=a(1);
  
  G=zeros(L,M,assert_classname(g{1}));
  for ii=1:M
    G(:,ii)=fft(fir2long(g{ii},L));
  end;
  
  N=L/a;
  
  % This is the original code
  %for k=0:a-1
  %  Ha(k+1,:) =      G(mod(w-k*N,L)+1,:);
  %  Hb(k+1,:) = conj(G(mod(k*N-w,L)+1,:));
  %end;
  
  gd=zeros(N,M,assert_classname(g{1}));
  
  for w=0:N-1
    idx_a = mod(w-(0:a-1)*N,L)+1;
    idx_b = mod((0:a-1)*N-w,L)+1;
    Ha = G(idx_a,:);
    Hb = conj(G(idx_b,:));
    
    Ha=(Ha*Ha'+Hb*Hb')\Ha;
    
    gd(idx_a,:)=Ha;
  end;
  
  gd=ifft(gd)*a;
  
  if isreal(g)
    gd=real(gd);
  end;
  
  gdout=cell(1,M);
  for m=1:M
    gdout{m}=cast(gd(:,m),assert_classname(g{1}));
  end;
  
else

  error('Not implemented yet.');
  
end;
