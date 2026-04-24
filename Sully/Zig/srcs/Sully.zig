const std = @import("std");

pub fn verify_file_name(input_value: i32) i32 {
    const filename = @src().file;
    var i: usize = 0;
    var result: u32 = 0;

    while (filename[i] != 0 and filename[i] != '_')
        i += 1;

    if (filename[i] == 0)
        return (input_value);

    i += 1;

    while (filename[i] >= '0' and filename[i] <= '9' and result < std.math.maxInt(i32)) {
        result = (result * 10) + (filename[i] - '0');
        i += 1;
    }

    if (result >= std.math.maxInt(i32))
        return (input_value);

    if (@as(u32, @intCast(result)) != input_value)
        return (input_value);

    return (input_value - 1);
}

pub fn main(init: std.process.Init) !void {
    var number: i32 = 5;

    if (number <= 0)
        return;

    number = verify_file_name(number);

    const buffer = "const std = @import({1c}std{1c});{0c}{0c}pub fn verify_file_name(input_value: i32) i32 {{{0c}    const filename = @src().file;{0c}    var i: usize = 0;{0c}    var result: u32 = 0;{0c}{0c}    while (filename[i] != 0 and filename[i] != '_'){0c}        i += 1;{0c}{0c}    if (filename[i] == 0){0c}        return (input_value);{0c}{0c}    i += 1;{0c}{0c}    while (filename[i] >= '0' and filename[i] <= '9' and result < std.math.maxInt(i32)) {{{0c}        result = (result * 10) + (filename[i] - '0');{0c}        i += 1;{0c}    }}{0c}{0c}    if (result >= std.math.maxInt(i32)){0c}        return (input_value);{0c}{0c}    if (@as(u32, @intCast(result)) != input_value){0c}        return (input_value);{0c}{0c}    return (input_value - 1);{0c}}}{0c}{0c}pub fn main(init: std.process.Init) !void {{{0c}    var number: i32 = {2d};{0c}{0c}    if (number <= 0){0c}        return;{0c}{0c}    number = verify_file_name(number);{0c}{0c}    const buffer = {1c}{3s}{1c};{0c}    const allocator = std.heap.page_allocator;{0c}    const fileName = try std.fmt.allocPrint(allocator, {1c}./Sully_{{0d}}.zig{1c}, .{{number}});{0c}    defer allocator.free(fileName);{0c}{0c}    const dir = std.Io.Dir.cwd();{0c}    const file = try dir.createFile(init.io, fileName, .{{ .read = true, .truncate = true }});{0c}    defer file.close(init.io);{0c}{0c}    const buffFormatted = try std.fmt.allocPrint(allocator, buffer, .{{ 10, 34, number, buffer }});{0c}    defer allocator.free(buffFormatted);{0c}{0c}    try file.writeStreamingAll(init.io, buffFormatted);{0c}{0c}    const command = try std.fmt.allocPrint(allocator, {1c}/tmp/zig_install/zig-x86_64-linux-0.16.0/zig build-exe -femit-bin=./Sully_{{0d}} ./Sully_{{0d}}.zig && ./Sully_{{0d}}{1c}, .{{number}});{0c}    defer allocator.free(command);{0c}{0c}    const result = try std.process.run(allocator, init.io, .{{{0c}        .argv = &[_][]const u8{{ {1c}/bin/sh{1c}, {1c}-c{1c}, command }},{0c}    }});{0c}    defer allocator.free(result.stdout);{0c}    defer allocator.free(result.stderr);{0c}}}{0c}";
    const allocator = std.heap.page_allocator;
    const fileName = try std.fmt.allocPrint(allocator, "./Sully_{0d}.zig", .{number});
    defer allocator.free(fileName);

    const dir = std.Io.Dir.cwd();
    const file = try dir.createFile(init.io, fileName, .{ .read = true, .truncate = true });
    defer file.close(init.io);

    const buffFormatted = try std.fmt.allocPrint(allocator, buffer, .{ 10, 34, number, buffer });
    defer allocator.free(buffFormatted);

    try file.writeStreamingAll(init.io, buffFormatted);

    const command = try std.fmt.allocPrint(allocator, "/tmp/zig_install/zig-x86_64-linux-0.16.0/zig build-exe -femit-bin=./Sully_{0d} ./Sully_{0d}.zig && ./Sully_{0d}", .{number});
    defer allocator.free(command);

    const result = try std.process.run(allocator, init.io, .{
        .argv = &[_][]const u8{ "/bin/sh", "-c", command },
    });
    defer allocator.free(result.stdout);
    defer allocator.free(result.stderr);
}
