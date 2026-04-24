const std = @import("std");

pub fn main(init: std.process.Init) !void {
    const buffer = "const std = @import({1c}std{1c});{0c}{0c}pub fn main(init: std.process.Init) !void {{{0c}    const buffer = {1c}{2s}{1c};{0c}    const allocator = std.heap.page_allocator;{0c}{0c}    const dir = std.Io.Dir.cwd();{0c}    const file = try dir.createFile(init.io, {1c}./Grace_kid.zig{1c}, .{{ .read = true, .truncate = true }});{0c}    defer file.close(init.io);{0c}{0c}    const buffFormatted = try std.fmt.allocPrint(allocator, buffer, .{{ 10, 34, buffer }});{0c}    defer allocator.free(buffFormatted);{0c}{0c}    try file.writeStreamingAll(init.io, buffFormatted);{0c}}}{0c}";
    const allocator = std.heap.page_allocator;

    const dir = std.Io.Dir.cwd();
    const file = try dir.createFile(init.io, "./Grace_kid.zig", .{ .read = true, .truncate = true });
    defer file.close(init.io);

    const buffFormatted = try std.fmt.allocPrint(allocator, buffer, .{ 10, 34, buffer });
    defer allocator.free(buffFormatted);

    try file.writeStreamingAll(init.io, buffFormatted);
}
