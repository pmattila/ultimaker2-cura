##
## Makefile for CURA configuration
##

# Full version
VERSION ?= 3.6.0

# Major version
MAJOR ?= 3.6

# Application location
APPPATH ?= /Applications/Ultimaker Cura.app/Contents/Resources/resources

# Config files
CFGPATH ?= $(HOME)/Library/Application Support/cura/$(MAJOR)


## Files

APP_DIRS := #

CFG_DIRS := \
	materials		\
	quality			\
	quality_changes		\
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
	material_install	\
	quality_install		\
	profile_install		\
	setting_install		\

.PHONY: $(INSTALLS)

install: $(INSTALLS)

material_install:
	@shopt -s nullglob; cd materials && \
	for FILE in * ; do \
	  cp -fv "$${FILE}" "$(CFGPATH)/materials/$${FILE}" ; \
	done

quality_install:
	@shopt -s nullglob; cd quality && \
	for FILE in * ; do \
	  cp -fv "$${FILE}" "$(CFGPATH)/quality/$${FILE}" ; \
	done

profile_install:
	@shopt -s nullglob; cd quality_changes && \
	for FILE in * ; do \
	  cp -fv "$${FILE}" "$(CFGPATH)/quality_changes/$${FILE}" ; \
	done

setting_install:
	@shopt -s nullglob; cd settings && \
	for FILE in * ; do \
	  cp -fv "$${FILE}" "$(CFGPATH)/setting_visibility/$${FILE}" ; \
	done

