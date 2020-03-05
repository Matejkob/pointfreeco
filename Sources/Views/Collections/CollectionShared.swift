import Css
import EmailAddress
import Foundation
import FunctionalCss
import Html
import HtmlCssSupport
import Models
import PointFreePrelude
import PointFreeRouter
import Prelude
import Styleguide
import Tagged
import TaggedTime

func collectionHeader(
  title: String,
  category: String,
  subcategory: String,
  subcategoryCount: Int,
  length: Seconds<Int>,
  blurb: String
) -> Node {
  .div(
    attributes: [
      .class([
        Class.pf.colors.bg.black,
        Class.border.top,
      ]),
      .style(key("border-top-color", "#333")),
    ],
    .gridRow(
      attributes: [
        .class([
          Class.grid.middle(.desktop),
          Class.padding([
            .desktop: [.leftRight: 5],
            .mobile: [.leftRight: 3, .topBottom: 4],
          ]),
        ]),
        .style(maxWidth(.px(1080)) <> margin(topBottom: nil, leftRight: .auto)),
      ],
      .gridColumn(
        sizes: [.mobile: 12],
        attributes: [],
        .h1(
          attributes: [
            .class([
              Class.pf.colors.fg.white,
              Class.pf.type.responsiveTitle2,
              Class.type.align.center,
            ]),
            .style(lineHeight(1.2))
          ],
          .text(title)
        ),
        .div(
          attributes: [
            .class([
              Class.pf.colors.fg.gray650,
              Class.pf.type.body.small,
              Class.type.align.center,
            ]),
          ],
          "\(category) • \(subcategory.pluralize(subcategoryCount)) • \(length.formattedDescription)"
        ),
        .div(
          attributes: [
            .class([
              Class.padding([.mobile: [.top: 3, .leftRight: 4]]),
              Class.pf.colors.fg.gray850,
              Class.pf.type.body.regular,
            ]),
          ],
          .markdownBlock(blurb)
        )
      )
    )
  )
}

fileprivate extension String {
  func pluralize(_ count: Int) -> String {
    let string = "\(count) \(self)"
    return count == 1 ? string
      : string.hasSuffix("y") ? string.replacingOccurrences(of: "y$", with: "ies", options: .regularExpression)
      : "\(string)s"
  }
}

fileprivate extension Seconds where RawValue == Int {
  var formattedDescription: String {
    let length = self.rawValue
    let hours = length / 3600
    let minutes = (length / 60) % 60
    return hours > 0
      ? "\(hours) hr \(minutes) min"
      : "\(minutes) min"
  }
}