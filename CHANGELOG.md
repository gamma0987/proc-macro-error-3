# Changelog

All notable changes to this project will be documented in this file.

This is the combined CHANGELOG for all packages: `proc-macro-error3` and
`proc-macro-error-attr3`. They both use the same version which is the version
used in this file.

The original project
[proc-macro-error](https://github.com/CrrepySkeleton/proc-macro-error) was
created and maintained up to version 1.0.4 by @CreepySkeleton. Due to the old
maintainer's inactivity, the project was renamed to
[proc-macro-error2](https://github.com/GnomedDev/proc-macro-error-2) and
maintained by @GnomedDev from version 2.0.0 up to version 2.0.1.
proc-macro-error2 was archived by the owner on 2026-06-07 and declared
unmaintained in RUSTSEC-2026-0173. From version 3.0.0 (2026-06-08) onwards the
project was renamed to
[proc-macro-error3](https://github.com/gamma0987/proc-macro-error3) and is
actively maintained by @gamma0987.

This project adheres to
[Semantic Versioning](http://semver.org/spec/v2.0.0.html).

# Unreleased

- Split `syn::Error` conversion support into explicit `syn2-error` (using `syn`
  v2) and `syn3-error` (using `syn` v3) Cargo features. `syn3-error` remains
  enabled by default, and the legacy `syn-error` feature remains available as a
  compatibility alias for `syn3-error`.

# v3.0.3 (2026-07-23)

- ([#10]): Add support for `syn` 3.x. The `syn::Error` output used by this crate
  remains compatible with 2.x, so no code changes within this crate were
  required.

[#10]: (https://github.com/gamma0987/proc-macro-error3/pull/10)

# v3.0.2 (2026-06-09)

- ([#3]): Fixed expansion of args without comma in trailing args branches and
  replaced macro arms differing only in trailing comma with `$(,)*`
- ([#4]): Fixed potential panic inside a proc macro if
  `syn::Error::to_compile_error()` ever changes its token layout. The
  `From<syn::Error>` implementation now gracefully falls back to a
  call-site-spanned error message instead of panicking via
  `expect()`/`unwrap()`/`unreachable!()`.

[#3]: (https://github.com/gamma0987/proc-macro-error3/pull/3)
[#4]: (https://github.com/gamma0987/proc-macro-error3/pull/4)

# v3.0.1 (2026-06-08)

- Fix broken links in cargo metadata and README
- Fix minimal version requirements of all dependencies

# v3.0.0 (2026-06-08)

- Crate renamed from `proc-macro-error2` to `proc-macro-error3`.
- Attribute crate renamed from `proc-macro-error-attr2` to
  `proc-macro-error-attr3`.
- Fixed `pub_use_of_private_extern_crate` future-incompatibility warning
  ([`rust-lang/rust#127909`]) by making the `proc_macro` extern crate public
- Fixed swapped rustdoc links for `emit_call_site_warning!` and
  `emit_call_site_error!` and fixed other broken links in the README.

[`rust-lang/rust#127909`]: https://github.com/rust-lang/rust/issues/127909

# v2.0.1 (2024-09-06)

- Fixed a span location issue due to mistake in refactoring (#2)

# v2.0.0 (2024-09-05)

No changes, simply releasing pre-release as full release.

# v2.0.0-pre.1 (2024-09-01)

- **Crate has been renamed to `proc-macro-error2`, due to the old maintainer's
  inactivity.**

- `syn` has been upgraded to `2`
- MSRV has been bumped to `1.61`
- Warnings have been fixed, including `clippy::pedantic` lints
- CI has been converted to GitHub actions, and testing infrastructure
  significantly simplified.
- Automatic nightly detection has been removed, use the `nightly` feature for
  improved diagnostics at the cost of stability.

# v1.0.4 (2020-7-31)

- `SpanRange` facility is now public.
- Docs have been improved.
- Introduced the `syn-error` feature so you can opt-out from the `syn`
  dependency.

# v1.0.3 (2020-6-26)

- Corrected a few typos.
- Fixed the `emit_call_site_warning` macro.

# v1.0.2 (2020-4-9)

- An obsolete note was removed from documentation.

# v1.0.1 (2020-4-9)

- `proc-macro-hack` is now well tested and supported. Not sure about
  `proc-macro-nested`, please fill a request if you need it.
- Fixed `emit_call_site_error`.
- Documentation improvements.

# v1.0.0 (2020-3-25)

I believe the API can be considered stable because it's been a few months
without breaking changes, and I also don't think this crate will receive much
further evolution. It's perfect, admit it.

Hence, meet the new, stable release!

### Improvements

- Supported nested `#[proc_macro_error]` attributes. Well, you aren't supposed
  to do that, but I caught myself doing it by accident on one occasion and the
  behavior was... surprising. Better to handle this smooth.

# v0.4.12 (2020-3-23)

- Error message on macros' misuse is now a bit more understandable.

# v0.4.11 (2020-3-02)

- `build.rs` no longer fails when `rustc` date could not be determined, (thanks
  to
  [`Fabian Möller`](https://gitlab.com/CreepySkeleton/proc-macro-error/issues/8)
  for noticing and to
  [`Igor Gnatenko`](https://gitlab.com/CreepySkeleton/proc-macro-error/-/merge_requests/25)
  for fixing).

# v0.4.10 (2020-2-29)

- `proc-macro-error` doesn't depend on syn\[full\] anymore, the compilation is
  \~30secs faster.

# v0.4.9 (2020-2-13)

- New function: `append_dummy`.

# v0.4.8 (2020-2-01)

- Support for children messages

# v0.4.7 (2020-1-31)

- Now any type that implements `quote::ToTokens` can be used instead of spans.
  This allows for high quality error messages.

# v0.4.6 (2020-1-31)

- `From<syn::Error>` implementation doesn't lose span info anymore, see
  [#6](https://gitlab.com/CreepySkeleton/proc-macro-error/issues/6).

# v0.4.5 (2020-1-20)

Just a small intermediate release.

- Fix some bugs.
- Populate license files into subfolders.

# v0.4.4 (2019-11-13)

- Fix `abort_if_dirty` + warnings bug
- Allow trailing commas in macros

# v0.4.2 (2019-11-7)

- FINALLY fixed `__pme__suggestions not found` bug

# v0.4.1 (2019-11-7) YANKED

- Fixed `__pme__suggestions not found` bug
- Documentation improvements, links checked

# v0.4.0 (2019-11-6) YANKED

## New features

- "help" messages that can have their own span on nightly, they inherit parent
  span on stable.
    ```rust
    let cond_help = if condition { Some("some help message") else { None } };
    abort!(
        span, // parent span
        "something's wrong, {} wrongs in total", 10; // main message
        help = "here's a help for you, {}", "take it"; // unconditional help message
        help =? cond_help; // conditional help message, must be Option
        note = note_span => "don't forget the note, {}", "would you?" // notes can have their own span but it's effective only on nightly
    )
    ```
- Warnings via `emit_warning` and `emit_warning_call_site`. Nightly only,
  they're ignored on stable.
- Now `proc-macro-error` delegates to `proc_macro::Diagnostic` on nightly.

## Breaking changes

- `MacroError` is now replaced by `Diagnostic`. Its API resembles
  `proc_macro::Diagnostic`.
- `Diagnostic` does not implement `From<&str/String>` so
  `Result<T, &str/String>::abort_or_exit()` won't work anymore (nobody used it
  anyway).
- `macro_error!` macro is replaced with `diagnostic!`.

## Improvements

- Now `proc-macro-error` renders notes exactly just like rustc does.
- We don't parse a body of a function annotated with `#[proc_macro_error]`
  anymore, only looking at the signature. This should somewhat decrease
  expansion time for large functions.

# v0.3.3 (2019-10-16)

- Now you can use any word instead of "help", undocumented.

# v0.3.2 (2019-10-16)

- Introduced support for "help" messages, undocumented.

# v0.3.0 (2019-10-8)

## The crate has been completely rewritten from scratch!

## Changes (most are breaking):

- Renamed macros:
    - `span_error` => `abort`
    - `call_site_error` => `abort_call_site`
- `filter_macro_errors` was replaced by `#[proc_macro_error]` attribute.
- `set_dummy` now takes `TokenStream` instead of `Option<TokenStream>`
- Support for multiple errors via `emit_error` and `emit_call_site_error`
- New `macro_error` macro for building errors in format=like style.
- `MacroError` API had been reconsidered. It also now implements
  `quote::ToTokens`.

# v0.2.6 (2019-09-02)

- Introduce support for dummy implementations via `dummy::set_dummy`
- `multi::*` is now deprecated, will be completely rewritten in v0.3

# v0.2.0 (2019-08-15)

## Breaking changes

- `trigger_error` replaced with `MacroError::trigger` and
  `filter_macro_error_panics` is hidden from docs. This is not quite a breaking
  change since users weren't supposed to use these functions directly anyway.
- All dependencies are updated to `v1.*`.

## New features

- Ability to stack multiple errors via `multi::MultiMacroErrors` and emit them
  at once.

## Improvements

- Now `MacroError` implements `std::fmt::Display` instead of
  `std::string::ToString`.
- `MacroError::span` inherent method.
- `From<MacroError> for proc_macro/proc_macro2::TokenStream` implementations.
- `AsRef/AsMut<String> for MacroError` implementations.

# v0.1.x (2019-07-XX)

## New features

- An easy way to report errors inside within a proc-macro via `span_error`,
  `call_site_error` and `filter_macro_errors`.
