function [hstgrm,varargout] = makedenshist(Z,nbins)
% Make a density histogram with nbins bins out of the data in Z.
% We return the 2-by-nbins array hstgrm, where
% hstgrm(1,:) = the list of bin centers, and
% hstgrm(2,:) = normalized histogram heights.
%
% The command
%
% hstgrm = makedenshist(Z,nbins)
%
% always prints the minimum and maximum data samples,
% denoted by minZ and maxZ. Alternatively, the command
%
% [hstgrm,minZ,maxZ] = makedenshist(Z,nbins)
%
% returns these values to you without printing them.
hstgrm = zeros(2,nbins); % Pre-allocate space
minZ = min(Z); % Determine range of data
maxZ = max(Z);
if nargout==3
varargout{1} = minZ;
varargout{2} = maxZ;
else
fprintf('makedenshist: Data range = [ %g , %g ].\n',minZ,maxZ)
end
e = linspace(minZ,maxZ,nbins+1); % Set edges of bins
a = e(1:nbins); % Compute centers of bins
b = e(2:nbins+1); % and store result in
hstgrm(1,:) = (a+b)/2; % hstgrm(1,:)
H = histc(Z,e); % Get bin heights
H(nbins) = H(nbins)+H(nbins+1); % Put any hits on right-most
% edge into last bin
% Compute and store the normalized bin heights
bw = (maxZ-minZ)/nbins;
hstgrm(2,:) = H(1:nbins)/(bw*length(Z));
