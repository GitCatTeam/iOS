//
//  GitCatWidget.swift
//  GitCatWidget
//
//  Created by 조윤영 on 2020/10/16.
//  Copyright © 2020 조윤영. All rights reserved.
//

import WidgetKit
import Foundation
import SwiftUI

struct GitCatProvider: TimelineProvider {
    func placeholder(in context: Context) -> GitCatEntry {
        let data = WidgetDataModel(commitCount: 0, level: 0, item: "-", needScore: 0, commits: [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0])
        let entry = GitCatEntry(date: Date(), data: data)
        return entry
    }
    
    func getSnapshot(in context: Context, completion: @escaping (GitCatEntry) -> Void) {
        let data = WidgetDataModel(commitCount: 0, level: 0, item: "-", needScore: 0, commits: [0,0,0,1,2,3,1,2,1,3,3,2,1,1,2,2,3,1,1,2,3,3,3,1,1,2,2,1,1,1])
        let entry = GitCatEntry(date: Date(), data: data)
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<GitCatEntry>) -> Void) {
        
        let currentDate = Date()
        let refreshDate = Calendar.current.date(byAdding: .minute, value: 30, to: currentDate)!
        HomeService.sharedInstance.getHomeData { (result) in
            switch result {
                
            case .networkSuccess(let data) :
                let detailData = data as? WidgetDataModel
                    
                if let resResult = detailData {
                    let entry = GitCatEntry(date: currentDate, data: resResult)
                    let timeline = Timeline(entries: [entry], policy: .after(refreshDate))
                    completion(timeline)
                }
                break
            case .accessDenied:
                break
            case .maintainance:
                break
            case .dataNeeded:
                break
            case .networkFail :
                break
            default:
                break
            }
        }
    }
}

struct GitCatEntry: TimelineEntry {
    var date = Date()
    let data: WidgetDataModel
}

struct GitCatWidgetEntryView : View {
    @Environment(\.widgetFamily) private var widgetFamily
    var entry: GitCatProvider.Entry

    @ViewBuilder
    var body: some View {
        switch widgetFamily {
        case .systemSmall:
            Text("systemSmall")
        case .systemMedium:
            Text("systemMedium")
        case .systemLarge:
            Text("systemLarge")
        @unknown default:
            Text("unknown")
        }
    }
}

@main
struct GitCatWidget: Widget {
    static let kind: String = "GitCatWidget"

    public var body: some WidgetConfiguration {
        StaticConfiguration(kind: GitCatWidget.kind, provider: GitCatProvider()) { entry in
            GitCatWidgetEntryView(entry: entry).unredacted()
        }
        .configurationDisplayName("GitCat")
        .description("커밋 내역을 간단하게 확인해보세요.")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

struct GitCatWidget_Previews: PreviewProvider {
    static var previews: some View {
        let data = WidgetDataModel(commitCount: 0, level: 0, item: "-", needScore: 0, commits: [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0])
        GitCatWidgetEntryView(entry: GitCatEntry(date: Date(), data: data))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
