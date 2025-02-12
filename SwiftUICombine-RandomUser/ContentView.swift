//
//  ContentView.swift
//  SwiftUICombine-RandomUser
//
//  Created by 黃柏嘉 on 2025/02/11.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel: ViewModel = ViewModel(apiService: APIService(), downloader: ImageDownloader())
    
    var body: some View {
        NavigationView {
            Form {
                HStack {
                    Spacer()
                    
                    Image(uiImage: viewModel.image ?? viewModel.defaultImage)
                        .resizable()
                        .aspectRatio(1.0, contentMode: .fit)
                        .frame(width: 200)
                        .clipShape(.buttonBorder)
                    
                    Spacer()
                }
                .listRowBackground(Color.clear)
               
                            
                Section("個人資料") {
                    Text("性別: \(viewModel.gender)")
                    
                    Text("姓名: \(viewModel.name)")
                    
                    Text("信箱: \(viewModel.email)")
                }
                
                Section("登入資訊") {
                    Text("帳號: \(viewModel.userName)")
                    
                    Text("密碼: \(viewModel.password)")
                }
            }
            .navigationTitle("隨機使用者")
            .toolbar(content: {
                Button {
                    
                    viewModel.fetch()
                    
                } label: {
                    Image(systemName: "arrow.clockwise")
                }
            })
        }
    }
}

#Preview {
    ContentView()
}
