function Head = scalarheader(q,num,H,info)
%SCALARHEADER specifies the blocks, connection and quantization parameters in the
%conceptual head stage for a scalar filter

%   Author(s): Honglei Chen
%   Copyright 1988-2004 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2009/07/27 20:31:28 $

NL = filtgraph.nodelist(3);

NL.setnode(filtgraph.node('input'),1);
NL.setnode(filtgraph.node('gain'),2);
NL.setnode(filtgraph.node('output'),3);

set(NL.nodes(1).block,'label','Input');
set(NL.nodes(2).block,'label','g');
set(NL.nodes(3).block,'label','Output');

set(NL.nodes(1).block,'orientation','right');
set(NL.nodes(2).block,'orientation','right');
set(NL.nodes(3).block,'orientation','right');

set(NL.nodes(1),'position',[0 0 0 0]);  %offset of the grid
set(NL.nodes(2),'position',[1 0 1 0]);  %offset of the grid
set(NL.nodes(3),'position',[2 0 2 0]);  %offset of the grid

%gain
set(NL.nodes(2),'qparam','single');

NL.connect(1,1,2,1);
NL.connect(2,1,3,1);

ng = NL.coeff2str(num(1),1);

% Specify coefficient name
nlbl = {};
if info.doMapCoeffsToPorts
    nlbl = sprintf('%s%d',info.coeffnames{1},1);
end

mainparams(2) = filtgraph.indexparam(2,ng,nlbl);
mainparams(1) = filtgraph.indexparam(1,{});
mainparams(3) = filtgraph.indexparam(3,{});


Head = filtgraph.stage(NL,[],[],[],[],mainparams);

