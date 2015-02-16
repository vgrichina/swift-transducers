swift-transducers
=================

Port of Clojure's transducers to Apple's Swift language

## Motivation

[Clojure's transducers](http://clojure.org/transducers) represent an elegant and high-efficient way to transform data. 
[JS implementation](http://jlongster.com/Transducers.js--A-JavaScript-Library-for-Transformation-of-Data) fared well,
so I decided to try implementing them in Swift as well.

## Examples

```
transduce(
    map({$0 + 1}) |>
    filter({$0 % 2 == 0}) |>
    map({$0 * 2}), append, [], [1, 2, 3, 4, 5])

// [4, 8, 12]
```

Code above is roughly equvivalent to following code with regular `map` / `filter` calls:

```
[1, 2, 3, 4, 5]
    .map({$0 + 1})
    .filter({$0 % 2 == 0})
    .map({$0 * 2})
```

## Performance

Currently it is anything but ready for production use. As tested on Xcode Version 6.1.1 (6A2008a), 
it is at least 100x worse than standard `map` / `filter` chain.
