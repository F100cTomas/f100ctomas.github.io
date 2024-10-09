(module
  (import "js" "readString" (func $readString (param $address i32) (param $length i32) (result externref)))
  (import "document" "log" (func $document_log (param $arg externref)))
  (import "document" "getElementById" (func $getElementById (param $id externref) (result externref)))
  (import "document" "setInnerText" (func $setInnerText (param $element externref) (param $str externref)))
  (import "js" "memory" (memory 1))
  (data (i32.const 0) "lol\00")
  (func $button (export "button")
    (call $document_log
      (call $readString
        (i32.const 0)
        (i32.const 3)))
    (call $setInnerText
      (call $getElementById 
        (call $readString 
          (i32.const 0)
          (i32.const 3)))
      (call $readString
        (i32.const 0)
        (i32.const 3))))
  (func $main (export "main") (result i32) (local i32)
    i32.const 0))