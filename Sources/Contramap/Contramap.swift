/// A borrowed input projection for adapting consumers to a different source.
/// The source is never consumed. The projected value is owned and escapable.
public struct Contramap<
    Source: ~Copyable & ~Escapable,
    Target: ~Copyable,
    Failure: Swift.Error
> {
    public let project: (borrowing Source) throws(Failure) -> Target

    @inlinable
    public init(_ project: @escaping (borrowing Source) throws(Failure) -> Target) {
        self.project = project
    }

    @inlinable
    public func callAsFunction(_ source: borrowing Source) throws(Failure) -> Target {
        try project(source)
    }
}

extension Contramap where Source: ~Copyable & ~Escapable, Target: ~Copyable, Failure == Never {
    @inlinable
    public init(_ project: @escaping (borrowing Source) -> Target) {
        self.project = project
    }
}
