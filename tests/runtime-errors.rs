use proc_macro_error3::*;

#[test]
#[should_panic = "proc-macro-error3 API cannot be used outside of"]
fn missing_attr_emit() {
    emit_call_site_error!("You won't see me");
}

#[test]
#[should_panic = "proc-macro-error3 API cannot be used outside of"]
fn missing_attr_abort() {
    abort_call_site!("You won't see me");
}
