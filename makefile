SWEETHOME='/home/web/public'

publish: html
	@echo "Publishing on sweetohm..."
	cp -r img/ js/ ${SWEETHOME}
	cp index.html ${SWEETHOME}/go-retour-experience.html
	cd ${SWEETHOME} && ln -sf go-retour-experience.html retour-experience-go.html

html:
	@echo "Building HTML file..."
	python build.py

clean:
	@echo "Cleaning generated files..."
	rm index.html
