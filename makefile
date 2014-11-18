SWEETHOME='/home/web/public'

publish: html
	@echo "Publishing on sweetohm..."
	cp -r index.html img/ js/ ${SWEETHOME}

html:
	@echo "Building HTML file..."
	python build.py

clean:
	@echo "Cleaning generated files..."
	rm index.html
