use rustler::Encoder;
use rustler_codegen::NifTuple;

#[derive(NifTuple)]
struct Struct {
    field1: i64,
    field2: i64,
}
