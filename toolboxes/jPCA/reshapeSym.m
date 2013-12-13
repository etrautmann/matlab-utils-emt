%%%%%%%%%%%%%%%%%%%%%%%%%
% John P Cunningham
% 2011
%
% reshapeSym.m
%
% symPCA support function
%
% A symmetric matrix xMat of size n by n really only
% has n*(n+1)/2 unique entries.  That is, the diagonal and the
% upper/lower triangle is the transpose of the lower/upper.  So,
% we can just think of such a matrix as a vector x of size n(n+1)/2.  This
% function reshapes such a vector into the appropriate symmetric
% matrix.  
% 
% The required ordering in x is row-minor, namely that xMat(1,1) = x(1),
% xMat(2,1) = x(2), xMat(3,1) = x(3), and so on.
%
% This function goes either from vector to matrix or vice versa, depending
% on what the argument x is.
%
% In short, this function just reindexes a vector to a matrix or vice
% versa.
%%%%%%%%%%%%%%%%%%%%%%%%


function [ Z ] = reshapeSym( x )

    % this reshapes a n(n+1)/2 vector to a n by n symmetric matrix, or vice versa.
    % First we must check if x is a matrix or a vector.
    if isvector(x)
        % then we are making a matrix
        
        % first get the size of the appropriate matrix
        % this should be n(n+1)/2 entries.
        % this is the positive root
        n = (-1 + sqrt(1 + 8*length(x)))/2;
        % error check
        if n~=round(n) % if not an integer
            % this is a bad argument
            fprintf('ERROR... the size of the x vector prevents it from being shaped into a symmetric matrix.\n');
            keyboard;
        end
        
        % now make the matrix
        % initialize the return matrix
        Z = zeros(n);
        % and the marker index
        indMark = 1;
        
        for i = 1 : n
            % add the elements as appropriate.
            Z(i:end,i) = x(indMark:indMark+(n-i));
            % now update the index Marker
            indMark = indMark + (n-i)+1;
        end
        
        % remove the diagonal.
        dZ = diag(diag(Z));
        Z = Z - dZ;
        % now add the symmetric part
        Z = Z + Z';
        % add back the diagonal.
        Z = Z + dZ;
        
    else
        % then we are making a vector from a matrix (note that the 
        % standard convention of lower case being a vector and upper case
        % being a matrix is now reversed).
        
        % first check that everything is appropriately sized and
        % symmetric
        if size(x) ~= size(x')
            % this is not symmetric
            fprintf('ERROR... the matrix x is not square, let alone symmetric.\n');
            keyboard;
        end
        % now check for skew symmetry
        if abs(norm(x - x'))>1e-8
            % this is not symmetric.
            fprintf('ERROR... the matrix x is not symmetric.\n');
            keyboard;
        end
        % everything is ok, so take the size
        n = size(x,1);
       
        
        % now make the vector Z
        indMark = 1;
        for i = 1 : n
            % add the elements into a column vector as appropriate.
            Z(indMark:indMark+(n-i),1) = x(i:end,i);
            % now update the index Marker
            indMark = indMark + (n-i)+1;
        end
        
    end
                
end