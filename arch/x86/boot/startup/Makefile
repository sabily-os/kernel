# SPDX-License-Identifier: GPL-2.0

KBUILD_AFLAGS		+= -D__DISABLE_EXPORTS
KBUILD_CFLAGS		+= -D__DISABLE_EXPORTS -mcmodel=small -fPIC \
			   -Os -DDISABLE_BRANCH_PROFILING \
			   $(DISABLE_STACKLEAK_PLUGIN) \
			   -fno-stack-protector -D__NO_FORTIFY \
			   -fno-jump-tables \
			   -include $(srctree)/include/linux/hidden.h

# disable ftrace hooks and LTO
KBUILD_CFLAGS	:= $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS))
KBUILD_CFLAGS	:= $(filter-out $(CC_FLAGS_LTO),$(KBUILD_CFLAGS))
KASAN_SANITIZE	:= n
KCSAN_SANITIZE	:= n
KMSAN_SANITIZE	:= n
UBSAN_SANITIZE	:= n
KCOV_INSTRUMENT	:= n

obj-$(CONFIG_X86_64)		+= gdt_idt.o map_kernel.o
obj-$(CONFIG_AMD_MEM_ENCRYPT)	+= sme.o sev-startup.o

lib-$(CONFIG_X86_64)		+= la57toggle.o
lib-$(CONFIG_EFI_MIXED)		+= efi-mixed.o

#
# Disable objtool validation for all library code, which is intended
# to be linked into the decompressor or the EFI stub but not vmlinux
#
$(patsubst %.o,$(obj)/%.o,$(lib-y)): OBJECT_FILES_NON_STANDARD := y
