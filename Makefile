BUILD_DIR=build
TITLE=Ready to Go
DESTINATION=casa@sweetohm.net:/home/web/slides/go-retour-experience

YELLOW=\033[1m\033[93m
CYAN=\033[1m\033[96m
CLEAR=\033[0m

all: clean slides publish

clean:
	@echo "$(YELLOW)Cleaning generated files$(CLEAR)"
	rm -rf $(BUILD_DIR)

slides:
	@echo "$(YELLOW)Generating slides$(CLEAR)"
	mkdir -p $(BUILD_DIR)
	cp res/template.html $(BUILD_DIR)/index.html
	sed -i -e "s/<? TITLE ?>/$(TITLE)/g" $(BUILD_DIR)/index.html
	python res/build.py README.md $(BUILD_DIR)/index.html
	cp -r res/ img/ $(BUILD_DIR)/
	rm $(BUILD_DIR)/res/*.html $(BUILD_DIR)/res/*.py

publish:
	@echo "$(YELLOW)Publishing slides$(CLEAR)"
	rsync -av $(BUILD_DIR)/ $(DESTINATION)/

help:
	@echo "$(YELLOW)This makefile has following targets:$(CLEAR)"
	@echo "$(CYAN)help$(CLEAR)    To print this help page"
	@echo "$(CYAN)slides$(CLEAR)  To generate slides in $(BUILD_DIR) directory"
	@echo "$(CYAN)clean$(CLEAR)   To clean generated files in $(BUILD_DIR) directory"
	@echo "$(CYAN)publish$(CLEAR) To publish slides with rsync"

