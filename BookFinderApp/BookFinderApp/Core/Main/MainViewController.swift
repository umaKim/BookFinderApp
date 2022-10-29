//
//  MainViewController.swift
//  BookFinderApp
//
//  Created by 김윤석 on 2022/10/28.
//

import UIKit


class MainViewController: BaseViewController<MainViewModel> {
    // MARK: - Views
    private let contentView = MainView()
    
    override func loadView() {
        super.loadView()
        
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Search Book"
        navigationController?.navigationBar.prefersLargeTitles = true
        // Do any additional setup after loading the view.
        
        contentView.listView.dataSource = self
        contentView.listView.delegate = self
        contentView.searchBarView.delegate = self
        
        bind()
    }
    
    private func bind() {
        viewModel
            .notificationPublisher
            .sink {[weak self] noti in
                switch noti {
                case .fetchData(let books):
                    self?.contentView.listView.configureHeaderView(with: books.count)
                    self?.contentView.reloadListView()
                }
            }
            .store(in: &cancellables)
    }
}

extension MainViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.setBookTitle(as: searchBar.text ?? "")
        viewModel.getBook()
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: BookFinderListViewCell.identifier, for: indexPath) as? BookFinderListViewCell
        else {
            return UITableViewCell()
        }
        cell.configure(with: viewModel.books[indexPath.row])
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let paginate = scrollView.contentSize.height - (contentView.listView.rowHeight) * 6
        
        if scrollView.contentOffset.y > paginate {
            viewModel.requestNextPage()
        }
    }
}

extension MainViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        let urlStrings = indexPaths.compactMap { self.viewModel.books[$0.row].volumeInfo.imageLinks?.thumbnail }
        urlStrings.forEach({ ImageProvider.shared.loadImage(from: $0) })
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = DetailViewController(viewModel: DetailViewModel(viewModel.books[indexPath.row]))
        navigationController?.pushViewController(vc, animated: true)
    }
}
