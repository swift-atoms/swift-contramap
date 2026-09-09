# swift-contramap

`Contramap<Source, Target, Failure>` stores a typed projection that borrows its
source. A consumer of Target can use that projection to accept Source instead.
The package has no Predicate, Parser, or Optic dependency.

```swift
let length = Contramap { (text: borrowing String) in text.count }
let count = length("hello")
```

Nonthrowing closures infer Failure == Never. Throwing projections preserve their
typed error. Each invocation projects again; results and failures are not cached.

Source may be noncopyable and scoped. Target may be noncopyable but must be
escapable: it is a produced value, not a borrowed focus. Borrowed/scoped focuses
require a visitor or an explicit result-lifetime contract, rather than relaxing
the constraint alone.

Unlike the current Map representation, this operation does not consume Source.
Consumers define how projection results and failures affect their own operation.
The Predicate integration lives in swift-predicate behind its Contramap trait.
