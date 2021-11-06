//
//  ResultsViewController.swift
//  Flickry
//
//  Created by Denrick on 11/6/21.
//

import UIKit
import Closures

class ResultsViewController: UIViewController {
    
    // MARK: - Constants
    
    private enum Constants {
        static let lineSpacing: CGFloat = 6
        static let itemsPerRow: CGFloat = 3
    }
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Properties
    
    weak var coordinator: MainCoordinator?
    
    private var searchString: String = ""
    private var searchData: FlickrSearchResponse? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    private let flickService: FlickrService = .init()
    private var isLoading: Bool = false
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        search()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        let offset = collectionView.contentOffset
        let width = collectionView.bounds.size.width

        let index = round(offset.x / width)
        let newOffset = CGPoint(x: index * size.width, y: offset.y)

        coordinator.animate(alongsideTransition: { [weak self] context in
            guard let self = self else { return }
            self.setupCollectionViewFlowLayout()
            self.collectionView.reloadData()
            self.collectionView.setContentOffset(newOffset, animated: false) // for maintaining scroll offset when changing orientation
        }, completion: nil)
    }
    
    // MARK: - Setup
    
    private func setup() {
        setupNavigationBar()
        setupCollectionView()
    }
    
    private func setupNavigationBar() {
        title = searchString
    }
    
    private func setupCollectionView() {
        collectionView.register(cellType: ResultCollectionViewCell.self)
        collectionView.contentInset = .init(top: 10, left: 20, bottom: 10, right: 20) // add insets
        setupCollectionViewFlowLayout()
        collectionView.numberOfItemsInSection { [weak self] _ in
            guard let self = self else { return 0 }
            return self.searchData?.photos.count ?? 0
        }.cellForItemAt { [weak self] indexPath in
            guard let self = self,
                  let photo = self.searchData?.photos[indexPath.row] else {
                return .init()
            }
            let cell = self.collectionView.dequeueReusableCell(for: indexPath, cellType: ResultCollectionViewCell.self)
            cell.setup(imageUrl: photo.imageURL)
            return cell
        }.didScroll { [weak self] scrollView in // for infinite scrolling
            guard let self = self,
                  !self.isLoading else { return }
            let contentOffsetY = scrollView.contentOffset.y
            if contentOffsetY >= (scrollView.contentSize.height - scrollView.bounds.height) { // if scroll reaches the end
                self.search()
            }
        }
    }
    
    private func setupCollectionViewFlowLayout() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            let layout = UICollectionViewFlowLayout()
            
            let itemWidth = (self.collectionView.frame.width - 52) / Constants.itemsPerRow
            let itemHeight = itemWidth
            
            layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
            layout.minimumLineSpacing = Constants.lineSpacing
            layout.minimumInteritemSpacing = Constants.lineSpacing
            self.collectionView.setCollectionViewLayout(layout, animated: false)
        }
    }
}

// MARK: - API Calls

extension ResultsViewController {
    private func search() {
        let currentPage = searchData?.page ?? 0
        guard currentPage < searchData?.pages ?? 1 else { return }
        startLoading()
        isLoading = true
        flickService.fetchImages(params: .init(text: searchString, page: currentPage+1)) { [weak self] result in
            guard let self = self else { return }
            defer {
                self.stopLoading()
                self.isLoading = false
            }
            switch result {
            case .success(let response):
                let oldPhotos = self.searchData?.photos ?? []
                var tempResponse = response
                tempResponse.photos.insert(contentsOf: oldPhotos, at: 0)
                self.searchData = tempResponse
            case .failure(let error):
                self.showErrorAlert(with: error)
            }
        }
    }
}

// MARK: - StoryboardInstantiable

extension ResultsViewController: StoryboardInstantiable {
    struct Input {
        let searchString: String
    }
    struct Output {}
    
    static func generateFromStoryboard(input: Input, output: Output = .init()) -> ResultsViewController {
        let controller = StoryboardScene.Results.initialScene.instantiate()
        controller.searchString = input.searchString
        return controller
    }
}
