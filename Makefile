SHELL = /bin/bash
KERNEL = $(shell uname -s)

SRC_ROOT = $(CURDIR)
DST_ROOT = $(HOME)

EXPORT_CONTENT = .ssh .vim
NO_EXPORT = .git* .dotfiles .mailmap *.pid .*swp $(EXPORT_CONTENT)

.DEFAULT_GOAL = init

# make print-(variablename)
print-%  : ; @echo $* = $($*)

# export everything start with dot
# recursively export the content in $(EXPORT_CONTENT)
EXPORT = $(shell find "$(SRC_ROOT)" -maxdepth 1 -name '.*' $(patsubst %,-not -name '%',$(NO_EXPORT))) \
		 $(shell find $(addprefix "$(SRC_ROOT)"/,$(EXPORT_CONTENT)) -mindepth 1 -type f 2>/dev/null) \
 		 $(shell find "$(SRC_ROOT)/OS/$(KERNEL)" -name '.*' -mindepth 1 -type f 2>/dev/null) \
		 $(wildcard $(addprefix $(SRC_ROOT)/,$(EXPORT_APPEND)))

# export files with suffix *.export to *
EXPLICIT_EXPORT = $(shell find "$(SRC_ROOT)" -name '*.export')

# build destination path
export_dst = \
	$(patsubst $(SRC_ROOT)/%,$(DST_ROOT)/%,$(filter $(SRC_ROOT)/%,$(filter-out $(SRC_ROOT)/$(KERNEL)/%,$(EXPORT)))) \
	$(patsubst $(SRC_ROOT)/OS/$(KERNEL)/%,$(DST_ROOT)/%,$(filter $(SRC_ROOT)/OS/$(KERNEL)/%,$(EXPORT))) \
	$(patsubst %,$(DST_ROOT)/%,$(filter-out $(SRC_ROOT)/%,$(EXPORT)))
explicit_export_dst = \
	$(patsubst $(SRC_ROOT)/%.export,$(DST_ROOT)/%,$(filter $(SRC_ROOT)/%,$(EXPLICIT_EXPORT))) \
	$(patsubst %.export,$(DST_ROOT)/%,$(filter-out $(SRC_ROOT)/%,$(EXPLICIT_EXPORT)))

define mkdir_and_export_target
  @mkdir -p "$$(dirname "$@")"
  $(export_target)
endef

define init_append
  @rm -rf $(DST_ROOT)/.vim/bundle/Vundle.vim
  @rm -rf $(DST_ROOT)/.git-aware-prompt
  @rm -rf $(DST_ROOT)/.z
  @mkdir -p $(DST_ROOT)/.vim/bundle
  @ln -s $(SRC_ROOT)/lib/Vundle.vim $(DST_ROOT)/.vim/bundle/Vundle.vim
  @ln -s $(SRC_ROOT)/lib/git-aware-prompt $(DST_ROOT)/.git-aware-prompt
  @ln -s $(SRC_ROOT)/lib/z $(DST_ROOT)/.z
endef

define post_uninstall
  @rm -rf $(DST_ROOT)/.vim/bundle/Vundle.vim
  @rm -rf $(DST_ROOT)/.git-aware-prompt
endef

ifeq ($(RSYNC),y)
export_target = @[[ -d "$<" ]] && sl='/' || sl=''; rsync -ai --del "$<$$sl" "$@"
else
ifeq ($(COPY),y)
export_target = @cp -rfv "$<" "$@"
else
export_target = @[[ -f "$@" ]] && ln --backup=t -sfv "$<" "$@" || ln -sfv "$<" "$@"
endif
endif

.PHONY : init
init :
	@git submodule update --init
	$(init_append)

.PHONY : install
install : $(export_dst) $(explicit_export_dst) 
	$(install_append)

$(DST_ROOT)/% : $(SRC_ROOT)/%
	$(mkdir_and_export_target)

$(DST_ROOT)/% : $(SRC_ROOT)/OS/$(KERNEL)/%
	$(mkdir_and_export_target)

$(explicit_export_dst) : $(DST_ROOT)/% : $(SRC_ROOT)/%.export
	$(mkdir_and_export_target)

.PHONY : uninstall
uninstall :
	@rm -f $(patsubst %,"%",$(explicit_export_dst))
	@rm -f $(patsubst %,"%",$(export_dst))
	$(post_uninstall)

.PHONY : update-submodules
update-submodules :
	@git submodule update --init
	@git submodule foreach git pull origin master
