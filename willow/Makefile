.PHONY: clean build/willow/docker

CHDIR_SHELL := $(SHELL)
define chdir
   $(eval _D=$(firstword $(1) $(@D)))
   $(info $(MAKE): cd $(_D)) $(eval SHELL = cd $(_D); $(CHDIR_SHELL))
endef

help:
	@echo "building willow for my own pleasure :)"

clean:
	rm -rf build

build:
	mkdir -p build

build/willow: build
	$(call chdir)
	@git clone https://github.com/toverainc/willow.git

build/willow/docker: build/willow
	$(call chdir)
	./utils.sh build-docker
	./utils.sh docker