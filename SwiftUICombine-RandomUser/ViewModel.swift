//
//  ViewModel.swift
//  SwiftUICombine-RandomUser
//
//  Created by 黃柏嘉 on 2025/02/11.
//

import Foundation
import Combine
import UIKit

class ViewModel: ObservableObject {
    
    private var apiService: APIService
    private var downloader: ImageDownloader
    private var cancellables = Set<AnyCancellable>()
    
    @Published private(set) var gender: String = ""
    @Published private(set) var name: String = ""
    @Published private(set) var email: String = ""
    @Published private(set) var userName: String = ""
    @Published private(set) var password: String = ""
    @Published private(set) var image: UIImage?
    
    let defaultImage = UIImage(systemName: "person.circle.fill") ?? UIImage()
    let apiError = PassthroughSubject<String, Never>()
    
    init(apiService: APIService, downloader: ImageDownloader) {
        self.apiService = apiService
        self.downloader = downloader
        
        fetch()
    }
    
    func fetch() {
        apiService.fetchData(RandomUser.self, .RandomUser)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] result in
                switch result {
                case .finished :
                    print("成功")
                    
                case .failure(let error):
                    print("失敗 \(error.description)")
                    self?.apiError.send(error.description)
                }
            } receiveValue: { [weak self] user in
                guard let result = user.results.first else { return }
                
                if let userPic = result.picture?.large {
                    self?.downloadImage(userPic)
                }
                
                self?.gender = result.genderType.rawValue
                self?.name = result.fullName
                self?.email = result.email
                
                guard let login = result.login else { return }
                self?.userName = login.username
                self?.password = login.password
            }
            .store(in: &cancellables)
    }
    
    private func downloadImage(_ url: String) {
        downloader.downloadImage(url)
            .receive(on: DispatchQueue.main)
            .sink { result in
                switch result {
                case .finished:
                    print("圖片下載成功！")
                case .failure(_):
                    print("圖片下載失敗！")
                }
            } receiveValue: { [weak self] image in
                guard let image = image else { return }
                self?.image = image
            }
            .store(in: &cancellables)
    }
}
