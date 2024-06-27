@resultBuilder
public enum HTMLBuilder {
  public static func buildArray(_ components: [some HTML]) -> some HTML {
    HTMLArray(elements: components)
  }

  public static func buildBlock<Content: HTML>(_ content: Content) -> Content {
    content
  }

  public static func buildBlock<each Content: HTML>(
    _ content: repeat each Content
  ) -> _HTMLTuple<repeat each Content> {
    _HTMLTuple(content: repeat each content)
  }

  public static func buildEither<First: HTML, Second: HTML>(
    first component: First
  ) -> _HTMLConditional<First, Second> {
    .first(component)
  }

  public static func buildEither<First: HTML, Second: HTML>(
    second component: Second
  ) -> _HTMLConditional<First, Second> {
    .second(component)
  }

  public static func buildExpression<T: HTML>(_ expression: T) -> T {
    expression
  }

  public static func buildExpression(_ expression: String) -> some HTML {
    HTMLText(expression)
  }

  public static func buildOptional<T: HTML>(_ component: T?) -> T? {
    component
  }
}

private struct HTMLArray<Element: HTML>: HTML {
  let elements: [Element]
  static func _render(_ html: Self, into printer: inout HTMLPrinter) {
    for element in html.elements {
      Element._render(element, into: &printer)
    }
  }
  var body: Never { fatalError() }
}

public enum _HTMLConditional<First: HTML, Second: HTML>: HTML {
  case first(First)
  case second(Second)
  public static func _render(_ html: Self, into printer: inout HTMLPrinter) {
    switch html {
    case let .first(first):
      First._render(first, into: &printer)
    case let .second(second):
      Second._render(second, into: &printer)
    }
  }
  public var body: Never { fatalError() }
}

public struct HTMLText: HTML {
  let text: String
  let raw: Bool
  public init(_ text: String, raw: Bool = false) {
    self.text = text
    self.raw = raw
  }
  public static func _render(_ html: Self, into printer: inout HTMLPrinter) {
    // TODO: Escape
    printer.bytes.append(contentsOf: html.text.utf8)
  }
  public var body: Never { fatalError() }
}

public struct _HTMLTuple<each Content: HTML>: HTML {
  let content: (repeat each Content)
  public init(content: repeat each Content) {
    self.content = (repeat each content)
  }
  public static func _render(_ html: Self, into printer: inout HTMLPrinter) {
    func render<T: HTML>(_ html: T) {
      let oldAttributes = printer.attributes
      defer { printer.attributes = oldAttributes }
      T._render(html, into: &printer)
    }
    repeat render(each html.content)
  }
  public var body: Never { fatalError() }
}

extension Optional: HTML where Wrapped: HTML {
  public static func _render(_ html: Self, into printer: inout HTMLPrinter) {
    guard let html else { return }
    Wrapped._render(html, into: &printer)
  }
  public var body: Never { fatalError() }
}