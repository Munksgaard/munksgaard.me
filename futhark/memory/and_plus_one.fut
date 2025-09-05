entry and_plus_one (xs: *[]i32): *[](i32, i32) =
  map (\x -> (x, x + 1)) xs

entry plus_one (xs: *[]i32): *[]i32 =
  map (+ 1) xs
