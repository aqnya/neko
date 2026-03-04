const std = @import("std");
const builtin = @import("builtin");

const init = @import("init.zig");

export fn load() c_int {
   return  init.init();
}

export fn exit() void {
    init.exit();
}

comptime {
    if (builtin.cpu.arch == .x86_64) {
        asm (
            \\.global zig_init
            \\.type zig_init, @function
            \\zig_init:
            \\    endbr64
            \\    push %rbp
            \\    mov %rsp, %rbp
            \\    call load
      //      \\    xor %eax, %eax
            \\    pop %rbp
            \\    jmp __x86_return_thunk
            \\.size zig_init, .-zig_init
            \\.global zig_cleanup
            \\.type zig_cleanup, @function
            \\zig_cleanup:
            \\    endbr64
            \\    push %rbp
            \\    mov %rsp, %rbp
            \\    call exit
            \\    pop %rbp
            \\    jmp __x86_return_thunk
            \\.size zig_cleanup, .-zig_cleanup
        );
    } else if (builtin.cpu.arch == .aarch64) {
        asm (
            \\.global zig_init
            \\.type zig_init, @function
            \\zig_init:
            \\    bti c
            \\    paciasp
            \\    stp x29, x30, [sp, #-16]!  
            \\    mov x29, sp
            \\    bl load
      //      \\    mov w0, #0
            \\    ldp x29, x30, [sp], #16   
            \\    autiasp                   
            \\    ret
            \\.size zig_init, .-zig_init
            \\.global zig_cleanup
            \\.type zig_cleanup, @function
            \\zig_cleanup:
            \\    bti c
            \\    paciasp
            \\    stp x29, x30, [sp, #-16]!
            \\    mov x29, sp
            \\    bl exit
            \\    ldp x29, x30, [sp], #16
            \\    autiasp
            \\    ret
            \\.size zig_cleanup, .-zig_cleanup
        );
    }
}

pub fn panic(_: []const u8, _: ?*std.builtin.StackTrace, _: ?usize) noreturn {
    while (true) {}
}
