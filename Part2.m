phi = @(z) z^2 - 1.5; %Anonymously Define function whose fixed points we seek
fixpt1 = sqrt(1.5); %The fixed points
fixpt2 = -sqrt(1.5);

colormap([1 0 0; 1 1 1]); %Points numbered 1 (inside) will be colored red
                          %Those numbered 2 (outside) will be white
M = 2*ones(247,247);    %Initialize array of point colors 2 (white)

for j = 1:247             %Try initial values with imaginary parts
    y = -1.23 + (j-1)*.01; % between -1 and 1
    for i = 1:247         % and with real parts 
        x = -1.23 + (i-1)*.01; % between -1 and 1
        z = x + 1i*y;
        zk = z;
        iflag1 = 0;    %iflag 1 & 2 count the number of iterations
        iflag2 = 0;    % when a root is within 1.e-6 of a fixed point
        kount = 0;     %Total # of iterations
        
        while(kount < 100 && abs(zk) < 2 && iflag1 < 5 && iflag2 < 5)
            kount = kount+1;
            zk = phi(zk);     %Fixed point iteration
            err1 = abs(zk-fixpt1); %test for convergence to fixpt1
            if err1 < 1.e-6, iflag1 = iflag1+1; else, iflag1 = 0; end
            err2 = abs(zk-fixpt2); %test for convergence to fixpt2
            if err2 < 1.e-6, iflag2 = iflag2+1; else, iflag2 = 0; end
        end
        if (iflag1 >= 5 || iflag2 >= 5 || kount >= 100) %If orbit is bounded
            M(j,i) = 1;          % set point color to 1 (red)
        end
    end
end

image([-10,10],[-10,10],M)  %plot the results
axis xy;                      %make sure vertical axis not inverted