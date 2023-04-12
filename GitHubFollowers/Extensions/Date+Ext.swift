//
//  Date+Ext.swift
//  GitHubFollowers
//
//  Created by GO on 4/6/23.
//

import Foundation

extension Date {
    func convertMonthYearFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"
        
        return dateFormatter.string(from: self )
    }
}
