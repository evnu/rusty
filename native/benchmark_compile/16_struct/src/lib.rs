use rustler::Encoder;
use rustler_codegen::NifRecord;

#[derive(NifRecord)]
#[tag = "test"]
struct Struct {
    field1: i64,
    field2: i64,
    field3: i64,
    field4: i64,
    field5: i64,
    field6: i64,
    field7: i64,
    field8: i64,
    field9: i64,
    field10: i64,
    field11: i64,
    field12: i64,
    field13: i64,
    field14: i64,
    field15: i64,
    field16: i64,
}
