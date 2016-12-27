//
//  Device.swift
//  Wasted Days
//
//  Created by Connor Stout on 8/24/16.
//  Copyright © 2016 Connor Stout. All rights reserved.
//

import Foundation
import CoreData
import UIKit
class Device : NSManagedObject{
    
    @NSManaged var yearMonthYear: Int32
    @NSManaged var task: String
    @NSManaged var type: Int32
    @NSManaged var hour: Int32

}