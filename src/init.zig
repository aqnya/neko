extern fn neko_printk(msg: [*:0]const u8) void;

pub inline fn init() c_int {
    neko_printk("neko: Hello from logic\n");
    return 0;
}

pub inline fn exit() void {
    neko_printk("neko: exit\n");
}
