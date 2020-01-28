use rustler::Encoder;
use rustler_codegen::NifStruct;

#[derive(NifStruct)]
#[module = "Elixir.Struct8"]
struct Struct {
    field1: i64,
    field2: i64,
    field3: i64,
    field4: i64,
    field5: i64,
    field6: i64,
    field7: i64,
    field8: i64,
}
