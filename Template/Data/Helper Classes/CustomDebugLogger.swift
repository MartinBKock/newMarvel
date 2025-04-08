//
//  CustomDebugLogger.swift
//  Template
//
//  Created by Martin Kock on 25/11/2024.
//


//import Foundation
//import MBLog
//
//struct CustomDebugLogger: MBLogger {
//    var minLogLevel: MBLogLevel
//
//    init(minLogLevel: MBLogLevel = .debug) {
//        self.minLogLevel = minLogLevel
//    }
//
//    public func log(context c: inout MBLogContext) {
//        var message = ""
//
//        switch minLogLevel {
//        case .debug:
//            message.append("\n🪲 ")
//        case .info:
//            message.append("\nℹ️ ")
//        case .notice:
//            message.append("\n📌 ")
//        case .error:
//            message.append("\n❌ ")
//        case .fault:
//            message.append("\n🚨 ")
//        default:
//            break
//        }
//
//        message.append(
//            "\(c.timeString)"
//                .appending(" ")
//                .appending("\(c.fileName)")
//                .prefix(80)
//                .appending("-Line:\(c.line)")
//                .padding(toLength: 85, withPad: " ", startingAt: 0)
//                .appending(" ")
//                .appending(c.message.value)
//        )
//        print(message)
//    }
//}
