function y = f(d_min=18,d_max=70,s_min=2,s_max=8)
	i = k = 0;
	x = d_min:0.0001:d_max;
	s = s_min:1:s_max;
	y =[0 0 0];
	for j = 1:length(s) 
		for i = 1: length(x)
			val = (360 - s(j)*(30+(180/pi)*atan(20/(x(i)))))/((180/pi)*atan(20/(x(i))));
			if (abs(val - ceil(val)) < 0.001) && (val>0)
				k++;
				y = [y;x(i),val,s(j)];
			end	
		end
	end
	y
