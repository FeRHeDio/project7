//
//  DetailViewController.swift
//  White House Petitions (Json- Project 7)
//
//  Created by Fernando on /12/1118.
//  Copyright © 2018 eFePe. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {

    
    var webView: WKWebView!
    var detailItem: Petition?
    
    override func loadView() {
        webView = WKWebView()
        view = webView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let detailItem = detailItem else { return }
        
        let html =
        """
        <html>
            <head>
            <meta name="viewport" content="width=device=width, initial-scale=1">
            <style>
                body { font-size: 125%; }
                h1 { font-size: 200%;}
        footer { float: right; color: red; }
            </style>
            </head>
                <body>
                    <h1>
                    \(detailItem.title)
                    </h1>
                    \(detailItem.body)
            </ br>
                <footer>
        <p> Votes: \(detailItem.signatureCount)</p>
                </footer>
                </body>
        </html>
        """

        webView.loadHTMLString(html, baseURL: nil)
    }


}
