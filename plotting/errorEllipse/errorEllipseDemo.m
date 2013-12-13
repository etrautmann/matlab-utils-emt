n = 1000;
mu = [0 0 0];
sig = [1 0.7 .3;
        .7 1 .6;
        .3 .6 1;];
D = mvnrnd(mu,sig,n);

figure(8); clf;
plot3(D(:,1), D(:,2), D(:,3),'g.')
grid; axis equal
hold on
error_ellipse_emt(cov(D))
camlight; lighting gouraud


[v,d] = eig(cov(D))
v*d*v'

v2 = flipud(fliplr(v));
d2 = flipud(fliplr(d));

v2*d2*v2'

[u3,s3,v3] = svd(cov(D));

u3*s3*v3'

%% 2D case

n = 1000;
mu = [0 0 ];
sig = [1 .9;
       .9 1];
D = mvnrnd(mu,sig,n);

figure(8); clf;
plot(D(:,1), D(:,2),'g.')
grid; axis equal
hold on
error_ellipse(cov(D))


[v,d] = eig(cov(D))
v*d*v'

v2 = flipud(fliplr(v));
d2 = flipud(fliplr(d));

v2*d2*v2'

[u3,s3,v3] = svd(cov(D));

u3*s3*v3'