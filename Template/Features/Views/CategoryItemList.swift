//
//  CategoryItemList.swift
//  Dev
//
//  Created by Martin Kock on 31/03/2024.
//

import SwiftUI

struct CategoryItemList: View {
    @State private var searchText = ""
    @State private var scrollToTop = false
    @State private var isSearching = false
    
    var stateController = Injector[\.state]
    
    var chars: [ResultData] {
        if searchText.isEmpty {
            return stateController.chars
        } else {
            let arr = stateController.chars.filter({($0.name?.contains(searchText))!})
            if Injector[\.monitor].isConnected {
                if arr.count < 3 && searchText.count > 2 {
                    if !stateController.alreadySearchedNames.contains(searchText) {
                        Task {
                            await stateController.fetchCharByName(name: searchText)
                        }
                    }
                }
            }
            return arr
        }
    }
    var comics: [ComicResult] {
        if searchText.isEmpty {
            return stateController.comics
        } else {
            return stateController.comics.filter({($0.title?.contains(searchText))!})
        }
    }
    var creators: [CreatorResult] {
        if searchText.isEmpty {
            return stateController.creators
        } else {
            return stateController.creators.filter({$0.fullName.contains(searchText)})
        }
    }
    var events: [EventResult] {
        if searchText.isEmpty {
            return stateController.events
        } else {
            return stateController.events.filter({$0.title!.contains(searchText)})
        }
    }
    var stories: [StoryResult] {
        if searchText.isEmpty {
            return stateController.stories
        } else {
            return stateController.stories.filter({$0.title!.contains(searchText)})
        }
    }
    var series: [SeriesResult] {
        if searchText.isEmpty {
            return stateController.series
        } else {
            return stateController.series.filter({$0.title.contains(searchText)})
        }
    }
    
    var category = "CHAR".localized
    var body: some View {
        NavigationStack {
            ZStack {
                ScrollViewReader { proxy in
                    List {
                        EmptyView()
                            .frame(height: 0)
                            .listRowBackground(Color.clear)
                            .id(0)
                        switch stateController.currentSelectedCategory {
                        case .chars:
                            ForEach(chars.filter { searchText.isEmpty || $0.name?.contains(searchText) ?? false }) { char in
                                NavigationLink(destination: CharDetail(char: char)) {
                                    Text(char.name ?? "bob")
                                        .onAppear {
                                            if char == chars.last {
                                                paginate()
                                            }
                                        }
                                }
                                .listRowBackground(Color.clear)
                            }
                        case .comics:
                            ForEach(comics) { comic in
                                NavigationLink(destination: ComicsDetail(comic: comic)) {
                                    Text(comic.title ?? "")
                                        .onAppear {
                                            if comic.id == comics.last?.id {
                                                paginate()
                                            }
                                        }
                                }
                                .listRowBackground(Color.clear)
                            }
                        case .creators:
                            ForEach(creators) { creator in
                                NavigationLink {
                                    CreatorDetail(creator: creator)
                                } label: {
                                    Text(creator.fullName)
                                        .onAppear {
                                            if creator.id == creators.last?.id {
                                                paginate()
                                            }
                                        }
                                    
                                }
                                .listRowBackground(Color.clear)
                            }
                        case .events:
                            ForEach(events) { event in
                                NavigationLink {
                                    EventsDetail(event: event)
                                } label: {
                                    Text(event.title ?? "Title")
                                        .onAppear {
                                            if event.id == events.last?.id {
                                                paginate()
                                            }
                                        }
                                }
                                .listRowBackground(Color.clear)
                            }
                        case .stories:
                            ForEach(stories) { story in
                                NavigationLink {
                                    StoryDetail(story: story)
                                } label: {
                                    Text(story.title ?? "Title")
                                        .onAppear {
                                            if story.id == stories
                                                .last?.id {
                                                paginate()
                                            }
                                        }
                                }
                                .listRowBackground(Color.clear)
                            }
                        case .series:
                            ForEach(series) { serie in
                                NavigationLink {
                                    SeriesDetail(series: serie)
                                } label: {
                                    Text(serie.title)
                                        .onAppear {
                                            if serie.id == series.last?.id {
                                                paginate()
                                            }
                                        }
                                }
                                .listRowBackground(Color.clear)
                            }
                        }
                    }
                    .searchable(text: $searchText, isPresented: $isSearching)
                    .listStyle(.plain)
                    .scrollIndicators(.hidden)
                    .scrollContentBackground(.hidden)
                    .background(Consts.Colors.backgroundPrimary)
                    .onAppear {
                        stateController.setCurrentSelectedCat(string: category)
                    }
                    .onChange(of: scrollToTop) {
                        withAnimation {
                            proxy.scrollTo(0, anchor: .top)
                        }
                        
                    }
                }
                .navigationTitle(category)
                .toolbar {
                    // search
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            isSearching.toggle()
                        }) {
                            Image(systemName: "magnifyingglass")
                        }
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(action: {
                            withAnimation {
                                scrollToTop.toggle()
                            }
                        }) {
                            Image(systemName: "arrow.up")
                        }
                    }
                }
            }
        }
    }
}

// MARK: - View
extension CategoryItemList {
    @ViewBuilder
    func genericContentList<T: Identifiable, DetailView: View>(
        items: [T],
        displayText: @escaping (T) -> String,
        detailViewBuilder: @escaping (T) -> DetailView,
        isLastItem: @escaping (T, [T]) -> Bool
    ) -> some View {
        ForEach(items) { item in
            NavigationLink(destination: detailViewBuilder(item)) {
                Text(displayText(item))
                    .onAppear {
                        if isLastItem(item, items) {
                            paginate()
                        }
                    }
            }
            .listRowBackground(Color.clear)
        }
    }
}

// MARK: - Private functions
extension CategoryItemList {
    private func paginate() {
        switch stateController.currentSelectedCategory {
        case .chars:
            if !stateController.isLoadingChars && chars.count > 10 {
                loadChars()
            }
        case .comics:
            if !stateController.isLoadingComics {
                loadComics()
            }
        case .creators:
            if !stateController.isLoadingCreator {
                loadCreators()
            }
        case .events:
            if !stateController.isLoadingEvents {
                loadEvents()
            }
        case .stories:
            if !stateController.isLoadingStories {
                loadStories()
            }
        case .series:
            if !stateController.isLoadingSeries {
                loadSeries()
            }
        }
    }
    
    private func loadChars() {
        if Injector[\.monitor].isConnected {
            Task {
                await stateController.fetchAllChars()
            }
        }
    }
    private func loadComics() {
        if Injector[\.monitor].isConnected {
            Task {
                await stateController.fetchAllComics()
            }
        }
    }
    private func loadCreators() {
        if Injector[\.monitor].isConnected {
            Task {
                await stateController.fetchAllCreators()
            }
        }
    }
    private func loadEvents() {
        if Injector[\.monitor].isConnected {
            Task {
                await stateController.fetchAllEvents()
            }
        }
    }
    private func loadStories() {
        if Injector[\.monitor].isConnected {
            Task {
                await stateController.fetchAllStories()
            }
        }
    }
    private func loadSeries() {
        if Injector[\.monitor].isConnected {
            Task {
                await stateController.fetchAllSeries()
            }
        }
    }
}

#Preview {
    CategoryItemList()

}
