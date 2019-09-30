//
//  TweetsViewModel.swift
//  Moments
//
//  Created by NAVER on 2019/9/26.
//  Copyright © 2019 Bill. All rights reserved.
//

import Foundation
import RxSwift
import URLNavigator
import RxDataSources

typealias MHTweetCellDataType = SectionModel<String, MHTweetCellModel>

class MHTweetsViewModel {
    private let sceneCoordinator: NavigatorType
    private var tweets = [MHTweetCellDataType]()
    private var tweetIndex = 0
    private let disposeBag = DisposeBag()
    let tweetsSubject = PublishSubject<[MHTweetCellDataType]>()
    
    init(coordinator: NavigatorType) {
        self.sceneCoordinator = coordinator
    }
    
    func doLogin() -> Observable<MHUserInfoModel> {
        return Observable.create({observer -> Disposable in
            MHNetWorkManager.shared.sendRequest(provider: TWApiProvider,
                                          target: TWAPI.login)
            .subscribe(onNext: {[weak self] response in
                guard let self = self else {return}
                do {
                    let object = try JSONDecoder().decode(MHUserInfoModel.self, from: response.data)
                    observer.onNext(object)
                    self.getTweets()
                } catch  {
                    observer.onError(error)
                }
            },
                       onError: {error in
                        observer.onError(error)
                })
        })
        
    }
    
    func showUserPage(_ model: MHTweetModel.User) {
        sceneCoordinator.push("moments://user", context: model, from: nil, animated: true)
    }
    
    func reloadTweets() {
        tweetIndex = 0
        fetchMoreTweets()
    }
    
    /// load next page tweets
    /// return: whether tweets are all loaded
    @discardableResult
    func fetchMoreTweets() -> Bool {
        if tweetIndex < tweets.count {
            let finalIndex = min(tweetIndex + MHTweetStatics.tweetsCountInOnePage, tweets.count)
            let newPageTweets = Array(tweets[0 ..< finalIndex])
            tweetsSubject.onNext(newPageTweets)
            tweetIndex = finalIndex
        }
        return tweetIndex >= tweets.count
    }
    
    //MARK: Private Methods
    private func getTweets() {
        
            MHNetWorkManager.shared.sendRequest(provider: TWApiProvider,
                                          target: TWAPI.tweets)
            .subscribe(onNext: {[weak self] response in
                guard let self = self else {return}
                do {
                    let object = try JSONDecoder().decode([MHTweetModel].self, from: response.data)
                    //每一个tweet必须有发送人和图片
                    let tweets = object.filter{$0.sender != nil && ($0.images != nil || $0.content != nil)}
                    self.tweets = self.convertTableDataSource(tweets: tweets)
//                    self.tweetsSubject.onNext(self.tweets)
                    self.fetchMoreTweets()
                } catch  {
                    print(error)
                }
            },
                       onError: {error in
                        print(error)
                }).disposed(by: disposeBag)
        
    }
    
    private func convertTableDataSource(tweets: [MHTweetModel]) -> [MHTweetCellDataType] {
        var array = [MHTweetCellDataType]()
        
        for tweet in tweets {
            var items = [MHTweetCellModel]()
            items.append(.sender(tweet))
            if let images = tweet.images {
                if images.count == 1 {
                    items.append(.singleImage(tweet.images![0]))
                }else{
                    items.append(.multipleImage(tweet.images!))
                }
            }
            if let comments = tweet.comments {
                comments.forEach{comment in
                    items.append(.comment(comment))
                }
            }
            items.append(.bottomLine)
            
            let section = SectionModel(model: tweet.sender!.username, items: items)
            array.append(section)
        }
        
        return array
    }
}


enum MHTweetCellModel {
    case sender(MHTweetModel)
    case singleImage(MHTweetModel.Image)
    case multipleImage([MHTweetModel.Image])
    case comment(MHTweetModel.Comment)
    case bottomLine
}
