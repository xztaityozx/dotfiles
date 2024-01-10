ZDOTDIR := $(shell echo ${ZDOTDIR})
ZSHRC := $(ZDOTDIR)/.zshrc
ENABLE_ZPROF := $(shell echo ${ENABLE_ZPROF})
OS := $(shell uname -s)
SHELL = zsh

.PHONY: all
all: build

.PHONY: build
build: $(ZSHRC)
	zsh -c "zcompile $(ZSHRC)"

zinit.generated.zsh:
	[[ -e $@ ]] && rm $@ || echo ok
	cat ./zinit.main.zsh >> $@
	cat ./zinit.runtime.zsh >> $@
	cat ./zinit.atload.zsh >> $@
	cat ./zinit.common.zsh >> $@

$(ZSHRC): clean zinit.generated.zsh
	touch $(ZSHRC)
	[[ "$(ENABLE_ZPROF)" == "1" ]] && echo 'zmodload zsh/zprof && zprof' >> $(ZSHRC) || echo "zprof disable"
	cat ./main.zsh >> $(ZSHRC)
	cat ./zinit.generated.zsh >> $(ZSHRC)
	echo {alias,bind,function,iab}.zsh | xargs cat >> $(ZSHRC)
	echo true >> $(ZSHRC)
	[[ "$(ENABLE_ZPROF)" == "1" ]] && echo 'type zprof &>/dev/null && zprof | less' >> $(ZSHRC) || echo "zprof disable"

.PHONY: clean
clean:
	[[ -e "$(ZSHRC)" ]] && rm $(ZSHRC) || echo "ok"
	[[ -e "$(ZSHRC).zwc" ]] && rm -f $(ZSHRC).zwc || echo "ok"
	[[ -e "zinit.generated.zsh" ]] && rm zinit.generated.zsh || echo "ok"

