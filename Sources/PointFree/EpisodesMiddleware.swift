import Dependencies
import Foundation
import Html
import HttpPipeline
import PointFreeRouter
import Prelude
import StyleguideV2
import Tuple
import Views

public func episodesMiddleware(
  route: SiteRoute.EpisodesRoute,
  _ conn: Conn<StatusLineOpen, Void>
) async -> Conn<ResponseEnded, Data> {
  switch route {
  case .list(let listType):
    return await episodesListMiddleware(listType: listType, conn)

  case let .progress(param: param, percent: percent):
    return await progressResponse(conn.map(const(param .*. percent .*. unit)))
      .performAsync()

  case let .show(param):
    return await episodeResponse(conn.map(const(param .*. nil .*. unit)))
      .performAsync()
  }
}

private func episodesListMiddleware(
  listType: SiteRoute.EpisodesRoute.ListType,
_ conn: Conn<StatusLineOpen, Void>
) async -> Conn<ResponseEnded, Data> {
  return conn
    .writeStatus(.ok)
    .respondV2(
      layoutData: SimplePageLayoutData(
        description: "Point-Free: A video series exploring advanced programming topics in Swift.",
        extraHead: [],
        extraStyles: .empty,
        image: "",
        isGhosting: false,
        openGraphType: .website,
        style: .base(.minimal(.dark)),
        title: "Point-Free",
        twitterCard: .summaryLargeImage,
        usePrismJs: false
      )
    ) {
      Home(
        allFreeEpisodeCount: 0,
        creditCount: 0,
        clips: []
      )
    }
}
