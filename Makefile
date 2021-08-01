# vim:ft=make:

# Defaults
MAKEFILE := $(lastword $(MAKEFILE_LIST))
DISTROS  := $(basename $(basename $(notdir $(sort $(wildcard ./distro/*.hcl)))))

# Help
.PHONY: help

help:
		@echo "Targets:"
		@echo "  validate"
		@echo "    $(addsuffix \n   , $(addprefix validate-, ${DISTROS}))"
		@echo "  build"
		@echo "    $(addsuffix \n   , $(addprefix build-, ${DISTROS}))"
		@echo "  clean"
		@echo ""

# Packer targets
.PHONY: validate* build* publish*

validate:
	@echo "=> Validating: all distros"
	@for distro in $(DISTROS) ; do \
		$(MAKE) -f $(MAKEFILE) validate-$$distro ;   \
	done

validate-%: 
	@echo "=> Validating: $(patsubst validate-%,%, $@)"
	packer validate -var-file=distro/$(patsubst validate-%,%, $@).pkrvars.hcl .

build:
	@echo "=> Building: all distros"
	@for distro in $(DISTROS) ; do \
		$(MAKE) -f $(MAKEFILE) build-$$distro ;   \
	done

build-%: validate-%
	@echo "=> Building: $(patsubst build-%,%, $@)"
	packer build -var-file=distro/$(patsubst build-%,%, $@).pkrvars.hcl .

.PHONY: clean
clean:
	@rm -vrf output *.log
