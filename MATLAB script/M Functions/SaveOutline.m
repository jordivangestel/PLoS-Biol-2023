function [] = SaveOutline(handles)

	M = handles.M;
	% ALWAYS COMPARE THE SUBSEQUENT IMAGES WITH EACH OTHER (THE FIRST IMAGE IS NOT ROTATED BY DEFAULT AND THE OTHER IMAGES ROTATE WITH REGARD TO THE FIRST IMAGE)
	for i = 1:M.N_FRAME
		if M.P{i}.BOUNDARY == 1
			display(i)
			display('saving outline...')
			LINE = M.S{i}.BOUNDARY;
			x = double(M.P{i}.D);
			y = double(M.P{i}.E);
			r = double(M.P{i}.C);
			M.S{i}.OUTLINE_A = LINE;
			rotate = M.P{i}.ROTATE;
			addrotate = 0;
			if i > 1
				for j = 1:(i-1)
					addrotate = addrotate + M.P{j}.ROTATE;
				end
			end
			LINE(:,1) = LINE(:,1) - x;
			LINE(:,2) = LINE(:,2) - y;
			M.S{i}.OUTLINE_B = LINE;
			for l = 1:length(LINE(:,1))
				d = sqrt(LINE(l,1)^2 + LINE(l,2)^2)/r;
				angle = atan(LINE(l,2)/LINE(l,1));
				if LINE(l,1) < 0
					angle = angle + pi;
				end
				angle_new = angle + rotate + addrotate;
				x_new = cos(angle_new)*d;
				y_new = sin(angle_new)*d;
				LINE(l,1) = x_new;
				LINE(l,2) = y_new;
			end
			M.S{i}.OUTLINE_C = LINE;
		end
	end
	
	for i = 1:M.N_FRAME
		if M.P{i}.BOUNDARY == 1
			display(i)
			display('saving file...')
			SAVE_LINE = fopen([handles.SAVE_STR num2str(i) '_LINE.txt'],'w');
			fprintf(SAVE_LINE,'%5s %19s %19s %19s %19s %19s %19s\r\n','i','Ax','Ay','Bx','By','Cx','Cy');
			for j = 1:length(M.S{i}.OUTLINE_A(:,1))
				fprintf(SAVE_LINE,'%6.0f',j);
				fprintf(SAVE_LINE,'%20.9f',M.S{i}.OUTLINE_A(j,1));
				fprintf(SAVE_LINE,'%20.9f',M.S{i}.OUTLINE_A(j,2));
				fprintf(SAVE_LINE,'%20.9f',M.S{i}.OUTLINE_B(j,1));
				fprintf(SAVE_LINE,'%20.9f',M.S{i}.OUTLINE_B(j,2));
				fprintf(SAVE_LINE,'%20.9f',M.S{i}.OUTLINE_C(j,1));
				fprintf(SAVE_LINE,'%20.9f\r\n',M.S{i}.OUTLINE_C(j,2));
			end	
			fclose(SAVE_LINE)
			display('saving par...')
			SAVE_PAR = fopen([handles.SAVE_STR num2str(i) '_PAR.txt'],'w');
			fprintf(SAVE_PAR,'%19s %19s %19s %19s %19s %19s %19s\r\n','FILE','A','B','C','D','E','F');
			fprintf(SAVE_PAR,'%19s',M.NA{i});
			fprintf(SAVE_PAR,'%20.0f',M.P{i}.A);
			fprintf(SAVE_PAR,'%20.0f',M.P{i}.B);
			fprintf(SAVE_PAR,'%20.0f',M.P{i}.C);
			fprintf(SAVE_PAR,'%20.0f',M.P{i}.D);
			fprintf(SAVE_PAR,'%20.0f',M.P{i}.E);
			fprintf(SAVE_PAR,'%20.0f\r\n',M.P{i}.F);
			fclose(SAVE_PAR)
		end
	end
end