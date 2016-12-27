//
//  Goals.swift
//  Wasted Days
//
//  Created by Connor Stout on 12/26/16.
//  Copyright © 2016 Connor Stout. All rights reserved.
//

import Foundation
import CoreData
import UIKit
class Goals : NSManagedObject{
    
    
    @NSManaged var yearMonthDay: String
    @NSManaged var goals: String
    @NSManaged var goalsDone: String
    
    
}