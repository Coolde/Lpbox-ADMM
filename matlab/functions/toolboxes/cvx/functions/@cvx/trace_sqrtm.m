function cvx_optval = trace_sqrtm( X ) %#ok

%TRACE_SQRTM   Internal cvx version.

error( nargchk( 1, 1, nargin ) ); %#ok
if ndims( X ) > 2, %#ok
    error( 'trace_inv is not defined for N-D arrays.' );
elseif ~cvx_isaffine( X ),
    error( 'Input must be affine.' );
end
n = size(X,1);
if n ~= size( X, 2 ),
    error( 'Matrix must be square.' );
end

%
% Construct problem
% 

Y = [];
cvx_begin sdp
    if isreal(X),
        variable Y(n,n)
    else
        variable Y(n,n) complex
    end
    maximize(real(trace(Y))); 
    [eye(n),Y;Y',X] >= 0; %#ok
cvx_end

% Copyright 2005-2014 CVX Research, Inc. 
% See the file LICENSE.txt for full copyright information.
% The command 'cvx_where' will show where this file is located.
