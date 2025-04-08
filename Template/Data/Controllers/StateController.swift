//
//  StateController.swift
//  Dev
//
//  Created by Martin Kock on 30/03/2024.
//

import Foundation
import SwiftUI
import Algorithms
//import MBKError

@MainActor
@Observable
class StateController {
    var chars = [ResultData]()
    var cats: [String] = []
    var currentSelectedCategory = Categories.chars
    var comics = [ComicResult]()
    var creators = [CreatorResult]()
    var events = [EventResult]()
    var series = [SeriesResult]()
    var stories = [StoryResult]()
    var alreadySearchedNames = [String]()
    
    
    var charOffset = 0
    var howManyCharPags = 0
    var totalChars = 0
    var isLoadingChars = false
    
    var comicOffset = 0
    var howManyComicPags = 0
    var totalComics = 0
    var isLoadingComics = false
    
    var CreatorOffset = 0
    var howManyCreatorPags = 0
    var totalCreator = 0
    var isLoadingCreator = false
    
    var EventsOffset = 0
    var howManyEventsPags = 0
    var totalEvents = 0
    var isLoadingEvents = false
    
    var SeriesOffset = 0
    var howManySeriesPags = 0
    var totalSeries = 0
    var isLoadingSeries = false
    
    var StoriesOffset = 0
    var howManyStoriesPags = 0
    var totalStories = 0
    var isLoadingStories = false
    
    enum Categories: String, CaseIterable {
        case chars = "CHARS"
        case comics = "COMICS"
        case creators = "CREATORS"
        case events = "EVENTS"
        case series = "SERIES"
        case stories = "STORIES"
    }
    
    
    init() {
        Categories.allCases.forEach { cat in
            cats.append(cat.rawValue.localized)
        }
        
        
        Task {
            if let res: MarvelAPIObject = Injector[\.persistence].loadFromJSONFile(fileName: "Chars", objectType: MarvelAPIObject.self) {
                if let results = res.data.results {
                    let validResults = results.compactMap { $0 }
                    chars = validResults
                }
                let page = await Injector[\.userDefaults].getPageFromUserDefaults(type: "char")
                charOffset = page.offset
                howManyCharPags = page.timesPageRequested
                totalChars = (res.data.total)!
            } else {
                if Injector[\.monitor].isConnected {
                    await fetchFirstChar()
                }
            }
            if let res: ComicAPIObject = Injector[\.persistence].loadFromJSONFile(fileName: "Comics", objectType: ComicAPIObject.self) {
                if let results = res.data.results {
                    comics = results
                }
                let page = await Injector[\.userDefaults].getPageFromUserDefaults(type: "comic")
                comicOffset = page.offset
                howManyComicPags = page.timesPageRequested
                totalComics = (res.data.total)!
            } else {
                if Injector[\.monitor].isConnected {
                    await fetchFirstComic()
                }
            }
            
            if let res: CreatorAPIObject = Injector[\.persistence].loadFromJSONFile(fileName: "Creators", objectType: CreatorAPIObject.self) {
                let results = res.data.results
                creators = results
                let page = await Injector[\.userDefaults].getPageFromUserDefaults(type: "creator")
                CreatorOffset = page.offset
                howManyCreatorPags = page.timesPageRequested
                totalCreator = res.data.total
            } else {
                if Injector[\.monitor].isConnected {
                    await fetchFirstCreator()
                }
            }
            
            if let res: EventAPIObject = Injector[\.persistence].loadFromJSONFile(fileName: "Events", objectType: EventAPIObject.self) {
                let results = res.data.results
                events = results
                let page = await Injector[\.userDefaults].getPageFromUserDefaults(type: "event")
                EventsOffset = page.offset
                howManyEventsPags = page.timesPageRequested
                totalEvents = res.data.total
            } else {
                if Injector[\.monitor].isConnected {
                    await fetchFirstEvent()
                }
            }
            
            if let res: SeriesAPIObject = Injector[\.persistence].loadFromJSONFile(fileName: "Series", objectType: SeriesAPIObject.self) {
                let results = res.data.results
                series = results
                let page = await Injector[\.userDefaults].getPageFromUserDefaults(type: "series")
                SeriesOffset = page.offset
                howManySeriesPags = page.timesPageRequested
                totalSeries = res.data.total
            } else {
                if Injector[\.monitor].isConnected {
                    await fetchFirstSeries()
                }
            }
            
            if let res: StoryAPIObject = Injector[\.persistence].loadFromJSONFile(fileName: "Stories", objectType: StoryAPIObject.self) {
                let results = res.data.results
                stories = results
                let page = await Injector[\.userDefaults].getPageFromUserDefaults(type: "story")
                StoriesOffset = page.offset
                howManyStoriesPags = page.timesPageRequested
                totalStories = res.data.total
            } else {
                if Injector[\.monitor].isConnected {
                    await fetchFirstStory()
                }
            }
            
            
        }
    }
    
    private func removeUniquesFromComics() {
        comics = Array(comics.uniqued(on: {$0.id}))
    }
    
    // MARK: - Characters
    //            if let res = try? await Injector[\.network].fetchSingleChar(url: url) {
    //                chars.append(res)
    //                if let charModel = Injector[\.persistence].loadFromJSONFile(fileName: "Chars", objectType: MarvelAPIObject.self) {
    //                    var newCharModel = charModel
    //                    newCharModel.data.results = chars
    //                    Injector[\.persistence].saveToJSONFile(object: charModel, fileName: "Chars")
    //                }
    //
    //                return res
    //            }
    //            return nil
    //        }
//    func fetchSingleChar(url: String, id: Int) async -> Result<ResultData, Error> {
//        guard let char = chars.first(where: { $0.id == id }) else {
//            do {
//                let res = try await Injector[\.network].fetchSingleChar(url: url)
//                switch res {
//                case .success(let data):
//                    print(data)
//                    return .success(data)
//                case .failure(let error):
//                    print("Error: \(error.localizedDescription)")
//                    return .failure(error)
//                }
//            } catch {
//                print("An unexpected error occurred: \(error)")
//                return .failure(error)
//            }
//        }
//        return .success(char)
//    }
    
    func fetchSingleChar(url: String, id: Int) async throws -> ResultData {
        do {
            let res = try await Injector[\.network].fetchSingleChar(url: url)
            return res
        } catch let error {
            let alertView = AlertView(showAlert: true, error: error)
//            MBKError.shared.showAlert(error: error, alert: AnyView(AlertView()))
            throw error
        }
    }

    
    func fetchCharByName(name: String) async {
        guard chars.first(where: {$0.name == name}) != nil else {
            alreadySearchedNames.append(name)
            let res = try? await Injector[\.network].fetchCharByName(name: name)
            guard let result = res?.data.results?.first else { return }
            chars.append(result!)
            if let charModel = Injector[\.persistence].loadFromJSONFile(fileName: "Chars", objectType: MarvelAPIObject.self) {
                var newCharModel = charModel
                newCharModel.data.results = chars
                Injector[\.persistence].saveToJSONFile(object: charModel, fileName: "Chars")
            }
            return
        }
        
    }
    
    func fetchFirstChar() async {
        let res = try? await Injector[\.network].fetchPaginatedChars(offset: charOffset)
        if let results = res?.data.results {
            let validResults = results.compactMap { $0 }
            chars = validResults
        }
        charOffset = ((res?.data.count)! * howManyCharPags) + 1
        howManyCharPags+=1
        totalChars = (res?.data.total)!
        Injector[\.persistence].saveToJSONFile(object: res, fileName: "Chars")
        let page = PaginationModel(offset: charOffset, count: totalChars, timesPageRequested: howManyCharPags)
        await Injector[\.userDefaults].savePageToUserDefaults(page: page, type: "char")
    }
    
    func fetchAllChars() async {
        print(charOffset)
        if !isLoadingChars {
            print("totalChars: \(totalChars)")
            print("howManyCharPags: \(howManyCharPags)")
            print("charOffset: \(charOffset)")
            if totalChars > howManyCharPags * (20) {
                isLoadingChars = true
                var res = try? await Injector[\.network].fetchPaginatedChars(offset: charOffset)
                if let results = res?.data.results {
                    let validResults = results.compactMap { $0 }
                    chars.append(contentsOf: validResults)
                }
                howManyCharPags += 1
                charOffset = ((res?.data.count)! * howManyCharPags)
                totalChars = (res?.data.total)!
                let newChars = chars
                chars = Array(newChars.uniqued(on: {$0.id}))
                res?.data.results = chars
                Injector[\.persistence].saveToJSONFile(object: res, fileName: "Chars")
                let page = PaginationModel(offset: charOffset, count: totalChars, timesPageRequested: howManyCharPags)
                await Injector[\.userDefaults].savePageToUserDefaults(page: page, type: "char")
                
                isLoadingChars = false
            }
        }
    }
    
    
    // MARK: - Comics
    func fetchSingleComic(url: String, id: Int) async -> ComicResult {
        guard let comic = comics.first(where: {$0.id == id}) else {
            let res = try? await Injector[\.network].fetchSingleComic(url: url)
            comics.append((res?.data.results?.first)!)
            removeUniquesFromComics()
            if let comicModel = Injector[\.persistence].loadFromJSONFile(fileName: "Comics", objectType: ComicAPIObject.self) {
                var newComicModel = comicModel
                newComicModel.data.results = comics
                Injector[\.persistence].saveToJSONFile(object: comicModel, fileName: "Comics")
            }
            return (res?.data.results?.first)!
        }
        return comic
    }
    
    func fetchFirstComic() async {
        let res = try? await Injector[\.network].fetchPaginatedComics(offset: 0)
        comics = (res?.data.results!)!
        comicOffset = ((res?.data.count)! * howManyComicPags) + 1
        howManyComicPags+=1
        totalComics = (res?.data.total)!
        Injector[\.persistence].saveToJSONFile(object: res, fileName: "Comics")
        let page = PaginationModel(offset: comicOffset, count: totalComics, timesPageRequested: howManyComicPags)
        await Injector[\.userDefaults].savePageToUserDefaults(page: page, type: "comic")
    }
    
    func fetchAllComics() async {
        if !isLoadingComics {
            if totalComics > howManyComicPags * (comicOffset - 1) {
                isLoadingComics = true
                let res = try? await Injector[\.network].fetchPaginatedComics(offset: comicOffset)
                if let results = res?.data.results {
                    comics.append(contentsOf: results)
                }
                howManyComicPags += 1
                comicOffset = ((res?.data.count)! * howManyComicPags)
                totalComics = (res?.data.total)!
                let newComics = comics
                comics = Array(newComics.uniqued(on: {$0.id}))
                var resToPersist = res
                resToPersist?.data.results = comics
                Injector[\.persistence].saveToJSONFile(object: resToPersist, fileName: "Comics")
                let page = PaginationModel(offset: comicOffset, count: totalComics, timesPageRequested: howManyComicPags)
                await Injector[\.userDefaults].savePageToUserDefaults(page: page, type: "comic")
                isLoadingComics = false
            }
        }
    }
    
    // MARK: - Creators
    
    func fetchSingleCreator(url: String, id: Int) async -> CreatorResult {
        guard let creator = creators.first(where: {$0.id == id}) else {
            let res = try? await Injector[\.network].fetchSingleCreator(url: url)
            let creator = (res?.data.results.first)!
            creators.append(creator)
            if let creatorModel = Injector[\.persistence].loadFromJSONFile(fileName: "Creators", objectType: CreatorAPIObject.self) {
                var newCreatorModel = creatorModel
                newCreatorModel.data.results = creators
                Injector[\.persistence].saveToJSONFile(object: creatorModel, fileName: "Creators")
            }
            return creator
        }
        return creator
    }
    
    func fetchFirstCreator() async {
        let res = try? await Injector[\.network].fetchPaginatedCreators(offset: CreatorOffset)
        creators = (res?.data.results)!
        CreatorOffset = ((res?.data.count)! * howManyCreatorPags) + 1
        howManyCreatorPags+=1
        totalCreator = (res?.data.total)!
        Injector[\.persistence].saveToJSONFile(object: res, fileName: "Creators")
        let page = PaginationModel(offset: CreatorOffset, count: totalCreator, timesPageRequested: howManyCreatorPags)
        await Injector[\.userDefaults].savePageToUserDefaults(page: page, type: "creator")
    }
    
    func fetchAllCreators() async {
        if !isLoadingCreator {
            if totalCreator > howManyCreatorPags * (CreatorOffset - 1) {
                isLoadingCreator = true
                let res = try? await Injector[\.network].fetchPaginatedCreators(offset: CreatorOffset)
                if let results = res?.data.results {
                    creators.append(contentsOf: results)
                }
                howManyCreatorPags += 1
                CreatorOffset = ((res?.data.count)! * howManyCreatorPags)
                totalCreator = (res?.data.total)!
                let newCreators = creators
                creators = Array(newCreators.uniqued(on: {$0.id}))
                var resToPersist = res
                resToPersist?.data.results = creators
                Injector[\.persistence].saveToJSONFile(object: res, fileName: "Creators")
                let page = PaginationModel(offset: CreatorOffset, count: totalCreator, timesPageRequested: howManyCreatorPags)
                await Injector[\.userDefaults].savePageToUserDefaults(page: page, type: "creator")
                isLoadingCreator = false
            }
        }
    }
    
    // MARK: - Events
    
    func fetchSingleEvent(url: String, id: Int) async -> EventResult {
        guard let event = events.first(where: {$0.id == id}) else {
            let res = try? await Injector[\.network].fetchSingleEvent(url: url)
            let event = (res?.data.results.first)!
            events.append(event)
            if let eventModel = Injector[\.persistence].loadFromJSONFile(fileName: "Events", objectType: EventAPIObject.self) {
                var newEventModel = eventModel
                newEventModel.data.results = events
                Injector[\.persistence].saveToJSONFile(object: eventModel, fileName: "Events")
            }
            return event
        }
        return event
    }
    
    func fetchFirstEvent() async {
        let res = try? await Injector[\.network].fetchPaginatedEvents(offset: EventsOffset)
        events = (res?.data.results)!
        EventsOffset = ((res?.data.count)! * howManyEventsPags) + 1
        howManyEventsPags+=1
        totalEvents = (res?.data.total)!
        Injector[\.persistence].saveToJSONFile(object: res, fileName: "Events")
        let page = PaginationModel(offset: EventsOffset, count: totalEvents, timesPageRequested: howManyEventsPags)
        await Injector[\.userDefaults].savePageToUserDefaults(page: page, type: "event")
    }
    
    func fetchAllEvents() async {
        if !isLoadingEvents {
            if totalEvents > howManyEventsPags * (EventsOffset - 1) {
                isLoadingEvents = true
                let res = try? await Injector[\.network].fetchPaginatedEvents(offset: EventsOffset)
                if let results = res?.data.results {
                    events.append(contentsOf: results)
                }
                howManyEventsPags += 1
                EventsOffset = ((res?.data.count)! * howManyEventsPags)
                totalEvents = (res?.data.total)!
                let newEvents = events
                events = Array(newEvents.uniqued(on: {$0.id}))
                var resToPersist = res
                resToPersist?.data.results = events
                Injector[\.persistence].saveToJSONFile(object: resToPersist, fileName: "Events")
                let page = PaginationModel(offset: EventsOffset, count: totalEvents, timesPageRequested: howManyEventsPags)
                await Injector[\.userDefaults].savePageToUserDefaults(page: page, type: "event")
                isLoadingEvents = false
            }
        }
    }
    
    // Mark: - Series
    
    func fetchSingleSeries(url: String, id: Int) async -> SeriesResult {
        guard let series = series.first(where: {$0.id == id}) else {
            let res = try? await Injector[\.network].fetchSingleSeries(url: url)
            let series = (res?.data.results.first)!
            self.series.append(series)
            if let seriesModel = Injector[\.persistence].loadFromJSONFile(fileName: "Series", objectType: SeriesAPIObject.self) {
                var newSeriesModel = seriesModel
                newSeriesModel.data.results = self.series
                Injector[\.persistence].saveToJSONFile(object: seriesModel, fileName: "Series")
            }
            return series
        }
        return series
    }
    
    func fetchFirstSeries() async {
        let res = try? await Injector[\.network].fetchPaginatedSeries(offset: SeriesOffset)
        series = (res?.data.results)!
        SeriesOffset = ((res?.data.count)! * howManySeriesPags) + 1
        howManySeriesPags+=1
        totalSeries = (res?.data.total)!
        Injector[\.persistence].saveToJSONFile(object: res, fileName: "Series")
        let page = PaginationModel(offset: SeriesOffset, count: totalSeries, timesPageRequested: howManySeriesPags)
        await Injector[\.userDefaults].savePageToUserDefaults(page: page, type: "series")
    }
    
    func fetchAllSeries() async {
        if !isLoadingSeries {
            if totalSeries > howManySeriesPags * (SeriesOffset - 1) {
                isLoadingSeries = true
                let res = try? await Injector[\.network].fetchPaginatedSeries(offset: SeriesOffset)
                if let results = res?.data.results {
                    series.append(contentsOf: results)
                }
                howManySeriesPags += 1
                SeriesOffset = ((res?.data.count)! * howManySeriesPags)
                totalSeries = (res?.data.total)!
                let newSeries = series
                series = Array(newSeries.uniqued(on: {$0.id}))
                var resToPersist = res
                resToPersist?.data.results = series
                Injector[\.persistence].saveToJSONFile(object: resToPersist, fileName: "Series")
                let page = PaginationModel(offset: SeriesOffset, count: totalSeries, timesPageRequested: howManySeriesPags)
                await Injector[\.userDefaults].savePageToUserDefaults(page: page, type: "series")
                isLoadingSeries = false
            }
        }
    }
    
    // MARK: - Stories
    
    func fetchSingleStory(url: String, id: Int) async -> StoryResult {
        guard let story = stories.first(where: {$0.id == id}) else {
            let res = try? await Injector[\.network].fetchSingleStory(url: url)
            let story = (res?.data.results.first)!
            stories.append(story)
            if let storyModel = Injector[\.persistence].loadFromJSONFile(fileName: "Stories", objectType: StoryAPIObject.self) {
                var newStoryModel = storyModel
                newStoryModel.data.results = stories
                Injector[\.persistence].saveToJSONFile(object: storyModel, fileName: "Stories")
            }
            return story
        }
        return story
    }
    
    func fetchFirstStory() async {
        let res = try? await Injector[\.network].fetchPaginatedStories(offset: StoriesOffset)
        stories = (res?.data.results)!
        StoriesOffset = ((res?.data.count)! * howManyStoriesPags) + 1
        howManyStoriesPags+=1
        totalStories = (res?.data.total)!
        Injector[\.persistence].saveToJSONFile(object: res, fileName: "Stories")
        let page = PaginationModel(offset: StoriesOffset, count: totalStories, timesPageRequested: howManyStoriesPags)
        await Injector[\.userDefaults].savePageToUserDefaults(page: page, type: "story")
    }
    
    func fetchAllStories() async {
        if !isLoadingStories {
            if totalStories > howManyStoriesPags * (StoriesOffset - 1) {
                isLoadingStories = true
                let res = try? await Injector[\.network].fetchPaginatedStories(offset: StoriesOffset)
                if let results = res?.data.results {
                    stories.append(contentsOf: results)
                }
                howManyStoriesPags += 1
                StoriesOffset = ((res?.data.count)! * howManyStoriesPags)
                totalStories = (res?.data.total)!
                let newStories = stories
                stories = Array(newStories.uniqued(on: {$0.id}))
                var resToPersist = res
                resToPersist?.data.results = stories
                Injector[\.persistence].saveToJSONFile(object: resToPersist, fileName: "Stories")
                let page = PaginationModel(offset: StoriesOffset, count: totalStories, timesPageRequested: howManyStoriesPags)
                await Injector[\.userDefaults].savePageToUserDefaults(page: page, type: "story")
                isLoadingStories = false
            }
        }
    }
    
    
    func setCurrentSelectedCat(string: String) {
        switch string {
        case Categories.chars.rawValue.localized:
            currentSelectedCategory = .chars
        case Categories.comics.rawValue.localized:
            currentSelectedCategory = .comics
        case Categories.creators.rawValue.localized:
            currentSelectedCategory = .creators
        case Categories.events.rawValue.localized:
            currentSelectedCategory = .events
        case Categories.series.rawValue.localized:
            currentSelectedCategory = .series
        case Categories.stories.rawValue.localized:
            currentSelectedCategory = .stories
        default:
            currentSelectedCategory = .chars
        }
    }
    
}
