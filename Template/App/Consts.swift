//
//  Consts.swift
//  Dev
//
//  Created by Martin Kock on 23/11/2024.
//

import Foundation
import SwiftUI

enum Consts {
    enum App {
        /// The id given to the app in AppStore
        static let appleID = "1234"  // TODO: Set to correct value
        static let defaultLanguage: Consts.Firebase.Languages = .da
        static let shouldUseTabbar: Bool = false
    }
    
    enum Firebase {
        enum Languages: String {
            case da
            case en
            
            static func getCurrentLanguage() -> Consts.Firebase.Languages {
                guard
                    let id = Locale.autoupdatingCurrent.language.languageCode?.identifier(.alpha2)
                else { return Consts.App.defaultLanguage }
                guard let converted = Consts.Firebase.Languages(rawValue: id)
                else { return Consts.App.defaultLanguage }
                return converted
            }
        }
        
        enum Collections: String {
            case languages
            case users
            case userLogbooks
            case trainers
            case workoutPlans
            case userWorkoutPlans
            case exercises
            case exerciseTemplates
            case meta
            case creatorTypes
            case weights
            case workoutForms
            case places
            case equipment
            case workoutDurations
            case workoutCategories
        }
    }
    
    enum UI {
        static let animDuration: TimeInterval = 0.2
        static let screenWidth: CGFloat = UIScreen.main.bounds.width
        
        enum Fonts {
            case h1_default
            case h2_default
            case h3_default
            case p_default
            case p_emphasized
            case btn_default
            case label_default
            case label_emphasized
            case label_small
        }
    }
    
    enum URLs {
        
    }
    
}

extension Consts.UI.Fonts {
    func font() -> Font {
        switch self {
        case .h1_default:
            return Fonts.standard(.largeTitle, fontSize: 32, weight: .bold)
                .font
        case .h2_default:
            return Fonts.standard(.title2, fontSize: 24, weight: .regular)
                .font
        case .h3_default:
            return Fonts.standard(.title3, fontSize: 20, weight: .regular)
                .font
                .leading(.loose)
        case .p_default:
            return Fonts.standard(.headline, fontSize: 16, weight: .regular)
                .font
        case .p_emphasized:
            return Fonts.standard(.headline, fontSize: 16, weight: .medium)
                .font
        case .btn_default:
            return Fonts.standard(.headline, fontSize: 18, weight: .medium)
                .font
                .leading(.loose)
        case .label_default:
            return Fonts.standard(.footnote, fontSize: 14, weight: .regular)
                .font
        case .label_emphasized:
            return Fonts.italic(.footnote, fontSize: 14, weight: .regular)
                .font
        case .label_small:
            return Fonts.standard(.footnote, fontSize: 12, weight: .regular)
                .font
        }
    }
}


extension Bundle {
    public var appName: String { getInfo("CFBundleName") }
    public var displayName: String { getInfo("CFBundleDisplayName") }
    public var language: String { getInfo("CFBundleDevelopmentRegion") }
    public var identifier: String { getInfo("CFBundleIdentifier") }
    public var copyright: String {
        getInfo("NSHumanReadableCopyright").replacingOccurrences(
            of: "\\\\n", with: "\n")
    }
    
    public var appBuild: String { getInfo("CFBundleVersion") }
    public var appVersionLong: String { getInfo("CFBundleShortVersionString") }
    
    fileprivate func getInfo(_ str: String) -> String {
        infoDictionary?[str] as? String ?? "⚠️"
    }
}
