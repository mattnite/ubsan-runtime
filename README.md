# ubsan-runtime

This is a simple UBSAN runtime written in Zig. At the moment it dumps a stack
trace and prints which handler was invoked. In the future I'd like to learn how
to provide more useful information as to what's going wrong, then upstream this
project to the Zig compiler.

This project is intended for use with Zig 0.11.0.

## Incorporation into Your Project

Zig will turn on the UB sanitizer with traps for Debug and ReleaseSafe builds.
To use this runtime you need to disable traps and link this library:

```zig
pub fn build(b: *Build) void {
    // ...
    const ubsan_runtime = b.dependency("ubsan-runtime", .{
        .target = target,
        .optimize = optimize,
    });

    exe.linkLibrary(ubsan_runtime.artifact("ubsan"));
    exe.addCSourceFiles(c_source_files, &.{
      // This flag disables UB sanitizer traps, but keeps UB sanitization
      // enabled.
      "-fno-sanitize-trap=undefined",
    });
}
