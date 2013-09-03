function da = angdiff( a1, a2 )

% compute difference between two angles -pi <= a1, a2 <=p

da =mod(a1-a2+pi,2*pi)-pi;