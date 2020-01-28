use rustler::Encoder;
use rustler_codegen::NifStruct;

#[derive(NifStruct)]
#[module = "Elixir.Struct2"]
struct Struct {
    field1: i64,
    field2: i64,
}
