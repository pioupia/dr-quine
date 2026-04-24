const std = @import("std");

// another comment outside of the "program"

pub fn another_function() void {
    return;
}

pub fn main(init: std.process.Init) !void {
    const allocator = std.heap.page_allocator;
    const buffer = "const std = @import({1c}std{1c});{0c}{0c}// another comment outside of the {1c}program{1c}{0c}{0c}pub fn another_function() void {{{0c}    return;{0c}}}{0c}{0c}pub fn main(init: std.process.Init) !void {{{0c}    const allocator = std.heap.page_allocator;{0c}    const buffer = {1c}{2s}{1c};{0c}    // debug print{0c}    another_function();{0c}    const buffFormatted = try std.fmt.allocPrint(allocator, buffer, .{{ 10, 34, buffer }});{0c}    try std.Io.File.stdout().writeStreamingAll(init.io, buffFormatted);{0c}    defer allocator.free(buffFormatted);{0c}}}{0c}";
    // debug print
    another_function();
    const buffFormatted = try std.fmt.allocPrint(allocator, buffer, .{ 10, 34, buffer });
    try std.Io.File.stdout().writeStreamingAll(init.io, buffFormatted);
    defer allocator.free(buffFormatted);
}
