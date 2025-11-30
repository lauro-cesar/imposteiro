# Makefile for exporting Godot 4.x projects

# Path to the Godot executable (adjust to your version or installation)
GODOT_BIN ?= godot4
# Path to the project (defaults to current directory)
PROJECT_PATH ?= $(CURDIR)
# Directory where exports will be placed
EXPORT_DIR ?= builds

# Export preset names as defined in Project → Export
PRESET_LINUX    := "Linux/X11"
PRESET_WINDOWS  := "Windows Desktop"
PRESET_MAC      := "macOS"
PRESET_HTML5    := "HTML5"

.PHONY: all linux windows mac html5 clean

all: linux windows mac html5

linux:
	@mkdir -p $(EXPORT_DIR)/linux/
	$(GODOT_BIN) --path $(PROJECT_PATH) --export-release $(PRESET_LINUX) $(EXPORT_DIR)/linux/game.x86_64

windows:
	@mkdir -p $(EXPORT_DIR)/window/
	$(GODOT_BIN) --path $(PROJECT_PATH) --export-release $(PRESET_WINDOWS) $(EXPORT_DIR)/window/game.exe

mac:
	@mkdir -p $(EXPORT_DIR)/mac/
	$(GODOT_BIN) --path $(PROJECT_PATH) --export-release $(PRESET_MAC) $(EXPORT_DIR)/mac/game.dmg

html5:
	@mkdir -p $(EXPORT_DIR)/web/
	$(GODOT_BIN) --headless --export-release $(PRESET_HTML5) $(EXPORT_DIR)/web/index3.html

clean:
	@rm -rf $(EXPORT_DIR)/*
