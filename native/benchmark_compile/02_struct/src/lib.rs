use rustler::Encoder;
use rustler_codegen::NifRecord;

#[derive(NifRecord)]
#[tag = "test"]
struct Struct {
    field1: i64,
    field2: i64,
}
