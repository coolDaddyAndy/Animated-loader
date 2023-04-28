//
//  MainImageView.swift
//  Animated loader
//
//  Created by Andrei Sushkou on 28.04.23.
//

import UIKit

final class MainImageView: UIImageView {
    
    private let progressView: LoaderView = {
        let view = LoaderView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentMode = .scaleAspectFit
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(progressView)
        constraintsSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func constraintsSetup() {
        NSLayoutConstraint.activate([
            progressView.widthAnchor.constraint(equalTo: widthAnchor),
            progressView.heightAnchor.constraint(equalTo: heightAnchor),
            progressView.centerXAnchor.constraint(equalTo: centerXAnchor),
            progressView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    func fetchImage() {
        let urlString: String = "https://www.hdcarwallpapers.com/walls/bugatti_chiron_pur_sport_2020_4k_8k-HD.jpg"
        guard let url = URL(string: urlString) else {
            return
        }
        let session = URLSession(configuration: .default,
                                 delegate: self,
                                 delegateQueue: OperationQueue())
        session.downloadTask(with: url)
            .resume()
    }
}

extension MainImageView: URLSessionDownloadDelegate {
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        guard let data = try? Data(contentsOf: location) else {
            return
        }
        let image = UIImage(data: data)
        DispatchQueue.main.async {
            self.image = image
            self.progressView.revealLoaderToShow()
        }
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        let progress = totalBytesWritten / totalBytesExpectedToWrite
        DispatchQueue.main.async {
            self.progressView.progress = CGFloat(progress)
        }
    }
}
