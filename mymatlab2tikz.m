xCode = {'\definecolor{redish}{rgb}{0.843137254901961,0.0980392156862745,0.109803921568627}';
		  '\definecolor{blueish}{rgb}{0.168627450980392,0.513725490196078,0.729411764705882}';
		  '\definecolor{orangish}{rgb}{0.988235294818878,0.552941203117371,0.34901961684227}';
		  '\newlength\figureheight';
		  '\newlength\figurewidth';
		  '\setlength\figureheight{0.33\textwidth}';
		  '\setlength\figurewidth{0.4\textwidth}'};

axisOpt = {'xlabel absolute, xlabel style={yshift=2mm}';
		   'ylabel absolute, ylabel style={yshift=-2mm}';
		   'legend style={font=\small, draw=black,fill=white,legend cell align=left}';
		   'font=\scriptsize'};

matlab2tikz('maxChunkLength', inf,...
			'standalone', true,...
			'extraCode', xCode,...
			'extraAxisOptions', axisOpt,...
			'width', '\figurewidth',...
			'height', '\figureheight');
