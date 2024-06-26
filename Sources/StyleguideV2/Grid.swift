import Html
import FunctionalCss

public struct GridRowV2<Content: HTML>: HTML {
  let alignment: Alignment
  @HTMLBuilder let content: Content
  public init(alignment: Alignment, @HTMLBuilder content: () -> Content) {
    self.alignment = alignment
    self.content = content()
  }

  public var body: some HTML {
    div {
      content
    }
    .inlineStyle("align-items", alignment.rawValue)
    .inlineStyle("box-sizing", "border-box")
    .inlineStyle("display", "flex")
    .inlineStyle("flex-grow", "0")
    .inlineStyle("flex-shrink", "1")
    .inlineStyle("flex-basis", "auto")
    .inlineStyle("flex-direction", "row")
    .inlineStyle("flex-wrap", "wrap")
  }

  public enum Alignment: String {
    case baseline = "baseline"
    case center = "center"
    case end = "flex-end"
    case start = "flex-start"
    case stretch = "stretch"
  }
}
//extension HTML {
//  public func row(alignment: GridColumnV2<HTMLTag>.Alignment, media: MediaQuery? = nil) -> some HTML {
//    self
//      .inlineStyle("justify-content", "flex-\(alignment.rawValue)", media: media?.rawValue)
//      .inlineStyle("text-align", alignment.rawValue, media: media?.rawValue)
//  }
//}

public struct GridColumnV2<Content: HTML>: HTML {
  @HTMLBuilder let content: Content
  public init(@HTMLBuilder content: () -> Content) {
    self.content = content()
  }

  public var body: some HTML {
    div {
      content
    }
    .inlineStyle("flex-grow", "1")
    .inlineStyle("flex-grow", "0", media: MediaQuery.desktop.rawValue)
    .inlineStyle("flex-shrink", "0")
    .inlineStyle("max-width", "100%")
    .inlineStyle("box-sizing", "border-box")
  }

  public enum Alignment: String {
    case end = "end"
    case center = "center"
  }
}

extension HTML {
  public func column(count: Int, media: MediaQuery? = nil) -> some HTML {
    self
      .inlineStyle("flex-basis", "\(Double(count) / 0.12)%", media: media?.rawValue)
      .inlineStyle("max-width", "\(Double(count) / 0.12)%", media: media?.rawValue)
  }
  public func column(alignment: GridColumnV2<HTMLTag>.Alignment, media: MediaQuery? = nil) -> some HTML {
    self
      .inlineStyle("justify-content", "flex-\(alignment.rawValue)", media: media?.rawValue)
      .inlineStyle("text-align", alignment.rawValue, media: media?.rawValue)
  }
}
