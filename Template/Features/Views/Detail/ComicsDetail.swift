//
//  ComicsDetail.swift
//  Dev
//
//  Created by Martin Kock on 02/04/2024.
//

import SwiftUI

struct ComicsDetail: View {
    var stateController = Injector[\.state]
    @State var comic: ComicResult?
    var comicUrl: String = ""
    var chars: [Series] {
        if let chars = comic?.characters?.items {
            return chars
        } else {
            return []
        }
    }
    var body: some View {
        VStack {
            if comic != nil {
                VStack {
                    List {
                        Group {
                            AsyncImageView(urlString:"\(comic?.thumbnail?.path ?? "")/standard_xlarge.jpg")
                            Text(comic?.textObjects?.first??.text ?? "NODESCRIPTION".localized)
                                .multilineTextAlignment(.center)
                                .font(.headline)
                                .padding(.horizontal)
                        }
                        .listRowSeparator(.hidden)
                        .listRowBackground(Color.clear)
                        
                        
                        ForEach(chars, id: \.self) { char in
                            NavigationLink {
                                CharDetail(charUrl: char.resourceURI)
                            } label: {
                                Text(char.name)
                                    .padding(.horizontal)
                            }
                            .listRowBackground(Color.clear)
                        }
                        
                    }
                    .listStyle(.plain)
                    .scrollIndicators(.hidden)
                    .padding(.horizontal, -16)
                    
                    .scrollContentBackground(.hidden)
                    .background(Consts.Colors.backgroundPrimary)
                    
                }
            } else if !Injector[\.monitor].isConnected {
                Text("NOCON".localized)
            } else {
                ProgressView()
            }
        }
        .onAppear(perform: {
            Task {
                if comic == nil {
                    let id = extractLastPathComponentAsInt(from: comicUrl)
                    if let comicToReturn = stateController.comics.first(where: {$0.id == id}) {
                        comic = comicToReturn
                    } else {
                        if Injector[\.monitor].isConnected {
                            comic = await stateController.fetchSingleComic(url: comicUrl, id: id!)
                        }
                    }
                }
            }
        })
        .navigationTitle(comic?.title ?? "UNKNOWNTITLE".localized)
    }
    func extractLastPathComponentAsInt(from url: String) -> Int? {
        guard let lastSlashRange = url.range(of: "/", options: .backwards) else {
            return nil
        }
        
        let startIndex = url.index(lastSlashRange.upperBound, offsetBy: 0)
        let endIndex = url.endIndex
        
        let substring = url[startIndex..<endIndex]
        
        return Int(substring)
    }
}
