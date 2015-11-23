//
//  Photo.swift
//  Photos
//
//  Created by Gene Yoo on 11/3/15.
//  Copyright © 2015 iOS DeCal. All rights reserved.
//

import Foundation

class Photo {
    /* The number of likes the photo has. */
    var likes : Int!
    /* The string of the url to the photo file. */
    var url : String!
    /* The username of the photographer. */
    var username : String!
    
    var date: NSDate!

    /* Parses a NSDictionary and creates a photo object. */
    init (data: NSDictionary) {
        // FILL ME IN
        // HINT: use nested .valueForKey() calls, and then cast using 'as! TYPE'
        likes = data.valueForKey("likes")!.valueForKey("count") as! Int
        url = data.valueForKey("images")!.valueForKey("thumbnail")!.valueForKey("url") as! String
        username = data.valueForKey("user")!.valueForKey("username") as! String
        let dateString = data.valueForKey("created_time")
        date = NSDate(timeIntervalSince1970: NSNumberFormatter().numberFromString(dateString as! String)!.doubleValue)
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
//        print(dateString as! String)
//        print(dateFormatter.stringFromDate(date))
    }

}