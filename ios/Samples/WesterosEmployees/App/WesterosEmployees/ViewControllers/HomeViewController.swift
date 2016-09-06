/**
* Copyright (c) 2000-present Liferay, Inc. All rights reserved.
*
* This library is free software; you can redistribute it and/or modify it under
* the terms of the GNU Lesser General Public License as published by the Free
* Software Foundation; either version 2.1 of the License, or (at your option)
* any later version.
*
* This library is distributed in the hope that it will be useful, but WITHOUT
* ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
* FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more
* details.
*/
import UIKit
import LiferayScreens

public var tourCompleted = false

class HomeViewController: UIViewController {

	@IBOutlet weak var cardDeck: CardDeckView?
	@IBOutlet weak var userProfileView: UIView?

	var documentationViewController: DocumentationViewController?
	var blogsViewController: BlogsViewController?
	var galleryViewController: GalleryViewController?

	override func viewDidLoad() {
		super.viewDidLoad()

		cardDeck?.addCards(["Documentation", "Blogs", "Gallery"])

		self.userProfileView?.layer.zPosition = -1000
		self.cardDeck?.layer.zPosition = 0

		documentationViewController = DocumentationViewController(card: cardDeck!.cards[0])
		blogsViewController = BlogsViewController(card: cardDeck!.cards[1])
		galleryViewController = GalleryViewController(card: cardDeck!.cards[2])
	}

	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)
		let isLoggedIn = SessionContext.isLoggedIn
		if isLoggedIn {
			UIView.animateWithDuration(1.5) {
				self.cardDeck?.alpha = 1.0
			}
		} else {
			self.cardDeck?.alpha = 0.0
		}
	}

	override func viewDidAppear(animated: Bool) {
		super.viewDidAppear(animated)

		if !SessionContext.isLoggedIn {
			if !tourCompleted {
				dispatch_delayed(0.5) {
					self.performSegueWithIdentifier("tour", sender: nil)
				}
			}
			else {
				self.performSegueWithIdentifier("login", sender: nil)
			}
		}
	}

}

