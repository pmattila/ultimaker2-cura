##
## Makefile for CURA configuration
##

# Full version
VERSION := 5.2.1

# Major version
MAJOR := 5.2

# Setting version
SETTING_VERSION := 20

# Application location
APPPATH ?= /Applications/Ultimaker Cura $(VERSION).app

# Resource location
RESPATH ?= $(APPPATH)/Contents/Resources/share/cura/resources

# Config files
CFGPATH ?= $(HOME)/Library/Application Support/cura/$(MAJOR)


## Rules

.PHONY: all

all: # or nothing
	@echo "Nothing to do."


## Install rules

INSTALLS := \
	ultimaker_install		\
	definition_install		\
	variant_install			\
	extruder_install		\
	setting_install			\
#	material_install		\
#	material_quality_install	\


.PHONY: $(INSTALLS)

install: $(INSTALLS)

ultimaker_install:
	@cp -fv definitions/ultimaker2.def.json "$(RESPATH)/definitions/"

definition_install:
	@shopt -s nullglob; cd definitions && \
	for FILE in *.json ; do \
	  cp -fv "$${FILE}" "$(CFGPATH)/definitions/$${FILE}" ; \
	done

variant_install:
	@shopt -s nullglob; cd variants && \
	for FILE in *.cfg ; do \
	  echo "variants/$${FILE} -> $(CFGPATH)/variants/$${FILE}" ; \
	  cat "$${FILE}" | sed 's|%{SETTING_VERSION}|$(SETTING_VERSION)|g' > "$(CFGPATH)/variants/$${FILE}" ; \
	done

extruder_install:
	@shopt -s nullglob; cd extruders && \
	for FILE in *.json ; do \
	  cp -fv "$${FILE}" "$(CFGPATH)/extruders/$${FILE}" ; \
	done

setting_install:
	@shopt -s nullglob; cd settings && \
	for FILE in *.cfg ; do \
	  cp -fv "$${FILE}" "$(CFGPATH)/setting_visibility/$${FILE}" ; \
	done

material_install:
	@shopt -s nullglob; cd materials && \
	for FILE in *.fdm_material ; do \
	  cp -fv "$${FILE}" "$(CFGPATH)/materials/$${FILE}" ; \
	done

material_quality_install:
	@shopt -s nullglob; cd quality && \
	for FILE in *.cfg ; do \
	  cat "$${FILE}" | sed 's|%{SETTING_VERSION}|$(SETTING_VERSION)|g' > "$(CFGPATH)/quality/$${FILE}" ; \
	done

