//
//  CharDetail.swift
//  Dev
//
//  Created by Martin Kock on 01/04/2024.
//

import SwiftUI
//import MBKError

struct CharDetail: View {
    var stateController = Injector[\.state]
    @State var char: ResultData?
    var charUrl: String = ""
    var comics: [ComicsItem]  {
        return char?.comics.items ?? []
        
    }
    var body: some View {
        List {
            Group {
                AsyncImageView(urlString:"\(char?.thumbnail?.path ?? "")/standard_xlarge.jpg")
                VStack {
                    HStack {
                        Spacer()
                        Text("\(char?.comics.available ?? 0)")
                        Spacer()
                    }
                    Text(char?.description ?? "")
                        .multilineTextAlignment(.leading)
                }
            }
            .listRowSeparator(.hidden)
            .listRowBackground(Color.clear)
            Group {
                ForEach(comics, id: \.self) { comic in
                    NavigationLink {
                        ComicsDetail(comicUrl: comic.resourceURI)
                    } label: {
                        Text(comic.name)
                            .frame(alignment: .leading)
                    }
                }
            }
            .listRowSeparator(.visible)
            .listRowBackground(Color.clear)
            .padding(.horizontal)
          
            
        }
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
        .background(Consts.Colors.backgroundPrimary)
        .toolbar(.visible, for: .navigationBar)
        .toolbarBackground(.ultraThinMaterial, for: .navigationBar)
        .navigationTitle(char?.name ?? "UKNOWNCHAR".localized)
        .padding(.horizontal, -16)
        .onAppear {
            Task {
                if char == nil {
                    let id = extractLastPathComponentAsInt(from: charUrl)
                    if let charToReturn = stateController.chars.first(where: {$0.id == id}) {
                        char = charToReturn
                    } else {
                        if Injector[\.monitor].isConnected {
                            let res = try await stateController.fetchSingleChar(url: charUrl, id: id!)
                            if res != nil {
                                char = res
                            }
//                            switch res {
//                            case .success(let character):
//                                char = character
//                            case .failure(let error):
////                                MBKError.shared.showAlert(error: error)
//                                print()
//                            }
                        }
                    }
                }
            } 
        }
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
