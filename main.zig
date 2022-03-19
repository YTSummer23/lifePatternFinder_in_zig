const std = @import("std");
const print = std.debug.print;

const Game = struct {

    //[6][7]u8
    board: [6][7]u8,
    nextBoard: [6][7]u8,

    var variant: u64 = 0;

    fn trB(self: *Game) void {
        for (self.nextBoard) |i, index_i| {
            for (i) |j, index_j| {
                self.board[index_i][index_j] = j;
            }
        }
    }

    fn step (self: *Game) void {
        var cellsAlive: u8 = 0;
        for (self.board) |i, index_i| {
            for (i) |_, index_j| {
                cellsAlive = 0;
                if (index_i == 0) {
                    if (index_j == 0) {
                        cellsAlive += self.board[index_i + 1][index_j];
                        cellsAlive += self.board[index_i][index_j + 1];
                        cellsAlive += self.board[index_i + 1][index_j + 1];
                    }
                    else if (index_j < i.len) {
                        cellsAlive += self.board[index_i][index_j - 1];
                        cellsAlive += self.board[index_i + 1][index_j];
                        cellsAlive += self.board[index_i + 1][index_j - 1];
                    }
                    else {
                        cellsAlive += self.board[index_i][index_j + 1];
                        cellsAlive += self.board[index_i][index_j - 1];
                        cellsAlive += self.board[index_i + 1][index_j];
                        cellsAlive += self.board[index_i + 1][index_j + 1];
                        cellsAlive += self.board[index_i + 1][index_j - 1];
                    }
                }
                else if (index_i < self.board.len) {
                    if (index_j == 0) {
                        cellsAlive += self.board[index_i - 1][index_j];
                        cellsAlive += self.board[index_i][index_j + 1];
                        cellsAlive += self.board[index_i - 1][index_j + 1];
                    }
                    else if (index_j < i.len) {
                        cellsAlive += self.board[index_i][index_j - 1];
                        cellsAlive += self.board[index_i - 1][index_j - 1];
                        cellsAlive += self.board[index_i - 1][index_j];
                    }
                    else {
                        cellsAlive += self.board[index_i][index_j + 1];
                        cellsAlive += self.board[index_i][index_j - 1];
                        cellsAlive += self.board[index_i - 1][index_j];
                        cellsAlive += self.board[index_i - 1][index_j + 1];
                        cellsAlive += self.board[index_i - 1][index_j - 1];
                    }
                }
                else {
                    if (index_j == 0) {
                        cellsAlive += self.board[index_i][index_j + 1];
                        cellsAlive += self.board[index_i + 1][index_j];
                        cellsAlive += self.board[index_i + 1][index_j + 1];
                        cellsAlive += self.board[index_i - 1][index_j];
                        cellsAlive += self.board[index_i - 1][index_j + 1];
                    }
                    else if (index_j < i.len) {
                        cellsAlive += self.board[index_i][index_j - 1];
                        cellsAlive += self.board[index_i + 1][index_j];
                        cellsAlive += self.board[index_i + 1][index_j - 1];
                        cellsAlive += self.board[index_i - 1][index_j];
                        cellsAlive += self.board[index_i - 1][index_j - 1];
                    }
                    else {
                        cellsAlive += self.board[index_i][index_j + 1];
                        cellsAlive += self.board[index_i][index_j - 1];
                        cellsAlive += self.board[index_i + 1][index_j];
                        cellsAlive += self.board[index_i + 1][index_j + 1];
                        cellsAlive += self.board[index_i + 1][index_j - 1];
                        cellsAlive += self.board[index_i - 1][index_j];
                        cellsAlive += self.board[index_i - 1][index_j + 1];
                        cellsAlive += self.board[index_i - 1][index_j - 1];
                    }
                    if (cellsAlive == 3) {
                        self.nextBoard[index_i][index_j] = 1;
                    }
                    else if (cellsAlive > 3 and cellsAlive < 2) {
                        self.nextBoard[index_i][index_j] = 0;
                    }
                }
            }
        }
        self.trB();
    }
};

pub fn main() !void {
    var game = Game {
        .board = [1][7]u8 { [1]u8 { 0 } ** 7} ** 6,
        .nextBoard = [1][7]u8 { [1]u8 { 0 } ** 7} ** 6
    };
    game.step();
}
