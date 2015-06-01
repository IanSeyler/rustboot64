// Rust on bare metal - Tested with Rust 1.0.0
// Uses Pure64 to get into a 64-bit SMP state
// rustc -O --crate-type lib -o kernel64.o --emit obj kernel64.rs
// ld -T app.ld -o kernel64.sys kernel64.o

#[no_mangle]
pub fn main() {
    clear_screen(Color::LightBlue);
    loop {
		// Loop forever
    }
}

#[derive(Copy,Clone)]
enum Color {
    Black       = 0,
    Blue        = 1,
    Green       = 2,
    Cyan        = 3,
    Red         = 4,
    Pink        = 5,
    Brown       = 6,
    LightGray   = 7,
    DarkGray    = 8,
    LightBlue   = 9,
    LightGreen  = 10,
    LightCyan   = 11,
    LightRed    = 12,
    LightPink   = 13,
    Yello       = 14,
    White       = 15,
}

fn clear_screen(background: Color) {
    for x in 0 .. 80*25 {
        unsafe {
            *((0xb8000 + x * 2) as *mut u16) = (background as u16) << 12;
        }
    }
}
