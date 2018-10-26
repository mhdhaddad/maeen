//
//  MetaResponseContext.swift
//  Maeen
//
//  Created by yahya alshaar on 10/5/18.
//  Copyright © 2018 yahya alshaar. All rights reserved.
//

import Foundation

class MetaResponseContext {
    var total = 0
    var context: PageContext!
}
extension MetaResponseContext /** +attributes */ {
    convenience init(attributes: [AnyHashable: Any]) {
        self.init()
        
        if let total = attributes["total"] as? Int {
            self.total = total
        }
        
        context = PageContext(attributes: attributes)
    }
}

struct PageContext {
    var pagination: PaginationContext!
    var path: PaginationPath!
    
    init(attributes: [AnyHashable: Any]) {
        pagination = PaginationContext(attributes: attributes)
        path = PaginationPath(attributes: attributes)
        
    }
}


struct PaginationPath {
    var root: URL?
    var first: URL?
    var next: URL?
    var previous: URL?
    var last: URL?
    
    init(attributes: [AnyHashable: Any]) {
        if let rootPath = attributes["path"] as? String {
            root = URL(string: rootPath)
        }
        
        if let firstPath = attributes["first_page_url"] as? String {
            first = URL(string: firstPath)
        }
        
        if let nextPath = attributes["next_page_url"] as? String {
            next = URL(string: nextPath)
        }
        
        if let previousPath = attributes["prev_page_url"] as? String {
            previous = URL(string: previousPath)
        }
        
        if let lastPath = attributes["last_page_url"] as? String {
            last = URL(string: lastPath)
        }
    }
}

struct PaginationContext {
    
    var first = 0
    var current = 0
    var last = 0
    var size = 0
    
    init(attributes: [AnyHashable: Any]) {
        if let first = attributes["from"] as? Int {
            self.first = first
        }
        
        if let last = attributes["to"] as? Int {
            self.last = last
        }
        
        if let current = attributes["current_page"] as? Int {
            self.current = current
        }
        
        if let size = attributes["per_page"] as? Int {
            self.size = size
        }
    }
}
