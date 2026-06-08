use proc_macro_error3::abort;

struct Foo;

#[allow(unused)]
fn foo() {
    abort!(Foo, "BOOM");
}

fn main() {}
