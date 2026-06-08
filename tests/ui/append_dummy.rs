use proc_macro_error3_test_suite::*;

enum NeedDefault {
    A,
    B,
}

append_dummy!(need_default);

fn main() {
    let _ = NeedDefault::default();
}
