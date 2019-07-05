//
//  StartViewController.swift
//  WorkList
//
//  Created by CuongVX-D1 on 7/8/19.
//  Copyright © 2019 CuongVX-D1. All rights reserved.
//

import UIKit

final class StartViewController: UIViewController {
    
    //  MARK: - Outlet
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    //  MARK: - Constant & Variable
    private struct Constant {
        static let widthScreen = UIScreen.main.bounds.width
        static let heightScreen = UIScreen.main.bounds.height
        static let minimumLineSpacingForSectionAt: CGFloat = 0
    }
    
    let data = [
        DataStartCell(topImage: "top1", firstLabelText: "Welcome to asking", secondlabelText: "Whats going to happen tomorrow?", bottomImage: "bottom1"),
        DataStartCell(topImage: "top2", firstLabelText: "Work happens", secondlabelText: "Get notified when work happens.", bottomImage: "bottom2"),
        DataStartCell(topImage: "top3", firstLabelText: "Tasks and assign", secondlabelText: "Task and assign them to colleagues.", bottomImage: "bottom3"),
    ]
    
    //  MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupPageControl()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    //  MARK: - Setup View
    private func setupCollectionView() {
        collectionView.do {
            $0.dataSource = self
            $0.delegate = self
            $0.register(cellType: StartCell.self)
            $0.isPagingEnabled = true
        }
    }
    
    private func setupPageControl() {
        pageControl.numberOfPages = data.count
    }
}

extension StartViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: StartCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.setcontentFor(cell: data[indexPath.row])
        return cell
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView,
                                   withVelocity velocity: CGPoint,
                                   targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let posion = targetContentOffset.pointee.x / Constant.widthScreen
        pageControl.currentPage = Int(posion)
    }
}

extension StartViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Constant.widthScreen,
                      height: Constant.heightScreen)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Constant.minimumLineSpacingForSectionAt
    }
}
