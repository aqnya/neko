extern fn neko_printk(msg: [*:0]const u8) void;

pub inline fn init() void {
    neko_printk("neko: Hello from logic\n");
}

pub inline fn exit() void {
    neko_printk("neko: exit\n");
}
