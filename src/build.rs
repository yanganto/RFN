fn main() {
    let lib_path = std::env::var("LIB").expect("Please use nix shell to develop project");

    println!("DEBUG....");
    println!("cargo:rustc-link-search={:}", lib_path);
    println!("cargo:rustc-link-lib=static=arradd");
}
