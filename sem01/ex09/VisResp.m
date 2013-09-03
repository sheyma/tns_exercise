function r = VisResp( s )
% Poisson distributed response r
% in dependence on light level s > 0
% background response level darkLight = 3;
% 
% if s is a vector, then r is another vector of the same size

darkLight = 3;

xrand=rand(size(s));

r=poissinv(xrand,darkLight+s);

