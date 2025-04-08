//
//  UserDefaultsService.swift
//  RecipeAppFirebase
//
//  Created by Martin Kock on 18/09/2023.
//


import SwiftUI


@available(iOS 14.0, *)
actor UserDefaultsService {
    
    // MARK: - Singleton
    
    // MARK: - Private init
    init() {}
    
    // MARK: - Public properties
    @AppStorage("pageChar") var pageChar: [PaginationModel] = []
    @AppStorage("pageComic") var pageComic: [PaginationModel] = []
    @AppStorage("pageCreator") var pageCreator: [PaginationModel] = []
    @AppStorage("pageEvent") var pageEvent: [PaginationModel] = []
    @AppStorage("pageSeries") var pageSeries: [PaginationModel] = []
    @AppStorage("pageStory") var pageStory: [PaginationModel] = []
    

    // MARK: - Public functions
    func savePageToUserDefaults(page: PaginationModel, type: String) {
        switch type {
        case "char":
            pageChar.removeAll()
            pageChar.append(page)
        case "comic":
            pageComic.removeAll()
            pageComic.append(page)
        case "creator":
            pageCreator.removeAll()
            pageCreator.append(page)
        case "event":
            pageEvent.removeAll()
            pageEvent.append(page)
        case "series":
            pageSeries.removeAll()
            pageSeries.append(page)
        case "story":
            pageStory.removeAll()
            pageStory.append(page)
        default:
            print("No such type")
        }
    }

    func getPageFromUserDefaults(type: String) -> PaginationModel {
        switch type {
        case "char":
            return pageChar.first ?? PaginationModel(offset: 0, count: 0, timesPageRequested: 0)
        case "comic":
            return pageComic.first ?? PaginationModel(offset: 0, count: 0, timesPageRequested: 0)
        case "creator":
            return pageCreator.first ?? PaginationModel(offset: 0, count: 0, timesPageRequested: 0)
        case "event":
            return pageEvent.first ?? PaginationModel(offset: 0, count: 0, timesPageRequested: 0)
        case "series":
            return pageSeries.first ?? PaginationModel(offset: 0, count: 0, timesPageRequested: 0)
        case "story":
            return pageStory.first ?? PaginationModel(offset: 0, count: 0, timesPageRequested: 0)
        default:
            return PaginationModel(offset: 0, count: 0, timesPageRequested: 0)
        }
    }
    
    
    
    
}
