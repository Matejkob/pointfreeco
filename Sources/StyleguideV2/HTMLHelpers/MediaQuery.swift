public struct MediaQuery: Hashable {
  public var rawValue: String

  public static let desktop = Self(rawValue: "only screen and (min-width: 832px)")
  public static let mobile = Self(rawValue: "only screen and (max-width: 831px)")
}