function [] = latf(X, text)

if nargin < 2
    text = []
end

disp('===============================================================')
disp('\[')
disp([ text ' = '])
disp('\begin{bmatrix} ')

latex(X,'%1.2f','nomath')
disp('\end{bmatrix}')
disp('\]')

disp('===============================================================')

end