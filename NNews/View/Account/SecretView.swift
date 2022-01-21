//
//  SecretView.swift
//  NNews
//
//  Created by Никита Ходарёнок on 17.01.22.
//

import SwiftUI


struct SecretView: View {
    
    @AppStorage("APIKey") var APIKey = "39b2bb9626224f81839de256103cf2ae"
    @AppStorage("baseAPI") var baseAPI = "https://newsapi.org/v2/"
    @AppStorage("everything") var everything = "everything"
    @AppStorage("topHeadlines") var topHeadlines = "top-headlines"
    @AppStorage("souces") var souce = "sources"
    
    @State var apiKey: String = ""
    @State var based: String = ""
    @State var everythigPart: String = ""
    @State var topheadlinesPart: String = ""
    @State var soucePart: String = ""
    
    @State var defaultAPI = APIModel()
    
    var body: some View {
        List{
            VStack{
                VStack{
                    Text("In process API Key: ")
                    Text("\(APIKey)")
                        .multilineTextAlignment(.trailing)
                    TextField("New API key", text: $apiKey)
                        .textFieldStyle(.roundedBorder)
                }
                .padding(.bottom)
                
                VStack{
                    Text("Now use base part API: ")
                    Text("\(baseAPI)")
                    TextField("Base API", text: $based)
                        .textFieldStyle(.roundedBorder)
                }
                .padding(.bottom)

                VStack{
                    Text("Part for getting everything news: ")
                    Text("\(everything)")
                    TextField("Everything news", text: $everythigPart)
                        .textFieldStyle(.roundedBorder)
                }
                .padding(.bottom)

                VStack{
                    Text("Part for getting top headlines news: ")
                    Text("\(topHeadlines)")
                    TextField("Top Headlines news", text: $topheadlinesPart)
                        .textFieldStyle(.roundedBorder)
                }
                .padding(.bottom)
                
                VStack{
                    Text("Part for getting sources: ")
                    Text("\(souce)")
                    TextField("News Sources", text: $soucePart)
                        .textFieldStyle(.roundedBorder)
                }
                .padding(.bottom)
                
                Button(action: {
                    withAnimation(.easeInOut){
                        APIKey = apiKey
                        baseAPI = based
                        everything = everythigPart
                        topHeadlines = topheadlinesPart
                        souce = soucePart
                    }
                }, label: {
                    Text("Save")
                })
                .buttonStyle(RoundedCorners(color: Color.red))
                .padding(.vertical)
                
                Button(action: {
                    withAnimation(.easeInOut){
                        APIKey = defaultAPI.APIKey
                        baseAPI = defaultAPI.baseAPI
                        everything = defaultAPI.everything
                        topHeadlines = defaultAPI.topHeadlines
                        souce = defaultAPI.souce
                    }
                }, label: {
                    Text("Back to default")
                })
                .buttonStyle(RoundedCorners(color: Color.black))
            }
            .navigationTitle("Bebug menu")
        }
    }
}

struct SecretView_Previews: PreviewProvider {
    static var previews: some View {
        SecretView()
    }
}
