(module
  (import "js" "readString" (func $readString (param $address i32) (param $length i32) (result externref)))
  (import "document" "log" (func $document_log (param $arg externref)))
  (import "document" "log" (func $num_log (param $arg i32)))
  (import "document" "getElementById" (func $getElementById (param $id externref) (result externref)))
  (import "document" "setInnerText" (func $setInnerText (param $element externref) (param $str externref)))
  (import "js" "memory" (memory 1))
  (data (i32.const 0) "lol\00code\00fizz\00buzz\00")
  (global $output i32 (i32.const 42))
  (func $strlen (param $str i32) (result i32) (local $ptr i32)
    local.get $str
    local.set $ptr
    (loop $loop
      local.get $ptr
      i32.load8_u
      i32.const 0
      i32.ne
      (if (then
        local.get $ptr
        i32.const 1
        i32.add
        local.set $ptr
        br $loop)))
    local.get $ptr
    local.get $str
    i32.sub)
  (func $str (param $str i32) (result externref)
    (call $readString
      (local.get $str)
      (call $strlen
        (local.get $str))))
  (func $int2str (param $ptr i32) (param $int i32) (result i32)
    (if
      (i32.ge_u
        (local.get $int)
        (i32.const 10))
      (then
        (local.set $ptr
          (call $int2str
            (local.get $ptr)
            (i32.div_u
              (local.get $int)
              (i32.const 10))))
        (local.set $int
          (i32.rem_u
            (local.get $int)
            (i32.const 10)))))
    (i32.store8
      (local.get $ptr)
      (i32.add
        (local.get $int)
        (i32.const 48)))
    (i32.add
      (local.get $ptr)
      (i32.const 1)))
  (func $fizzbuzz (param $upperbound i32) (local $i i32) (local $log i32) (local $prevlog i32) 
    (local.set $i
      (i32.const 1))
    (local.set $log
      (global.get $output))
    (block $exit
      (loop $loop
        (br_if $exit
          (i32.gt_u
            (local.get $i)
            (local.get $upperbound)))
        (local.set $prevlog
          (local.get $log))
        (if
          (i32.eq
            (i32.rem_u
              (local.get $i)
              (i32.const 3))
            (i32.const 0))
          (then
            (i32.store
              (local.get $log)
              (i32.load
                (i32.const 9)))
            (local.set $log
              (i32.add
                (local.get $log)
                (i32.const 4)))))
        (if
          (i32.eq
            (i32.rem_u
              (local.get $i)
              (i32.const 5))
            (i32.const 0))
          (then
            (i32.store
              (local.get $log)
              (i32.load
                (i32.const 14)))
            (local.set $log
              (i32.add
                (local.get $log)
                (i32.const 4)))))
        (if
          (i32.eq
            (local.get $log)
            (local.get $prevlog))
          (then
            (local.set $log
              (call $int2str
                (local.get $log)
                (local.get $i)))))
        (i32.store8
          (local.get $log)
          (i32.const 10))
        (local.set $log
          (i32.add
            (local.get $log)
            (i32.const 1)))
        (local.set $i
          (i32.add
            (local.get $i)
            (i32.const 1)))
        (br $loop)))
  )
  (func $button (export "button")
    (call $fizzbuzz
      (i32.const 255))
    (call $setInnerText
      (call $getElementById
        (call $str
          (i32.const 4)))
      (call $str
        (global.get $output))))
  (func $main (export "main") (result i32) (local i32)
    i32.const 0))