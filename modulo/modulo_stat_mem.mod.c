#include <linux/module.h>
#include <linux/vermagic.h>
#include <linux/compiler.h>

MODULE_INFO(vermagic, VERMAGIC_STRING);

__visible struct module __this_module
__attribute__((section(".gnu.linkonce.this_module"))) = {
	.name = KBUILD_MODNAME,
	.init = init_module,
#ifdef CONFIG_MODULE_UNLOAD
	.exit = cleanup_module,
#endif
	.arch = MODULE_ARCH_INIT,
};

static const struct modversion_info ____versions[]
__used
__attribute__((section("__versions"))) = {
	{ 0x1e94b2a0, __VMLINUX_SYMBOL_STR(module_layout) },
	{ 0x30098610, __VMLINUX_SYMBOL_STR(single_release) },
	{ 0x69e971ab, __VMLINUX_SYMBOL_STR(seq_read) },
	{ 0x3e9958da, __VMLINUX_SYMBOL_STR(seq_lseek) },
	{ 0x27e1a049, __VMLINUX_SYMBOL_STR(printk) },
	{ 0x70cb5d65, __VMLINUX_SYMBOL_STR(proc_create_data) },
	{ 0x91831d70, __VMLINUX_SYMBOL_STR(seq_printf) },
	{ 0x891bef26, __VMLINUX_SYMBOL_STR(vm_stat) },
	{ 0x40c7247c, __VMLINUX_SYMBOL_STR(si_meminfo) },
	{ 0x14b58138, __VMLINUX_SYMBOL_STR(single_open) },
	{ 0xbdfb6dbb, __VMLINUX_SYMBOL_STR(__fentry__) },
};

static const char __module_depends[]
__used
__attribute__((section(".modinfo"))) =
"depends=";


MODULE_INFO(srcversion, "2CC78F1E9CC6EBB8BF215CC");
