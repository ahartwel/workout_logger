#iOS Architecture 

###**SWARM iOS Apps** generally follow a variation on the MVC architecture, or the MVVM variant.

######We should look into the VIPER architecture

##Main Architecture

**View (Controller and View directories):** ViewControllers and their respective component Views are managed by the main Navigation Controller. View Controllers tell the NavigationController to change state when necessary.  UIViews use SnapKit to define layout. Events are handled inside of the view and passed up to the View Controller via delegation. 

######**Events are passed up starting at the view (via delegate methods), data is modified in the View Model and passed back down where it needs to go**

**View Model:** Data is modified inside of the view model, not the controller. The view model is created and mantained via a collection of protocols. The View Controller holds a reference to a Read & Write Protocol and the views just have a Read Protocol.
The **Read Protocol** exposes methods for getting values in a usable format from the view model for the view. The **Write Protocol** exposes methods for modifying data and updating the state of the view. No one except the View Model should modify its properties directly.


**Services:** We utilize the Singleton design pattern for services which communicate over the network and store our data model.  We should implement a Network Cache for offline use, which can present stored data, and save Data created while offline to be uploaded when possible. Services are called from the view controller and the data returned passed into the view model


**Models:** We define our objects here.  Objects which are passed over the network are subclassed from Resource and implement the Spine variables resourceType and fields array.


**Transitions Directory:** We use a NavigationControllerDelegate to determine which transition should be used to animate the change between view controllers, such as Push, Pop, Fade In, or any other transition we need can be easily defined.



**Other code:**

**Extensions:** We define the Colors and Fonts used by an app in extensions to the UIColor and UIFont classes, so we can refer to colors such as UIColor.tiplr_mediumPink()  Other extensions to iOS classes should go in here.

**Configuration:**Holds all of the urls/configuration variables, that are changed based on which scheme is built. 



##Pods

We use various Cocoapods to get up and running quickly:

**Spine** is a JSONAPI library that allows us to easily define our Model and perform GET/POST/PATCH/DELETE calls to our API by serializing and deserializing our Data objects.

**Alamofire** is useful for implementing asynchronous network calls outside of the app API, such as login messages

**SwiftyJSON** is useful for easy parsing of non-API network calls which return JSON

**SnapKit** is used to define the auto-layout of views.  This should be set up in a function called by viewDidLoad() rather than in updateConstraints() unless the constraints are changing often.  If they only change in specific instances, they should be done explicitly.

**Fabric** and **Crashlytics** connect the app to the Answers and Crashlytics services, which offer insight into app usage and crash reports

**SDWebImage** is used to load remote images into UIImageView objects.  It can be used to set a placeholder image, display progress, and offers a completion handler if needed.

**Branch** provides the SDK support for Deep Links into the app for sharing content and linking back to the app.

**ReachabilitySwift** provides an easy to use asynchronous hook into changes in network availability.

**Dollar** easily modify arrays and objects (“A functional tool-belt for Swift”) (similar to underscore on the server side)

**BuddyBuild** continuous deployment and crash logging (only in development, fabric for production)

**Google Analytics** for analytics

**PaperTrailLumberjack/Swift** for logging to paper trail. Inside of the Helpers folder there is a class with helpers for different log levels

##TODOs

**Here are some areas for future development:**

* UI Testing
* Unit Testing



##Client Setup & Deployment Checklist

* Apple Developer Program - the client must join the Apple Developer Program ($100+/year) and renew yearly to upload and distribute apps in the App Store
* SSL Certificate - the client should obtain an SSL certificate from their hosting provider or other reputable source to protect the server from unencrypted access.
* Azure - set up cloud based virtual machines and other services like sendgrid, a notification server, and load balancing.
* MLab - set up mongodb database servers for development (free version) and production (dedicated server)
* Branch - set up deep links from the app
* Google Analytics - set up an account for gathering usage analytics, page views, and events
* Fabric/Crashlytics - track usage and crash reports, client needs their own team to view reports and create their own API key for the production version of the app
* Google Places API - client may need to create an account with their credit card, free transactions up to x

##Logging 

We have Papertrail set up on our server to log errors, it can be configured to email an error report to dev@swarmnyc.com

We are using Papertrail on the client as well.

##Error Handling

We use Crashlytics to provide detailed crash reporting in email, and get more detailed information in the web dashboard.  dSYM files can be downloaded from iTunesConnect and dragged onto the web page, or they are uploaded automatically if you are using BuddyBuild.

We can use buddy build for QA builds in order to take advantage of the screenshot capture. But they conflict with each other and only one should be used in each environment.

##Continuous Integration

The buddy build sdk is already setup in this sample project. To create builds from git pushes go to buddybuild.com and select "Add a new app." Follow the instructions and select the git repo for your project.

You will need to create a new app for each scheme you want to be built automatically. (one for QA and one for Production)
