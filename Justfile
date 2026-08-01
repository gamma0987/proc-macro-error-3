# spell-checker: ignore nofile nocapture

prettier_bin := ```
    if command -V prettier 2>&1 | grep -q 'not found'; then
        echo -n npx prettier
    else
        echo -n prettier
    fi
    ```
cspell_bin := ```
    if command -V cspell 2>&1 | grep -q 'not found'; then
        echo -n npx cspell
    else
        echo -n cspell
    fi
    ```
msrv := '1.61.0'

# Check and fix format of rust files (Uses: 'cargo +nightly')
[group('formatting')]
fmt:
    cargo +nightly fmt --all

# Check and fix format of toml files (Uses: 'taplo')
[group('formatting')]
fmt-toml:
    taplo fmt

# Check and fix format of json and yaml files (Uses: 'prettier' or 'npx prettier')
[group('formatting')]
fmt-prettier:
    {{ prettier_bin }} --write .

# Run all fmt rules (Depends on: fmt, fmt-toml, fmt-prettier)
[group('formatting')]
fmt-all: fmt fmt-toml fmt-prettier

# Check format of rust files (Uses: 'cargo +nightly')
[group('formatting')]
check-fmt:
    cargo +nightly fmt --all --check

# Check format of toml files with `taplo` (Uses: 'taplo')
[group('formatting')]
check-fmt-toml:
    taplo fmt --check --verbose

# Check format of json and yaml files (Uses: 'prettier' or 'npx prettier')
[group('formatting')]
check-fmt-prettier:
    {{ prettier_bin }} --check --log-level warn .

# Check spelling with cspell (Uses: 'cspell' or 'npx cspell')
[group('formatting')]
check-spelling:
    {{ cspell_bin }} lint .

# Run all format checkers (Depends on: check-fmt, check-fmt-toml, check-fmt-prettier, check-spelling)
[group('formatting')]
check-fmt-all: check-fmt check-fmt-toml check-fmt-prettier check-spelling

# Run clippy (Uses: 'cargo +stable')
[group('lint')]
lint:
    cargo +stable clippy --features syn-error,__ui_tests --all-targets -- -D warnings
    cargo +nightly clippy --features nightly,syn-error,__ui_tests --all-targets -- -D warnings

# Check minimal supported Rust version (Uses: 'cargo +{{ msrv }}')
[group('lint')]
lint-msrv:
    cargo +{{ msrv }} check --package proc-macro-error3 --lib \
        --no-default-features --features syn2-error

# Run cargo deny check (Uses: 'cargo-deny')
[group('dependencies')]
deny +args='all':
    cargo deny check {{ args }}

# Generate and update Cargo.lock with cargo resolver v3 fallback (Uses: 'cargo +stable')
[group('dependencies')]
update-dependencies:
    CARGO_RESOLVER_INCOMPATIBLE_RUST_VERSIONS=fallback cargo +stable update

# Check minimal version requirements of dependencies (Uses: 'cargo-minimal-versions')
[group('dependencies')]
minimal-versions:
    cargo minimal-versions check --workspace --all-targets --ignore-private --direct

# Build the workspace (Uses: 'cargo')
[group('build')]
build:
    cargo build --all

# Build the documentation (Uses: 'cargo')
[group('build')]
build-docs:
    DOCS_RS=1 cargo doc --no-deps --workspace --document-private-items
    DOCS_RS=1 cargo +nightly doc --features nightly --no-deps --workspace --document-private-items

# Run all tests (Uses: 'cargo')
[group('test')]
test:
    cargo test --all

# Run all tests with nightly features (Uses: 'cargo +nightly')
[group('test')]
test-nightly:
    cargo +nightly test --all --features nightly

# Run all doc tests (Uses: 'cargo')
[group('test')]
test-doc:
    DOCS_RS=1 cargo test --doc
    DOCS_RS=1 cargo +nightly test --features nightly --doc

# Check supported syn feature combinations (Uses: 'cargo')
[group('test')]
test-features:
    cargo check -p proc-macro-error3 --lib --no-default-features
    cargo check -p proc-macro-error3 --lib --no-default-features --features syn2-error
    cargo check -p proc-macro-error3 --lib --no-default-features --features syn3-error
    cargo check -p proc-macro-error3 --lib --no-default-features --features syn2-error,syn3-error
    DOCS_RS=1 cargo test -p proc-macro-error3 --doc --no-default-features --features syn2-error
    DOCS_RS=1 cargo test -p proc-macro-error3 --doc --no-default-features --features syn3-error
    DOCS_RS=1 cargo test -p proc-macro-error3 --doc --no-default-features --features syn2-error,syn3-error

# Run the UI tests (Uses: 'cargo +stable')
[group('test')]
test-ui:
    cargo +stable test --features __ui_tests ui

# Run the UI tests and overwrite the error message fixtures (Uses: 'cargo +stable')
[group('test')]
test-ui-overwrite:
    TRYBUILD=overwrite cargo +stable test --features __ui_tests ui

# Test all packages (Uses: 'cargo')
[group('test')]
test-all: test-ui test-nightly test-doc test-features
    cargo test --all
