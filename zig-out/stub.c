#include <linux/module.h>
#include <linux/kernel.h>

MODULE_LICENSE("GPL");

extern int zig_init(void);
extern void zig_cleanup(void);

void neko_printk(const char *msg) {
    printk(KERN_INFO "%s", msg);
}

static int __init bridge_init(void) { return zig_init(); }
static void __exit bridge_exit(void) { zig_cleanup(); }

module_init(bridge_init);
module_exit(bridge_exit);
