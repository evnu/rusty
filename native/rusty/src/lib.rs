#[macro_use]
extern crate lazy_static;
#[macro_use]
extern crate rustler;
#[macro_use]
extern crate rustler_codegen;

use rustler::{NifEncoder, NifEnv, NifError, NifResult, NifTerm};

mod atoms {
    rustler_atoms! {
        atom ok;
        //atom error;
        //atom __true__ = "true";
        //atom __false__ = "false";
    }
}


rustler_export_nifs! {
    "Elixir.Rusty",
    [
        ("trampoline", 1, trampoline)
    ],
    None
}

fn trampoline<'a>(env: NifEnv<'a>, args: &[NifTerm<'a>]) -> NifResult<NifTerm<'a>> {
    let ident: String = args[0].decode()?;

    match ident.as_ref() {
        "test::test()" => test::test(),
        "test::test2()" => test::test2(),
        &_ => {
            let error = NifError::RaiseTerm(Box::new(format!("Unknown test case {}", ident)));
            return Err(error);
        }
    }

    Ok(atoms::ok().encode(env))
}

mod test {
    use super::*;

    pub fn test() {
        assert_eq!(true, false);
    }

    pub fn test2() {
        assert_eq!(atoms::ok(), atoms::ok());
    }
}
