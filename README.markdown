DejalUIKitCategories
====================

DejalUIKitCategories is a collection of categories for UIKit on iOS, to add useful methods to classes like `UIBarButtonItem`, `UIColor`, `UIView`, and others.


Donations
---------

I wrote DejalUIKitCategories for my own use, but I'm making it available for the benefit of the iOS developer community.

If you find it useful, a donation via PayPal (or something from my Amazon.com Wish List) would be very much appreciated. Appropriate links can be found on the Dejal Developer page:

<http://www.dejal.com/developer>


Latest Version
--------------

You can find the latest version of this code via the GitHub repository:

<https://github.com/Dejal/DejalUIKitCategories>

For news on updates, also check out the Dejal Developer page or the Dejal Blog filtered for Dejal categories posts:

<http://www.dejal.com/blog/dejalcategories>


Environment & Requirements
--------------------------

- iOS 8.  Most methods may work in older OS versions.
- Objective-C language.
- ARC.


Features
--------

- **UIApplication+Dejal**: Adds methods to get the first responder and keyboard view of the app.
- **UIBarButtonItem+Dejal**: Convenience initializers to make `UIBarButton` instances based on and image, title, system item, custom view, spacer, or segmented control.
- **UIButton+Dejal**: A more convenient title property, and a method to add a gloss effect.
- **UIColor+Dejal**: Convenience initializers for more standard colors, or based on a platform-specific image or hex value.
- **UIImage+Dejal**: Convenience initializers for tinted images, methods to overlay images with colors, and scaling methods.
- **UIImageView+Dejal**: Make a white-background image view, and adjust the background color based on the highlighted state.
- **UILabel+Dejal**: Convenience initializers for labels with various text, font, width etc attributes, and sizing methods.
- **UISegmentedControl+Dejal**: Convenience initializer for a segmented control with specified items, target, action, and initial selection.
- **UITextField+Dejal**: A selected range property, and support for gestures to move the insertion point by swiping.
- **UITextView+Dejal**: Attributes of the selection or insertion point, and support for the insertion point swiping gestures.
- **UIView+Dejal**: Properties for frame and bounds components and an image representation, methods to hide, add to and remove from the superview with animation.

The methods use a `dejal_` prefix to ensure uniqueness (important with categories).

Some of the methods date back several years, so may be less useful nowadays, or have outdated code style.  But there are still lots of gems that are used in all [Dejal](http://www.dejal.com/) apps.


Usage
-----

Include the desired source files in your project.


License and Warranty
--------------------

This code uses the standard BSD license.  See the included License.txt file.  Please also see the [Dejal Open Source License](http://www.dejal.com/developer/license/) web page for more information.

You can use this code at no cost, with attribution.  A non-attribution license is also available, for a fee.

You're welcome to use it in commercial, closed-source, open source, free or any other kind of software, as long as you credit Dejal appropriately.

The placement and format of the credit is up to you, but I prefer the credit to be in the software's "About" window or view, if any. Alternatively, you could put the credit in the software's documentation, or on the web page for the product. The suggested format for the attribution is:

> Includes DejalUIKitCategories code from [Dejal](http://www.dejal.com/developer/).

Where possible, please link the text "Dejal" to the Dejal Developer web page, or include the page's URL: <http://www.dejal.com/developer/>.

This code comes with no warranty of any kind.  I hope it'll be useful to you, but I make no guarantees regarding its functionality or otherwise.


Support / Contact / Bugs / Features
-----------------------------------

I can't promise to answer questions about how to use the code.

If you create an app that uses the code, please tell me about it.

If you want to submit a feature request or bug report, please use [GitHub's issue tracker for this project](https://github.com/Dejal/DejalUIKitCategories/issues).  Or preferably fork the code and implement the feature/fix yourself, then submit a pull request.

Enjoy!

David Sinclair  
Dejal Systems, LLC


Contact: <http://www.dejal.com/contact/?subject=DejalUIKitCategories>
More open source projects: <http://www.dejal.com/developer>
Open source announcements on Twitter: <http://twitter.com/dejalopen>
General Dejal news on Twitter: <http://twitter.com/dejal>

