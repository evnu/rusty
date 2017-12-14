#[macro_use] extern crate rustler;
#[macro_use] extern crate rustler_codegen;
#[macro_use] extern crate lazy_static;

use rustler::{NifEnv, NifTerm, NifResult, NifEncoder};

mod atoms {
    rustler_atoms! {
        atom ok;
        //atom error;
        //atom __true__ = "true";
        //atom __false__ = "false";
    }
}

#[derive(Debug, NifStruct)]
#[module="Rusty.AStruct"]
struct AStruct<'a> {
    a: i64,
    b: f64,
    c: String,
    d: NifTerm<'a>
}

#[derive(Debug, NifStruct)]
#[module="Rusty.WrappingStruct"]
struct WrappingStruct<'a> {
    a: AStruct<'a>,
    b: i64,
}

#[derive(Debug, NifTuple)]
struct ATuple<'a> {
    a: i64,
    b: f64,
    c: String,
    d: NifTerm<'a>
}

#[derive(Debug, NifTuple)]
struct WrappingTuple<'a> {
    a: ATuple<'a>,
    b: i64
}

#[derive(Debug, NifRecord)]
#[tag = "arecord"]
struct ARecord<'a> {
    a: i64,
    b: f64,
    c: String,
    d: NifTerm<'a>
}

#[derive(Debug, NifRecord)]
#[tag = "wrappingrecord"]
struct WrappingRecord<'a> {
    a: ARecord<'a>,
    b: i64
}

rustler_export_nifs! {
    "Elixir.Rusty",
    [
        ("echo_struct", 1, echo_struct),
        ("echo_wrapping_struct", 1, echo_wrapping_struct),
        ("echo_tuple", 1, echo_tuple),
        ("echo_wrapping_tuple", 1, echo_wrapping_tuple),
        ("echo_record", 1, echo_record),
        ("echo_wrapping_record", 1, echo_wrapping_record),
    ],
    None
}

fn echo_struct<'a>(env: NifEnv<'a>, args: &[NifTerm<'a>]) -> NifResult<NifTerm<'a>> {
    let s: AStruct = args[0].decode()?;

    Ok(s.encode(env))
}

fn echo_wrapping_struct<'a>(env: NifEnv<'a>, args: &[NifTerm<'a>]) -> NifResult<NifTerm<'a>> {
    let s: WrappingStruct = args[0].decode()?;

    Ok(s.encode(env))
}

fn echo_tuple<'a>(env: NifEnv<'a>, args: &[NifTerm<'a>]) -> NifResult<NifTerm<'a>> {
    let r: ATuple = args[0].decode()?;

    Ok(r.encode(env))
}

fn echo_wrapping_tuple<'a>(env: NifEnv<'a>, args: &[NifTerm<'a>]) -> NifResult<NifTerm<'a>> {
    let r: WrappingTuple = args[0].decode()?;

    Ok(r.encode(env))
}

fn echo_record<'a>(env: NifEnv<'a>, args: &[NifTerm<'a>]) -> NifResult<NifTerm<'a>> {
    let r: ARecord = args[0].decode()?;

    Ok(r.encode(env))
}

fn echo_wrapping_record<'a>(env: NifEnv<'a>, args: &[NifTerm<'a>]) -> NifResult<NifTerm<'a>> {
    let r: WrappingRecord = args[0].decode()?;

    Ok(r.encode(env))
}
