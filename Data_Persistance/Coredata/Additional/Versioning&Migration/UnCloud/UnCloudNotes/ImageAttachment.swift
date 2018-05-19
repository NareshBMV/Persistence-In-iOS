//
//  ImageAttachment.swift
//  UnCloudNotes
//
//  Created by Naresh on 19/05/18.
//  Copyright © 2018 Ray Wenderlich. All rights reserved.
//

import UIKit

class ImageAttachment: Attachment {

  @NSManaged var caption: String
  @NSManaged var image: UIImage?
  @NSManaged var width: Float
  @NSManaged var height: Float

}
