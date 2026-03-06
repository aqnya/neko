extern fn printk(fmt: [*:0]const u8, ...) c_int;

pub inline fn init() c_int {
    _ = printk("neko: Hello from logic\n");
    return 0;
}

pub inline fn exit() void {
    _ = printk("neko: exit\n");
}
