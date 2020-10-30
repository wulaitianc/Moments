//
//  ViewController.swift
//  Moments
//
//  Created by NAVER on 2019/9/21.
//  Copyright © 2019 Bill. All rights reserved.
//

import UIKit
import FakeFisher
import RxSwift
import RxCocoa
import RxDataSources
import MJRefresh

class MHTweetsViewController: UIViewController {
    var viewModel: MHTweetsViewModel!
    private let disposeBag = DisposeBag()
    private var dataSource: RxTableViewSectionedReloadDataSource<MHTweetCellDataType> {
        return RxTableViewSectionedReloadDataSource<MHTweetCellDataType>(configureCell: {dataSource, table, indexPath, item in
        switch item {
        case .sender(let tweet):
            return self.makeSenderCell(with: tweet,
                                       from: table,
                                       indexPath: indexPath)
        case .singleImage(let image):
            return self.makeSingleImageCell(with: image,
                                            from: table,
                                            indexPath: indexPath)
        case .multipleImage(let images):
            return self.makeMultipleImageCell(with: images,
                                              from: table,
                                              indexPath: indexPath)
        case .comment(let comment):
            return self.makeCommentImageCell(with: comment,
                                             from: table,
                                             indexPath: indexPath)
        case .bottomLine:
            return self.makeBottomLineImageCell(from: table,
                                                indexPath: indexPath)
        }
    })
    }

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var headerView: UIView!
    @IBOutlet weak var tableHeaderBackgroundImageView: UIImageView!
    @IBOutlet weak var tableHeaderAvatar: UIImageView!
    @IBOutlet weak var tableHeaderUsernameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        configTableView()
        getTweets()
        doLogin()        
    }

    func doLogin() {
        showLoading()
        viewModel
            .doLogin()
            .subscribe(onNext: {[weak self] userModel in
                guard let self = self else {return}
                self.hideLoading()
                self.tableView.tableHeaderView = self.headerView
                self.tableHeaderBackgroundImageView.ff.setImage(urlString: userModel.profile_image, placeholder: MHDefaultImage.placeholder)
                self.tableHeaderAvatar.ff.setImage(urlString: userModel.avatar, placeholder: MHDefaultImage.placeholder)
                self.tableHeaderUsernameLabel.text = userModel.username
                self.updateHeaderView(width: self.view.frame.width)
        },
                       onError: {[weak self] error in
                        guard let self = self else {return}
                        self.hideLoading()
                        self.showMessage(error.localizedDescription)
            })
            .disposed(by: disposeBag)
    }
    
    func getTweets() {
        viewModel
            .tweetsSubject
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
    
    
    
    //MARK: orietation change
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        let width = view.frame.height
        updateHeaderView(width: width)
        
    }
    
    //MARK: update UI
    func updateHeaderView(width: CGFloat) {
        headerView.frame.size.height = MHDefaultRatio.tweetsBackground * width + 34
    }
    
    func configTableView() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 20
        
        tableView.mj_header = MJRefreshNormalHeader{[weak self] in
            guard let self = self else {return}
            self.viewModel.reloadTweets()
            self.tableView.mj_header.endRefreshing()
            self.tableView.mj_footer.endRefreshing()
        }
        
        tableView.mj_footer = MJRefreshAutoNormalFooter{[weak self] in
            guard let self = self else {return}
            DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                let isAllLoaded = self.viewModel.fetchMoreTweets()
                if isAllLoaded {
                    self.tableView.mj_footer.endRefreshingWithNoMoreData()
                }else{
                    self.tableView.mj_footer.endRefreshing()
                }
            }
        }
    }
    
}

extension MHTweetsViewController{
    func makeSenderCell(with model: MHTweetModel, from tableView: UITableView, indexPath: IndexPath) -> MHTweetContentCellTableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MHTweetContentCellTableViewCell", for: indexPath) as! MHTweetContentCellTableViewCell
        cell.bindData(model, delegate: self)
        return cell
    }
    
    func makeSingleImageCell(with model: MHTweetModel.Image, from tableView: UITableView, indexPath: IndexPath) -> MHTweetSingleImageCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MHTweetSingleImageCell", for: indexPath) as! MHTweetSingleImageCell
        cell.bindData(model)
        return cell
    }
    
    func makeMultipleImageCell(with model: [MHTweetModel.Image], from tableView: UITableView, indexPath: IndexPath) -> MHTweetMultipleImageCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MHTweetMultipleImageCell", for: indexPath) as! MHTweetMultipleImageCell
        cell.bindData(model)
        return cell
    }

    func makeCommentImageCell(with model: MHTweetModel.Comment, from tableView: UITableView, indexPath: IndexPath) -> MHTweetCommentCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MHTweetCommentCell", for: indexPath) as! MHTweetCommentCell
        cell.bindData(model, delegate: self)
        return cell
    }

    func makeBottomLineImageCell(from tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MHBottomLineCell", for: indexPath)
        return cell
    }
}


extension MHTweetsViewController: MHTweetCellShowUserProtocol{
    func showUserPage(model: MHTweetModel.User) {
        viewModel.showUserPage(model)
    }
}
