use rustler::Encoder;
use rustler_codegen::NifMap;

#[derive(NifMap)]
struct Struct {
    field1: i64,
    field2: i64,
    field3: i64,
    field4: i64,
}
