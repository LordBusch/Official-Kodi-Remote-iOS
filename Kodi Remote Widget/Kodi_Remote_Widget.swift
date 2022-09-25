//
//  Kodi_Remote_Widget.swift
//  Kodi Remote Widget
//
//  Created by Henry Buschmann on 23.09.22.
//  Copyright © 2022 joethefox inc. All rights reserved.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), text: "")
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), text: "")
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []
        
        let userDefaults = UserDefaults(suiteName: "group.com.kodifoundation.officialkodiremote")
        let text = userDefaults?.value(forKey: "title") as? String ?? ""

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, text: "")
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let text: String
}

struct Kodi_Remote_WidgetEntryView : View {
    var entry: Provider.Entry
    var title: String {
        if ((UserDefaults(suiteName: "group.com.kodifoundation.officialkodiremote")!.value(forKey: "title")) == nil) { return "nothing"}
        else { return UserDefaults(suiteName: "group.com.kodifoundation.officialkodiremote")!.value(forKey: "title") as! String}
    }

    var body: some View {
        VStack {
            Text(entry.date, style: .time)
            Text(title)
        }
    }
}

@main
struct Kodi_Remote_Widget: Widget {
    let kind: String = "Kodi_Remote_Widget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            Kodi_Remote_WidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Kodi Remote")
        .description("This widget displays, what´s currently playing.")
    }
}

struct Kodi_Remote_Widget_Previews: PreviewProvider {
    static var previews: some View {
        Kodi_Remote_WidgetEntryView(entry: SimpleEntry(date: Date(), text: ""))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
