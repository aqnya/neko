const std = @import("std");

pub fn build(b: *std.Build) void {
    const optimize = b.standardOptimizeOption(.{});

    const target = b.resolveTargetQuery(.{
        .cpu_arch = .x86_64,
        .os_tag = .freestanding,
        .abi = .none,
    });

    const module = b.createModule(.{
        .root_source_file = b.path("src/root.zig"),
        .target = target,
        .optimize = optimize,
    });

    module.red_zone = false;
    module.stack_protector = false;
    module.code_model = .kernel;
    module.omit_frame_pointer = false;
    module.unwind_tables = .none;
    module.strip = true;
    const obj = b.addObject(.{
        .name = "neko",
        .root_module = module,
    });

    const install = b.addInstallFile(
        obj.getEmittedBin(),
        "neko.o",
    );

    const step = b.step("obj", "Build kernel object");
    step.dependOn(&install.step);
}
