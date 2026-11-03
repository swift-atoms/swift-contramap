# swift-contramap

Use this package when you need to read a value out of a source you only borrow, such as a noncopyable owner or a scoped `Span`, so the caller keeps the source and can project from it again. Start from `Contramap`. When the transformation should take ownership of its input, or produce a nonescapable result tied to that input, use swift-map instead.

## Laws

- Every call runs `project` again. Nothing is cached, so two calls on the same source return two separately produced results.
