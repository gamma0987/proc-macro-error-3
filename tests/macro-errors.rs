#[test]
#[cfg(feature = "__ui_tests")]
fn ui() {
    let t = trybuild::TestCases::new();
    t.compile_fail("tests/ui/*.rs");
    t.pass("tests/ui-pass/*.rs");
}
