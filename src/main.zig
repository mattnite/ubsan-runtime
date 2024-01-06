const std = @import("std");

comptime {
    export_ubsan_handler("add_overflow");
    export_ubsan_handler("add_overflow_abort");
    export_ubsan_handler("alignment_assumption");
    export_ubsan_handler("alignment_assumption_abort");
    export_ubsan_handler("builtin_unreachable");
    export_ubsan_handler("cfi_bad_type");
    export_ubsan_handler("cfi_check_fail");
    export_ubsan_handler("cfi_check_fail_abort");
    export_ubsan_handler("divrem_overflow");
    export_ubsan_handler("divrem_overflow_abort");
    export_ubsan_handler("dynamic_type_cache_miss");
    export_ubsan_handler("dynamic_type_cache_miss_abort");
    export_ubsan_handler("float_cast_overflow");
    export_ubsan_handler("float_cast_overflow_abort");
    export_ubsan_handler("function_type_mismatch");
    export_ubsan_handler("function_type_mismatch_abort");
    export_ubsan_handler("implicit_conversion");
    export_ubsan_handler("implicit_conversion_abort");
    export_ubsan_handler("invalid_builtin");
    export_ubsan_handler("invalid_builtin_abort");
    export_ubsan_handler("invalid_objc_cast");
    export_ubsan_handler("invalid_objc_cast_abort");
    export_ubsan_handler("load_invalid_value");
    export_ubsan_handler("load_invalid_value_abort");
    export_ubsan_handler("missing_return");
    export_ubsan_handler("mul_overflow");
    export_ubsan_handler("mul_overflow_abort");
    export_ubsan_handler("negate_overflow");
    export_ubsan_handler("negate_overflow_abort");
    export_ubsan_handler("nonnull_arg");
    export_ubsan_handler("nonnull_arg_abort");
    export_ubsan_handler("nonnull_return_v1");
    export_ubsan_handler("nonnull_return_v1_abort");
    export_ubsan_handler("nullability_arg");
    export_ubsan_handler("nullability_arg_abort");
    export_ubsan_handler("nullability_return_v1");
    export_ubsan_handler("nullability_return_v1_abort");
    export_ubsan_handler("out_of_bounds");
    export_ubsan_handler("out_of_bounds_abort");
    export_ubsan_handler("pointer_overflow");
    export_ubsan_handler("pointer_overflow_abort");
    export_ubsan_handler("shift_out_of_bounds");
    export_ubsan_handler("shift_out_of_bounds_abort");
    export_ubsan_handler("sub_overflow");
    export_ubsan_handler("sub_overflow_abort");
    export_ubsan_handler("type_mismatch_v1");
    export_ubsan_handler("type_mismatch_v1_abort");
    export_ubsan_handler("vla_bound_not_positive");
    export_ubsan_handler("vla_bound_not_positive_abort");
}

export fn __ubsan_on_report() void {
    dump_stack_trace_and_print_reason("on_report");
}

export fn __ubsan_get_current_report_data() void {
    dump_stack_trace_and_print_reason("get_current_report_data");
}

fn export_ubsan_handler(comptime name: []const u8) void {
    @export(struct {
        pub fn tmp() callconv(.C) void {
            dump_stack_trace_and_print_reason(name);
        }
    }.tmp, .{ .name = "__ubsan_handle_" ++ name });
}

fn dump_stack_trace_and_print_reason(reason: []const u8) noreturn {
    std.debug.dumpCurrentStackTrace(@returnAddress());
    std.log.err("{s}", .{reason});
    @breakpoint();
    std.os.abort();
}
