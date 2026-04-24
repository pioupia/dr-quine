const std = @import("std");

pub fn main(init: std.process.Init) !void {
    var number: i32 = 5;
    if (number <= 0)
        return;
    number -= 1;
    const buffer = "const std = @import({1c}std{1c});{0c}{0c}pub fn main(init: std.process.Init) !void {{{0c}    var number: i32 = {2d};{0c}    if (number <= 0){0c}        return;{0c}    number -= 1;{0c}    const buffer = {1c}{3s}{1c};{0c}    const allocator = std.heap.page_allocator;{0c}    const fileName = try std.fmt.allocPrint(allocator, {1c}./Sully_{{0d}}.zig{1c}, .{{number}});{0c}    defer allocator.free(fileName);{0c}{0c}    const dir = std.Io.Dir.cwd();{0c}    const file = try dir.createFile(init.io, fileName, .{{ .read = true, .truncate = true }});{0c}    defer file.close(init.io);{0c}{0c}    const buffFormatted = try std.fmt.allocPrint(allocator, buffer, .{{ 10, 34, number, buffer }});{0c}    defer allocator.free(buffFormatted);{0c}{0c}    try file.writeStreamingAll(init.io, buffFormatted);{0c}{0c}    const command = try std.fmt.allocPrint(allocator, {1c}/tmp/zig_install/zig-x86_64-linux-0.16.0/zig build-exe -femit-bin=./Sully_{{0d}} ./Sully_{{0d}}.zig && ./Sully_{{0d}}{1c}, .{{number}});{0c}    defer allocator.free(command);{0c}{0c}    const result = try std.process.run(allocator, init.io, .{{{0c}        .argv = &[_][]const u8{{ {1c}/bin/sh{1c}, {1c}-c{1c}, command }},{0c}    }});{0c}    defer allocator.free(result.stdout);{0c}    defer allocator.free(result.stderr);{0c}}}{0c}";
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
