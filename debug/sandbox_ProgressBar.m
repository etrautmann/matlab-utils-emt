
N = 5;
prog = ProgressBar(N, 'Embedding data over trials into common time vector');

for ii = 1:N
    prog.update(ii)
end

prog.finish();  