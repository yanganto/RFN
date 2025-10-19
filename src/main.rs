#[repr(C)]
pub struct DataContainer {
    id: i32,
    value: f32,
    neighbors: *mut i32,
}

unsafe extern "C" {
    fn addx(arr: *mut f32, arr_length: i32, value: f32);
    fn get_value(dataContainer: *const DataContainer) -> f32;
}

fn main() {
    let mut arr: [f32; 2] = [1.0, 2.0];
    let mut vec = vec![10.0, 11.0];
    println!("Before: {:?}", arr);
    unsafe {
        addx(arr.as_mut_ptr(), 2, 1.0);
    }
    println!("After: {:?}", arr);

    println!("Before: {:?}", vec);
    unsafe {
        addx(vec.as_mut_ptr(), 2, 5.0);
    }
    println!("After: {:?}", vec);

    let container = DataContainer {
        id: 1,
        value: -2.0,
        neighbors: std::ptr::null_mut(),
    };

    unsafe {
        println!("Value from C: {}", get_value(&container));
    }

    println!("Hello, world!");
}
