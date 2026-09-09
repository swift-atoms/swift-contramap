import Contramap
import Testing

@Suite struct `Borrowed input adaptation` {
    private struct Owned: ~Copyable { let value: Int }
    private enum Failure: Error, Equatable { case rejected }

    @Test func `projection borrows its owner and produces a noncopyable result`() {
        let projection = Contramap { (source: borrowing Owned) in Owned(value: source.value + 1) }
        let source = Owned(value: 2)
        let first = projection(source)
        let second = projection(source)
        #expect(first.value == 3)
        #expect(second.value == 3)
        #expect(source.value == 2)
    }

    @Test func `projection accepts scoped input`() {
        let projection = Contramap { (source: borrowing Span<Int>) in source.count }
        let values = [1, 2]
        let result = projection(values.span)
        #expect(result == 2)
    }

    @Test func `projection preserves typed failures`() {
        let projection = Contramap { (source: borrowing Int) throws(Failure) -> Int in
            guard source > 0 else { throw .rejected }
            return copy source
        }
        #expect(throws: Failure.rejected) { try projection(0) }
    }
}
