//
//  WidgetRefresh.swift
//  Kodi Remote
//
//  Created by Henry Buschmann on 25.09.22.
//  Copyright © 2022 joethefox inc. All rights reserved.
//

import Foundation
import WidgetKit

@objc class Refresh: NSObject {
    @objc
    func test() {
        if #available(iOS 14.0, *) {
        WidgetCenter.shared.reloadAllTimelines()
            print("did load")
        } else {}
    }
}
