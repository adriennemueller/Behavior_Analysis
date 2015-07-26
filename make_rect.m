function make_rect( Iheight, Iwidth, Rheight, Rwidth, angle )

    % Define the image size for the background
    img = false(Iwidth, Iheight);

    % Make the rectangle
    left   = Iwidth/2  - Rwidth/2;
    right  = Iwidth/2  + Rwidth/2;
    top    = Iheight/2 - Rheight/2;
    bottom = Iheight/2 + Rheight/2;

    img(left:right, top:bottom) = true;


hdl = imshow(img); hold on;


% theta = angle*(pi/180);
% coords = [center(1)-(width/2) center(1)-(width/2) center(1)+(width/2)  center(1)+(width/2);...
%           center(2)-(height/2) center(2)+(height/2) center(2)+(height/2)  center(2)-(height/2)]
% R = [cos(theta) sin(theta);...
%     -sin(theta) cos(theta)];
% rot_coords = R*(coords-repmat(center,[1 4]))+repmat(center,[1 4]);
% rot_coords(:,5)=rot_coords(:,1);
% line(rot_coords(1,:),rot_coords(2,:),'LineWidth',3);

    
    
    
    
    
end