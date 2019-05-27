//
//  ViewController.swift
//  Lottie-playground
//
//  Created by Yu Tawata on 2019/05/27.
//  Copyright © 2019 Yu Tawata. All rights reserved.
//

import UIKit
import Lottie

class ViewController: UIViewController {
    @IBOutlet weak var animationContainerView: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var downloadButton: UIButton!
    @IBOutlet weak var playButton: UIButton!

    private let animationView = AnimationView()

    private var task: URLSessionTask?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        animationContainerView.addSubview(animationView)
        animationView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            animationView.topAnchor.constraint(equalTo: animationContainerView.topAnchor),
            animationView.leadingAnchor.constraint(equalTo: animationContainerView.leadingAnchor),
            animationView.trailingAnchor.constraint(equalTo: animationContainerView.trailingAnchor),
            animationView.bottomAnchor.constraint(equalTo: animationContainerView.bottomAnchor)])
        animationView.loopMode = .loop
    }

    private func download(from urlString: String) {
        guard let url = URL(string: urlString) else {
            return
        }
        Animation.loadedFrom(
            url: url,
            closure: { [weak self] (animation) in
                self?.animationView.animation = animation
            },
            animationCache: nil)
    }

    private func save(_ localURL: URL) {
    }

    @IBAction func onPlay() {
        if animationView.isAnimationPlaying {
            animationView.stop()
            playButton.setTitle("Play", for: .normal)
        } else {
            animationView.play()
            playButton.setTitle("Stop", for: .normal)
        }
    }

    @IBAction func onDownload() {
        let alert = UIAlertController(title: "Input lottie's json file path", message: nil, preferredStyle: .alert)
        alert.addTextField()
        alert.addAction(.init(title: "OK", style: .default, handler: { [weak self] (_) in
            guard let urlString = alert.textFields?.first?.text else {
                return
            }
            self?.download(from: urlString)
        }))
        present(alert, animated: true, completion: nil)
    }
}
