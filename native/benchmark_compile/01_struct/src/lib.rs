use rustler::Encoder;
use rustler_codegen::NifStruct;

#[derive(NifStruct)]
#[module = "Elixir.Struct1"]
struct Struct {
    field1: i64,
}
