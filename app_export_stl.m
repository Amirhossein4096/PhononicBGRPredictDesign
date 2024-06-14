function meshout = app_export_stl(pars,fig)
lattice_length = 1;
substrate_thick = pars(1);
pillar_radius = pars(2);
pillar_height = pars(3);
color = [0.8,0.8,0.8];
MinEdgeLength = fig.UserData.MinEdgeLength;
MaxEdgeLength = fig.UserData.MaxEdgeLength;
rect=shape.Box("Length",lattice_length,"Width",lattice_length,"Height",substrate_thick,"Center",[0,0,substrate_thick/2],"Color",color);
circ = shape.Circle("Radius",pillar_radius,"NumPoints",200,"Color",color);
[~] = translate(circ,[0 0 substrate_thick]);
extShape = extrude(rect,circ,"Height",pillar_height);
% extShape = extShape+circ;
[~] = translate(circ,[0 0 pillar_height]);
extShape = extShape+circ;
meshshape = extShape.copy;
m=mesh(meshshape,"MinEdgeLength",MinEdgeLength,"MaxEdgeLength",MaxEdgeLength);
% meshshape.mesh("MinEdgeLength",MinEdgeLength,"MaxEdgeLength",MaxEdgeLength);
close
meshout = meshshape;
end