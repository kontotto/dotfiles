CANDIDATES := $(wildcard .??*)
EXCLUSIONS := .git
DOTFILES   := $(filter-out $(EXCLUSIONS), $(CANDIDATES))

all:

deploy:
	@$(foreach val, ln -sfnv $(abspath $(val)) $(HOME)/$(val))
