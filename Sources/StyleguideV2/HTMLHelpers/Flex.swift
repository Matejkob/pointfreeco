extension HTML {
  public func flexContainer(
    direction: String? = nil,
    wrap: String? = nil,
    justification: String? = nil,
    itemAlignment: String? = nil,
    rowGap: String? = nil,
    columnGap: String? = nil
  ) -> some HTML {
    self
      .inlineStyle("display", "flex")
      .inlineStyle("flex-direction", direction)
      .inlineStyle("flex-wrap", wrap)
      .inlineStyle("justify-content", justification)
      .inlineStyle("align-items", itemAlignment)
      .inlineStyle("row-gap", rowGap)
      .inlineStyle("column-gap", columnGap)
  }

  public func flexItem(
    grow: String? = nil,
    shrink: String? = nil,
    basis: String? = nil
  ) -> some HTML {
    self
      .inlineStyle("flex-grow", grow)
      .inlineStyle("flex-shrink", shrink)
      .inlineStyle("flex-basis", basis)
  }
}
