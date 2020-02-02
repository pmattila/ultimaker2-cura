##
## Makefile for CURA configuration
##

# Full version
VERSION ?= 4.3.0

# Major version
MAJOR ?= 4.3

# Application location
APPPATH ?= /Applications/Ultimaker Cura 4.3.app/Contents/Resources/resources

# Config files
CFGPATH ?= $(HOME)/Library/Application Support/cura/$(MAJOR)


## Files

APP_DIRS := #

CFG_DIRS := \
	definitions		\
	extruders		\
	variants		\
	materials		\
	quality			\
	settings		\


## Rules

.PHONY: all diff cfgdiff appdiff

all: # or nothing
	@echo "Nothing to do."


diff: appdiff cfgdiff

appdiff:
	@shopt -s nullglob; \
	for DIR in $(APP_DIRS) ; do \
	  for FILE in $${DIR}/* ; do \
	    diff -u "$${FILE}" "$(APPPATH)/$${FILE}" ; \
	  done ; \
	done

cfgdiff:
	@shopt -s nullglob; \
	for DIR in $(CFG_DIRS) ; do \
	  for FILE in $${DIR}/* ; do \
	    diff -u "$${FILE}" "$(CFGPATH)/$${FILE}" ; \
	  done ; \
	done


## Install rules

INSTALLS := \
	fix_install			\
	definition_install		\
	variant_install			\
	extruder_install		\
	setting_install			\
	machine_quality_install		\
#	material_quality_install	\
#	material_install		\


.PHONY: $(INSTALLS)

install: $(INSTALLS)

fix_install:
	@cp -fv definitions/ultimaker2.def.json "$(APPPATH)/definitions/"


definition_install:
	@shopt -s nullglob; cd definitions && \
	for FILE in *.json ; do \
	  cp -fv "$${FILE}" "$(CFGPATH)/definitions/$${FILE}" ; \
	done

variant_install:
	@shopt -s nullglob; cd variants && \
	for FILE in *.cfg ; do \
	  cp -fv "$${FILE}" "$(CFGPATH)/variants/$${FILE}" ; \
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
	  cp -fv "$${FILE}" "$(CFGPATH)/quality/$${FILE}" ; \
	done

machine_quality_install:
	@shopt -s nullglob; cd quality/ultimaker2_dual_left && \
	for FILE in *.cfg ; do \
	  cp -fv "$${FILE}" "$(CFGPATH)/quality/$${FILE}" ; \
	done
	@shopt -s nullglob; cd quality/ultimaker2_dual_right && \
	for FILE in *.cfg ; do \
	  cp -fv "$${FILE}" "$(CFGPATH)/quality/$${FILE}" ; \
	done

