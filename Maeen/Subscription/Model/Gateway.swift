//
//  Gateway.swift
//  Maeen
//
//  Created by yahya alshaar on 9/22/18.
//  Copyright © 2018 yahya alshaar. All rights reserved.
//

import Foundation

class Gateway {
    var trackId: String!
    var url: URL!
}
extension Gateway /** +attributes */ {
    convenience init?(attributes: [AnyHashable: Any]) {
        guard let link = attributes["link"] as? String, let url = URL(string: link), let trackId = attributes["track_id"] as? String else {
            return nil
        }
        
        self.init()
        
        self.trackId = trackId
        self.url = url
    }
}
