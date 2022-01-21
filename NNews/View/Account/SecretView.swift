//
//  SecretView.swift
//  NNews
//
//  Created by Никита Ходарёнок on 17.01.22.
//

import SwiftUI


struct SecretView: View {
    
//    @AppStorage("APIKey") var APIKey = "39b2bb9626224f81839de256103cf2ae"
//    @AppStorage("baseAPI") var baseAPI = "https://newsapi.org/v2/"
//    @AppStorage("everything") var everything = "everything"
//    @AppStorage("topHeadlines") var topHeadlines = "top-headlines"
//    @AppStorage("souces") var souce = "sources"
    
    @State var apiKey: String = ""
    @State var based: String = ""
    @State var everythigPart: String = ""
    @State var topheadlinesPart: String = ""
    @State var soucePart: String = ""
    
    @EnvironmentObject var APIDataStore: APIDataStoreModel
    
    @State var defaultAPI = APIModel()
    
    var body: some View {
        
//        var apiSaved = self.apiSaved
        
        List{
            VStack{
                VStack{
                    Text("In process API Key: ")
                    Text("\(APIDataStore.APIBased.APIKey)")
                        .multilineTextAlignment(.trailing)
                    TextField("New API key", text: $apiKey)
                        .textFieldStyle(.roundedBorder)
                }
                .padding(.bottom)
                
                VStack{
                    Text("Now use base part API: ")
                    Text("\(APIDataStore.APIBased.baseAPI)")
                    TextField("Base API", text: $based)
                        .textFieldStyle(.roundedBorder)
                }
                .padding(.bottom)

                VStack{
                    Text("Part for getting everything news: ")
                    Text("\(APIDataStore.APIBased.everything)")
                    TextField("Everything news", text: $everythigPart)
                        .textFieldStyle(.roundedBorder)
                }
                .padding(.bottom)

                VStack{
                    Text("Part for getting top headlines news: ")
                    Text("\(APIDataStore.APIBased.topHeadlines)")
                    TextField("Top Headlines news", text: $topheadlinesPart)
                        .textFieldStyle(.roundedBorder)
                }
                .padding(.bottom)
                
                VStack{
                    Text("Part for getting sources: ")
                    Text("\(APIDataStore.APIBased.source)")
                    TextField("News Sources", text: $soucePart)
                        .textFieldStyle(.roundedBorder)
                }
                .padding(.bottom)
                
                Button(action: {
                    withAnimation(.easeInOut){
                        APIDataStore.APIBased.APIKey = apiKey
                        APIDataStore.APIBased.baseAPI = based
                        APIDataStore.APIBased.everything = everythigPart
                        APIDataStore.APIBased.topHeadlines = topheadlinesPart
                        APIDataStore.APIBased.source = soucePart
                        APIDataStore.APIDataUpdated()
                    }
                }, label: {
                    Text("Save")
                })
                .buttonStyle(RoundedCorners(color: Color.red))
                .padding(.vertical)
                
                Button(action: {
                    withAnimation(.easeInOut){
                        APIDataStore.APIBased.APIKey = defaultAPI.APIKey
                        APIDataStore.APIBased.baseAPI = defaultAPI.baseAPI
                        APIDataStore.APIBased.everything = defaultAPI.everything
                        APIDataStore.APIBased.topHeadlines = "top-headlines"
                        APIDataStore.APIBased.source = defaultAPI.source
                        APIDataStore.APIDataUpdated()
                    }
                }, label: {
                    Text("Back to default")
                })
                .buttonStyle(RoundedCorners(color: Color.black))
            }
            .navigationTitle("Bebug menu")
        }
    }
    
//    private var apiSaved: APIModel {
//        return APIDataStore.APIBased
//    }
}

struct SecretView_Previews: PreviewProvider {
    @StateObject static var APIDataStore = APIDataStoreModel.shared
    static var previews: some View {
        SecretView()
            .environmentObject(APIDataStore)
    }
}
