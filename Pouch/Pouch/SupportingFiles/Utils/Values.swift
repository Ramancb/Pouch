//
//  Values.swift
//  juglo
//
//  Created by apple on 08/06/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit


typealias JSON = [String: Any]
typealias OptionsData = Walk_2_Data


class SettingsData: Walk_2_Data {
    var backgroundColor: UIColor?
    var key: String = ""
    
    init(title: String, icon:UIImage, colorHex: String) {
        super.init(title: title, selected: false)
        let color:UIColor = .init(hexString: colorHex)
        self.icon = icon.maskWithColor(color: color)
        self.backgroundColor = color.withAlphaComponent(0.1)
    }
    
    override init(title: String, selected: Bool?) {
        super.init(title: title, selected: selected)
    }
    
    override init(title: String, description: String, icon: UIImage) {
        super.init(title: title, description: description, icon: icon)
    }
    
}

class MenuData {
    var title: String?
    var iconName: String?
    var selected: Bool = false
    
    init(title: String, icon: String, selected: Bool) {
        self.title = title
        self.iconName = icon
        self.selected = selected
    }
    
}

struct ChatEvent {
    static let online = "Online..."
    static let typing = "Typing..."
    static let offline = "Offline..."
    static let busy = "Busy"
    static let silent = "Silent"
}

class Walk_2_Data {
    var title: String = ""
    var description: String  = ""
    var icon: UIImage  = #imageLiteral(resourceName: "ic_module_inactive")
    var selected: Bool? = nil
    var row: Int = 0
    
    public init(title: String, selected: Bool?) {
        self.selected = selected
        self.title = title
    }
    
    public init(title:String, description:String, icon:UIImage) {
        self.title = title
        self.description = description
        self.icon = icon
    }
    
    public convenience init(title: String, icon: UIImage) {
        self.init(title: title, description: "", icon: icon)
    }
    
    public convenience init(title:String, icon: UIImage, selected: Bool) {
        self.init(title: title, description: "", icon: icon)
        self.selected = selected
    }
    
    public convenience init(title:String, description: String, selected: Bool) {
        self.init(title:title, selected: selected)
        self.description = description
    }
    
}

struct Arr {
    
//    static let dashboardFilters: [SettingsData] = [
//        SettingsData(title: "Show All Posts", description: "Show All Posts", selected: false),
//        SettingsData(title: "Show Meetings", description: "Show Meetings", selected: false),
//        SettingsData(title: "Show Events", description: "Show Events", selected: false),
//        SettingsData(title: "Show Tasks", description: "Show Tasks", selected: false),
//        SettingsData(title: "Show Polls", description: "Show Polls", selected: false)
//    ]
    
    static let homeTopArray = ["All", "Feed", "Meeting", "Event", "Task", "Poll", "Contact"]
    
    
    static let walk_2_Arr: [Walk_2_Data] = [
        Walk_2_Data(title: Str.walk_2_title_1, description: Str.walk_2_description_1, icon: #imageLiteral(resourceName: "onboarding_1")),
        Walk_2_Data(title: Str.walk_2_title_2, description: Str.walk_2_description_2, icon: #imageLiteral(resourceName: "onboarding_2")),
        Walk_2_Data(title: Str.walk_2_title_3, description: Str.walk_2_description_3, icon: #imageLiteral(resourceName: "onboarding_3"))
//        Walk_2_Data(title: Str.walk_2_title_4, description: Str.walk_2_description_4, icon: #imageLiteral(resourceName: "walkthrough4"))
    ]
    
    static let walk_1_Arr: [String] = [
        Str.walk_text_1,
        Str.walk_text_2,
        Str.walk_text_3,
        Str.walk_text_4
    ]
    
    static let menuArr: [MenuData] = [
        MenuData(title: "Home", icon: "ic_menu_home", selected: false),
        MenuData(title: "Calender", icon: "ic_menu_calendar", selected: false),
        MenuData(title: "User Analytics", icon: "ic_menu_user_analytics", selected: false),
        MenuData(title: "Settings", icon:"ic_menu_sttings", selected: false),
        MenuData(title: "About Us", icon: "ic_menu_about_us", selected: false),
//        MenuData(title: "24 Hour Clock", icon: "ic_menu_clock", selected: false),
        MenuData(title: "Logout", icon: "ic_menu_logout", selected: false)
    ]
    
    static let optionsData: [OptionsData] = [
        OptionsData(title: Str.feeds, icon: #imageLiteral(resourceName: "ic_feeds")),
        OptionsData(title: Str.meetings, icon: #imageLiteral(resourceName: "ic_meetings")),
        OptionsData(title: Str.events, icon: #imageLiteral(resourceName: "ic_events")),
        OptionsData(title: Str.polls, icon: #imageLiteral(resourceName: "ic_poll")),
        OptionsData(title: Str.tasks, icon: #imageLiteral(resourceName: "ic_task"))
    ]
    
    static let settingsArr: [SettingsData] = [
        .init(title: Str.notificationSettings, icon:#imageLiteral(resourceName: "ic_notification"), colorHex: "26C6DA"),
        .init(title: Str.contactUs, icon:#imageLiteral(resourceName: "ic_call_blue"), colorHex: "BE63F9"),
        .init(title: Str.terms_Conditions, icon:#imageLiteral(resourceName: "ic_terms_conditions"), colorHex: "34C1A2"),
        .init(title: Str.privacyPolicy, icon: #imageLiteral(resourceName: "ic_privacy_policy"), colorHex: "FC573B")
    ]
    
    var alertsArr: [SettingsData] = [
        SettingsData(title: "15 mins before", selected: false),
        SettingsData(title: "30 mins before", selected: false),
        SettingsData(title: "45 mins before", selected: false),
        SettingsData(title: "1 hour before", selected: false)
    ]
    
    var additionalSettingsArr: [SettingsData] = [
        SettingsData(title: "Allow participants to invite", selected: false),
        SettingsData(title: "Allow participants to upload files", selected: false),
        SettingsData(title: "Hide the participants option", selected: false)
    ]
    
//    static let participantsListData:[ParticipantData] = [
//        ParticipantData(title: Str.all,     total: 0),
//        ParticipantData(title: Str.accepted, total: 0),
//        ParticipantData(title: Str.rejected, total: 0),
//        ParticipantData(title: Str.pending,  total: 0),
//        ParticipantData(title: Str.maybe,    total: 0)
//    ]
    
    static let tagTheAddress: [String] = [
        Str.home,
        Str.work,
        Str.other
    ]
    
    static let dashboardTitles: [String] = [Str.all, Str.meetings, Str.events, Str.tasks, Str.polls, Str.contacts, Str.feeds]
    
}

struct Str {
    
    static let signupDescription = "Congratulations, You took the best decision, your smartphone is about to get more effective in your daily life.\n\nWe will assist in effective commmunication, collaboration at home and work"
    static let youAreAllSet = "You’re All Set!"
    static let goHome = "GO TO DASHBOARD"
    static let currentAddress = "Current Address"
    static let permanenetAddress = "Permanenet Address"
    static let officeAddress = "Office Address"
    static let allPosts = "All"
    static let newVersion = "New Version"
    static let newVersionDescription = "A new version of MeetWise availabe on the app store"
    static let download = "Download"
    static let no = "No"
    static let update = "UPDATE"
    static let home = "Home"
    static let other = "Other"
    static let product = "Product"
    static let team = "Team"
    static let investor = "Investor"
    static let tagTheAddress = "Tag the Address"
    static let addressSaveAs = "Address Saved as"
    
    // contactus strings....
    static let fullName = "Full Name"
    static let emailid = "Email ID"
    static let email = "Email"
    static let namePlaceholder = "Enter name"
    static let emailPlaceholder = "Enter your Email ID"
    static let descPlaceholder = "Write your description here"
    
    static let walk_2_title_1 = "Forget too many apps to manage work and personal life"
    static let walk_2_title_2 = "Connect and communicate Smarter"
    static let walk_2_title_3 = "Meeting and Events are more efficient"
    static let walk_2_title_4 = "Build personal and work profile for smart life"
    
    static let walk_2_description_1 = "MeetWise makes life easy to communicate & collaborate, helps to simplify your work and personal life. Designed for all age groups."
    static let walk_2_description_2 = "MeetWise connects professonals and common man in the most smartest way"
    static let walk_2_description_3 = "MeetWise unified Meeting and Events for both personal and work life. Saves times and money."
    static let walk_2_description_4 = "Build personal and work profile, will save you 100hrs on repetitive task every year."
    static let walk_text_1 = "Smart way to connect"
    static let walk_text_2 = "Connect, Communicate, Collaborate"
    static let walk_text_3 = "Designed for Smarter world"
    static let walk_text_4 = "Digital assistance for everyday"
    static let all = "All"
    static let accepted = "Accepted"
    static let rejected = "Rejected"
    static let reject = "Reject"
    static let pending = "Pending"
    static let title = "Title"
    static let startDate = "Start Date"
    static let endDate = "End Date"
    static let startTime = "Start Time"
    static let endTime = "End Time"
    static let time = "Time"
    static let nameYourmeeting = "Name your meeting…"
    static let inviteMembers = "Invite participants"
    static let members = "Participants"
    static let meetingLocation = "Meeting location"
    static let enterAnAddress = "Enter address…"
    static let locateOnMap = "Locate on Map"
    static let enterTag = "Enter tag"
    static let selectDate = "Select Date"
    static let selectTime = "Select Time"
    static let addressSaved = "Address Saved as"
    static let viewParticipants = "View Participants"
    static let participants = "Participants"
    static let runningLate = "Running Late? Instantly inform participants"
    static let enterDetail = "Enter details.."
    static let enterTitle = "Enter title"
    static let enterDescription = "Enter description"
    static let nameYourEvent = "Name your event…"
    static let nameYourFeed = "Name your feed…"
    static let eventLocation = "Event Location"
    static let eventTicket = "Event Ticket"
    static let accept = "ACCEPT"
    static let remote = "REMOTE"
    static let decline = "REJECT"
    static let maybe = "MAYBE"
    
    //MARK:- Titles
    static let myProfile = "My Profile"
    static let aboutUs = "About Us"
    static let about = "About"
    static let uploadFiles = "Upload File(s)"
    static let privacyPolicy = "Privacy Policy"
    static let terms_Conditions = "Terms & Conditions"
    static let contactUs = "Contact Us"
    static let contactInfo = "Contact Details"
    static let editContactInfo = "Edit Contact Details"
    static let notificationSettings = "Notification Settings"
    static let createMeeting = "Create Meeting"
    static let updateMeeting = "Update Meeting"
    static let changePassword = "Change Password"
    static let chat = "Chat"
    static let chats = "Chats"
    static let create = "Create"
    static let camera = "Camera"
    static let events = "Events"
    static let event = "Event"
    static let videos = "Videos"
    static let photos = "Photos"
    static let photo = "Photo"
    static let dashboard = "Dashboard"
    static let meetwise = "MeetWise"
    static let settings = "Settings"
    static let addContact = "Add Contact"
    static let submit = "SUBMIT"
    static let inviteFriends = "INVITE FRIENDS"
    static let notifications = "Notifications"
    static let participantsList = "Participants List"
    static let add_custom_details = "Add Custom Details"
    static let edit_share_settings = "EDIT SHARE SETTINGS"
    static let edit_share_profile = "Share settings"
    static let customDetail = "Custom Details"
    static let images_Videos = "Images & Videos"
    static let createAnEvent = "Create an Event"
    static let createEvent = "Create Event"
    static let updateEvent = "Update Event"
    static let ticketName = "Ticket Name"
    static let ticketAmount = "Ticket Amount"
    static let ticketPrice = "Ticket Price"
    static let ticket = "Ticket"
    static let addAnotherTicket = "Add Another Ticket"
    
    
    //MARK: - TEXT FIELDS
    static let firstName = "First Name"
    static let lastName = "Last Name"
    static let phoneNumber = "Phone Number"
    static let apply = "apply"
    static let applyFilter = "Apply Filter"
    static let work = "Work"
    static let personal = "Personal"
    static let personalDetail = "Personal Details"
    static let workDetail = "Work Details"
    static let addAnotherExpense = "Add Another Expense"
    
    
    //MARK: - advance options
    static let description = "Description"
    static let writeSomethingAboutMeeting = "Write about meeting..."
    static let category = "Category"
    static let eventType = "Event Type"
    static let banner = "Banner"
    static let acceptedFormatFiles = "Accepted format .png, .jpeg, .mp4, .mov upto 20mb"
    static let acceptedFormatBanners = "Accepted format .png, .jpeg upto 5mb"
    static let acceptedFormatMedia = "Accepted format .png, .jpeg, .mp4, .mov upto 20mb"
    static let acceptedFormatDocs = "Accepted format .pdf, .doc, .ppt  upto 20mb"
    static let acceptedFormatPngJpg = "Accepted format .png, .jpeg upto 20mb"
    static let acceptedFormatDoc = "Accepted format .png, .jpeg, .pdf upto 20mb"
    static let media = "Media"
    static let companyVideo = "Company Video"
    static let document = "Document"
    static let documentGroup = "Document Group"
    static let documents = "Documents"
    static let typeOfAudience = "Type of Audience"
    static let audienceCapacity = "Audience Capacity"
    static let foodChoice = "Food Choice"
    static let drinkChoice = "Drink Choice"
    static let dressCode = "Dress Code"
    static let videoCallLink = "Video Call Link"
    static let choiceSelectedByParticipants = "Choices selected by Participants"
    static let viewEventQrCode = "View Event QR Code"
    static let imagesNdVideos = "Images & Videos"
    static let enterLinkToJoinMeeting = "Enter link to join Meeting"
    static let enterLinkToJoinEvent = "Enter link to join Event"
    static let alerts = "Alerts"
    static let additionalSettings = "Additional Settings"
    static let additionalDetails = "Additional Details"
    static let discard = "Discard"
    static let addImages = "Add Image"
    static let addBanners = "Add Banner(s)"
    static let addMediaFiles = "Add Media Files(s)"
    static let addDocuments = "Add Document(s)"
    static let fileNdDocuments = "Files & Documents"
    static let uploadDocument = "UPLOAD DOCUMENT"
    static let uploadMedia = "UPLOAD MEDIA"
    static let viewAll = "View All"
    static let ping = "PING"
    static let enterATitleHere = "Enter a title here…"
    static let enterBodyTextHere = "Enter body text here…"
    static let spendPurpose = "Purpose"
    static let spendAmount = "Amount"
    static let writeAboutSpending = "Write about Expenses…"
    static let enterAmount = "Enter amount…"
    static let receipt = "Receipt"
    static let Private = "Private"
    static let Public = "Public"
    static let free = "Free"
    static let paid = "Paid"
    
    //MARK:- PLACEHOLDERS
    static let enterDesignation = "Enter Designation"
    static let linkFacebook = "Enter Facebook username"
    static let linkTwitter = "Enter Twitter username"
    static let linkInstagram = "Enter Instagram username"
    static let linkLinkedIn = "Enter Linkedin username"
    static let enterBussinessEmail = "Enter Business work Email ID"
    static let enterWebSiteLink = "Enter Website"
    static let aboutBusiness = "Enter details about your business…"
    static let enterFirstName = "Enter first name"
    static let enterLastName = "Enter last name"
    static let enterUsername = "Enter Username"
    static let name = "Name"
    static let bankAccount  = "Bank Account "
    static let enterBio = "Enter details about you…"
    static let enterGroupName = "Enter group name…"
    static let enterName = "Enter name"
    static let enterPhoneNumber = "Enter Phone Number"
    static let enterEmail = "Enter Email ID"
    static let feeds = "Feeds"
    static let meetings = "Meetings"
    static let meeting = "Meeting"
    static let module = "Module"
    static let meetingType = "Meeting Type"
    static let enterMeetingType = "Enter Meeting type"
    static let enterEventType = "Enter Event type"
    static let polls = "Polls"
    static let poll = "POLL"
    static let notes = "Notes"
    static let note = "Note"
    static let expenses = "Expenses"
    static let editExpense = "Edit Expense"
    static let noExpenseFound = "No Expense Found"
    static let addExpense = "Add Expense"
    static let pollResults = "Poll Results"
    static let bank = "BANK"
    static let tasks = "Task"
    static let likes = "Likes"
    static let comments = "Comments"
    static let share = "Share"
    static let shared = "Shared"
    static let done = "Done"
    static let confirm = "Confirm"
    static let otpConfirm = "OTP Confirmed"
    static let report = "Report"
    static let block = "Block"
    static let unblock = "Unblock"
    static let edit = "Edit"
    static let editEmailId = "Edit Email ID"
    static let editPhoneNumber = "Edit Mobile Number"
    static let delete = "Delete"
    static let duplicate = "Duplicate"
    static let today = "Today"
    static let tomorrow = "Tomorrow"
    static let customDate = "Custom Date"
    static let customAddress = "Custom Address"
    static let reset = "Reset"
    static let to = "to"
    static let message = "Message"
    static let reminders = "Reminders"
    static let allowMembersToInvite = "Allow participants to invite"
    static let advanceOptions = "Advance Options"
    static let newPassword = "New Password"
    static let confirmNewPassword = "Confirm New Password"
    static let resetPassword = "Reset Password"
    static let reoccurMeeting = "Recurring Meeting:"
    static let shareWithFriends = "Share with friends"
    static let upcoming = "Upcoming"
    static let upcomingEvents = "Upcoming Events"
    static let upcomingMeetings = "Upcoming Meetings"
    static let past = "Past"
    static let seeAll = "SEE ALL"
    static let seeResult = "SEE RESULT"
    static let followUp = "Follow Up"
    static let follow = "Follow"
    static let unfollow = "Unfollow"
    static let followers = "Followers"
    static let followings = "Followings"
    static let followUpMeeting = "Followup Meeting"
    static let followUpEvent = "Followup Event"
    static let totalParticipants = "Total Participants:"
    static let noActivityFound = "No Activity Found!"
    static let noActivityFoundDescription = "You are all set to make everyday effective. Go to profile building, Go to Sync contacts.\nExperience Worlds 1st smartest contact management system"
    // clear notifications popup strings
    static let clearNotificationPopupTitle = "Notifications cleared"
    static let clearNotificationPopupDesc = "Notifications cleared successfully"
    static let clearNotificationOkBtnTitle = "Go to notifications"
    static let clearNotificationCancelBtnTitle = "Back"
    static let logOut = "Log Out"
    
    // user analytics
    static let user_Analytics = "User analytics"
    static let syncSuccessfully = "Sync successful"
    static let weHaveSuccessfullySyncedYourContact = "Contact sync successful"
    static let goToContacts = "Go to contacts"
    static let friendsInvited = "Friends invited"
    static let weHaveSuccessfullyInvitedYourContacts = "Contact invited successfully"
    static let meetWiseIsBetterWithFriends = "MeetWise is better with friends"
    static let inviteNow = "Invite Now"
    static let allContacts = "All Contacts"
    static let allDocuments = "All Documents"
    static let meetWise = "MeetWise"
    static let contacts = "Contacts"
    static let searchContact = "Search Contact"
    static let frequent = "Frequent"
    static let selectAll = "Select All"
    static let selectAddress = "Select Address"
    static let save = "Save"
    static let saveContact = "Save contact"
    static let noResults = "No Results!"
    static let trySearchingForOtherKeywords = "Try searching for other keywords"
    static let noContacts = "No Contacts"
    static let syncContacts = "SYNC CONTACTS"
    static let viewProfile = "View Profile"
    static let makeAdmin = "Make Admin"
    static let call = "Call"
    static let remove = "Remove"
    static let cancel = "Cancel"
    static let cancelEvent = "Cancel event"
    static let info = "Info"
    static let information = "Information"
    static let mute = "Mute"
    static let clearChat = "Clear chat"
    static let typeSomething = "Type here…"
    static let addYourComments = "Add your comments..."
    static let search = "Search…"
    static let searchCompany = "Search company..."
    static let congratulations = "Congratulations"
    static let meetingCreatedDescription = "Meeting created successfully"
    static let blockPost = "Block Post"
    static let yesBlock = "Yes"
    static let yes = "Yes"
    static let noCancel = "No, cancel"
    static let blockPostDescription = "Are you sure, you want to block this post?\nThis action cannot be undone"
    static let deletePost = "Delete Post"
    static let deleteDocuments = "Delete Documents"
    static let deleteDocumentsDescription = "Are you sure, you want to delete selected documents?"
    static let deletedDocumentsDescription = "Documents deleted successfully."
    static let goToMeetings = "Go to meetings"
    static let back = "Back"
    static let next = "Next"
    static let yesDelete = "Yes, delete"
    static let deletePostDescription = "Are you sure, you want to delete this post?"
    static let duplicatePost = "Duplicate Post"
    static let duplicateMeeting = "Duplicate Meeting"
    static let duplicateEvent = "Duplicate Event"
    static let moreAction = "More Action"
    static let moreActionDescription = "Either you can remove or ping users in the participant list"
    static let yesFollowUp = "Yes, follow up"
    static let duplicatePostDescription = "Are you sure, you want to duplicate this post?\nPlease select any option below to continue"
    
    static func duplicatePostDescription(type:String) -> String {
        return "Are you sure, you want to duplicate this \(type)?\nPlease select any option below to continue"
    }
    static let invite = "Invite"
    static let createNewPost = "Create new post"
    static let notificationSettingDesc = "Enable the notifications, if you wish to\nreceive."
    
    
    //MARK:- profile
    static let verifyEmailMsg = "Check your email and click verify button"
    static let addMobileMsg = "Check your mobile and enter verification code"
    static let confirmMobileNoMsg = "Thank you for confirming your mobile number"
    static let backToProfile = "Back To Profile"
    static let createGroupDesc = "Name the group"
    static let createDocGroup = "Create Document Group"
    static let updateDocGroup = "Update Document Group"
    static let titleForProfileDetail = "Add title for the details"
    static let profileGamification = "Profile Gamification: "
    static let beginnerLevel = "Beginner Level"
    static let fillYourCompleteProfile = "Lets fill your complete profile: "
    static let addYourProfileDetail = "Add your Profile Details"
    static let acceptedFormatimage = "Accepted format .png, .jpeg upto 5mb"
    static let male = "Male"
    static let female = "Female"
    static let profile = "Profile"
    static let profilePicture = "Profile Picture"
    static let linkedin = "Linkedin"
    static let instagram = "Instagram"
    static let facebook = "Facebook"
    static let twitter = "Twitter"
    static let dob = "Date of Birth"
    static let username = "Username"
    static let nickname = "Short Name"
    static let gender = "Gender"
    static let viewCount = "View Count"
    static let shareCount = "Share Count"
    static let shareWithContact = "Share with Contacts"
    static let shareQrCode = "Share QR Code"
    static let shareProfile = "Share Profile"
    static let profileDetails = "Profile Details"
    static let contactDetails = "Contact Details"
    static let companyDetails = "Company Details"
    static let addresses = "Addresses"
    static let address = "Address"
    static let admin = "Admin"
    static let addAddress = "Add Address"
    static let editAddress = "Edit Address"
    static let bankDetails = "Bank Details"
    static let bankDetail = "Bank Detail"
    static let addBankAccount = "Add Bank Account"
    static let editBankAccount = "Edit Bank Account"
    static let addBank = "Add Bank"
    static let addToContact = "Add to contact"
    static let feedPosts = "Feed Posts"
    static let feedPost = "Feed Post"
    static let files_Documents = "Files & Documents"
    static let workProfile = "Work Profile"
    static let background = "Background"
    static let socialMediaLinks = "Social Media Links"
    static let businessName = "Business Name"
    static let businessDomain = "Business Email ID"
    static let websiteLink = "Website"
    static let designation = "Designation"
    static let bio = "Bio"
    static let workProfileHeaderDesc = "Note: Enter Business name to auto fill all the details"
    static let makeProfilePicture = "Make this Profile Picture"
    static let addAnotherBank = "Add Another Bank"
    static let addAnotherInfo = "Add Another Info"
    static let addInfo = "Add Info"
    static let accountNumber = "Account Number"
    static let bankName = "Bank Name"
    static let ifscCode = "IFSC Code"
    static let enter = "Enter"
    static let select = "Select"
    static let companyName = "Company Name"
    static let companyDocuments = "Company Documents"
    static let applySettings  = "APPLY SETTINGS"
    static let deleteAddressMsg = "Are you sure to delete this address?"
    static let deleteBankDetailMsg = "Are you sure to delete this Bank detail?"
    
    //MARK:- poll
    static let createPoll = "Create Poll"
    static let updatePoll = "Update Poll"
    static let selectPollType = "Select a Poll type"
    static let multipleChoicePoll = "Multiple Choice Poll"
    static let numericalPoll = "Numerical Scale Poll"
    static let rateSlidePoll = "Rate Slider Poll"
    static let rateStarPoll = "Rate Star Poll"
    static let questionPlaceholder = "Type your question here"
    static let mcPollPlaceholder = "Enter Option "
    static let pollOptions = "POLL OPTIONS"
    static let createChoices = "Create choices"
    static let selectYourChoice = "Select your choice"
    static let selectedChoice = "Selected choice"
    static let createFeed = "Create Feed"
    static let createGroup = "Create Group"
    static let groupType = "Group Type"
    static let hideParticipantDetails = "Hide Participant Details"
    static let otherSharePoll = "Others can Share this Poll"
    static let oneDayPoll = "One Day Poll"
    static let twoDayPoll = "Two Days Poll"
    static let customPoll = "Custom Poll"
    static let pollTitle = "Poll Title"
    static let addPoll = "Add Poll"
    static let addNote = "Add Note"
    static let editNote = "Edit Note"
    static let pollLinkedWith = "Poll Lnked with"
    static let group = "Group"
    static let noNotesFound = "No Notes Found"
    static let noNotifications = "No Notifications!"
    static let noNotificationsDescription = "No notifications right now"
    static let noComments = "No Comments!"
    static let noCommentsDescription = "No Comments right now"
    static let noMessage = "No Messages!"
    static let noMessageDescription = "No Messages right now.\nTo start a conversation, create a meeting/event or go to contacts and start conversation"
    static let onesSubmittedOptionCanNotBeChangesLaterThanks = "Once submitted, changes not allowed"
    static let endedAt = "Poll will end at"
    
    // MARK:- TASK
    static let totalTasks = "Total Tasks"
    static let otherTasks = "Others Tasks"
    static let myTasks = "My Tasks"
    static let completed = "Completed"
    static let overdue = "Overdue"
    static let addtask = "Add task..."
    static let addTask = "Add Task"
    static let assignTask = "Assign Task"
    static let assignWith = "Assigned with"
    static let taskDetails = "Task Details"
    static let ediTtask = "Edit Task"
    static let clear = "clear"
    
    
    static let assignedTaskBy = "Assigned Task by"
    
    // MARK:- chat
    static let reportGroup = "Report Group"
    static let reportGroupDesc = "Do you want to report group to MeetWise?"
    static let clearChatHistory = "Clear entire chat history and all the messages?"
    static let deleteRelatedMedia = "Delete related media from phone"
    static let notificationMutedFor = "Notifications muted for"
    static let gotoChat = "Go to chat"
    static let muteNotificationTitle = "Mute notifications for…"
    static let muteNotification = "MUTE NOTIFICATIONS"
    static let organiserCancelledEvent = "Event cancelled by Organiser"
    static let messageOrganiser = "Message from Organiser"
    static let cancelled = "Cancelled"
    static let scanTheQrCodeToFindMeetingEventAndMore = "Scan QR code to find Meeting, Event and more"
    static let or = "or"
    static let enterTheUniqueAlphanumericCodeForTheMeetingEventAndMore = "Enter the unique alphanumeric code for the Meeting, Event and more"
    static let enterTheUnique8DigitCode = "Enter the unique 8 digit code…"
    static let scanQrCode = "SCAN QR CODE"
    static let createdBy = "Created by :-"
    static let by = "by"
    static let post = "post"
    static let code = "Code"
    static let shareCodeOrClickOn = "share code or click on"
    static let toJoinTheMeetingEvent = "to join the Meeting/Event"
    static let inviteCodeCopied = "Invite code copied"
    static let enterCompleteInformation = "Enter complete information"
    static let solo = "Solo"
    static let yourEventIsUpdatedSuccessfully = "Event updated successfully"
    static let lateBy = "Late by"
    static let mins = "mins"
    static let contentNotFound = "Content not found"
    static let yourMeetingIsUpdatedSuccessfully = "Meeting updated successfully"
    static let pleaseEnter = "Please enter"
    static let yourMeetingIsUpdated = "Your meeting updated"
    static let progressView = "Progress View"
    static let areYouSureYouWantToDeleteThisPoll = "Are you sure you want to delete this Poll?"
    static let yesDeleteIt = "Yes, Delete it!"
    static let areYouSureYouWantToDeleteThisTask = "Are you sure you want to delete this task?"
    
    //MARK:- NEW STRINGS
    static let yesterday = "Yesterday"
    static let kpteck = "kpteck"
    static let totalNumberOfParticipants = "Total number of participants"
    static let pollAnsweredParticipants = "Poll answered participants"
    
    
//    static func getAddressShareText(name: String, data: AddressListData) -> String {
//        var addressText = "\(name) shared below details :\n\n"
//        addressText += Str.getShareAddress(data: data)
//        addressText += "Shared using MeetWise"
//        return addressText
//    }
    
//    static func getShareAddress(data: AddressListData) -> String {
//        var addressText = ""
//        let address = data.address ?? ""
//        if let category = data.address_category {
//            addressText += "\(category) : \(address), \(data.address_location ?? "")"
//        } else {
//            addressText += "\(Str.address) : \(address), \(data.address_location ?? "")"
//        }
//
//        let lat = data.address_latitude ?? 0
//        let lng = data.address_longitude ?? 0
//
//        addressText += "\n\nLocation : "
//
//        addressText += "\nhttp://maps.apple.com/maps?saddr=\(lat),\(lng)"
//
//        addressText += "\n\nCheck on google map :"
//        addressText += "\nhttp://maps.google.com/maps?q=loc:\(lat),\(lng)\n\n"
//        return addressText
//    }
    
    static func scanTheQrCodeText(type : String) -> String {
        return "Scan the QR Code to visit the \(type) page\nor copy the following link"
    }
    
//    static func getPostShareText(name: String, postTitle: String, post:POST_TYPE, code: String, url: String) -> String {
//// Invite code is \(code).\n\n"
//        if post == .profile {
////            text = "\(name) invited you to connect on MeetWise. Your invite code is \(code).\n\n"
//            let nameprofile = UserDefaultsCustom.getUserData()?.name ?? ""
//            return Str.getProfileShareText(name: nameprofile, profile: name, url: url)
//        }
//        var text = "\(name) invited you for a \(post.rawValue.lowercased()), “\(postTitle)”.\n\n"
//        text += "\(post.rawValue.capitalized) link\n\(url)\n\n"
//        text += "MeetWise will save your time and money in your day-to-day activities. Reduce many hours of repetitive tasks."
//        return text
//    }
//
//    static func getDocShareText(fileUrl: String?) -> String {
//        var name = ""
//        let user = UserDefaultsCustom.getUserData()
//        if let user_name = user?.user_name {
//            name = user_name
//        } else if let n = user?.name {
//            name = n
//        }
//        var addressText = "\(name) shared document file :"
//        if let url = fileUrl {
//            addressText += "\n\n\(url)"
//        }
//        return addressText
//    }
    
//    static func getDocShareText() -> String {
//        var name = ""
//        let user = UserDefaultsCustom.getUserData()
//        if let user_name = user?.user_name {
//            name = user_name
//        } else if let n = user?.name {
//            name = n
//        }
//        let addressText = "\(name) shared document file :\n\n"
//        return addressText
//    }
//
    
    
//    static func getFeedShareText(url: String) -> String {
//        var name = ""
//        let user = UserDefaultsCustom.getUserData()
//        if let user_name = user?.user_name {
//            name = user_name
//        } else if let n = user?.name {
//            name = n
//        }
//        var text = "\(name) shared feed : \n\n"
//        text += "Feed link:\n\(url)\n\n"
//
//        if let url = FirebaseDynamicLink.shared.myProfileUrl {
//            text += "\(name)'s profile link\n\(url)\n\n"
//        }
//        text += "MeetWise will save your time and money in your day-to-day activities. Reduce many hours of repetitive tasks."
//        return text
//    }
//
//    static func getNotesShareText(title: String, description:String) -> String {
//        var name = ""
//        let user = UserDefaultsCustom.getUserData()
//        if let user_name = user?.user_name {
//            name = user_name
//        } else if let n = user?.name {
//            name = n
//        }
//        var text = "\(name) shared note: \n\n"
//        text += "\(title):\n"
//        text += "\(description)\n\n"
//
//        text += "MeetWise will save your time and money in your day-to-day activities. Reduce many hours of repetitive tasks."
//        return text
//    }
    
//    static func getExpenseShareText(purpose: String, amount:Int, recipt:[String]) -> String {
//        var name = ""
//        let user = UserDefaultsCustom.getUserData()
//        if let user_name = user?.user_name {
//            name = user_name
//        } else if let n = user?.name {
//            name = n
//        }
//        var text = "\(name) shared expense: \n\n"
//        text += "\(Str.spendPurpose)\n\(purpose)\n\n"
//        text += "\(Str.spendAmount) : \(amount)\n\n"
//        if recipt.count > 0 {
//            text += "\(Str.receipt)\n\(recipt.joined(separator: "\n"))"
//        }
//        text += "\n\nMeetWise will save your time and money in your day-to-day activities. Reduce many hours of repetitive tasks."
//        return text
//    }
//
    
//    static func getNoteShareText(title: String, description: String) -> String {
//        var name = ""
//        let user = UserDefaultsCustom.getUserData()
//        if let user_name = user?.user_name {
//            name = user_name
//        } else if let n = user?.name {
//            name = n
//        }
//        var text = "\(name) shared note :\n\n"
//
//        text += "\(title):\n\(description)\n\n"
//        if let url = FirebaseDynamicLink.shared.myProfileUrl {
//            text += "\(name)'s profile link\n\(url)\n\n"
//        }
//        text += "MeetWise will save your time and money in your day-to-day activities. Reduce many hours of repetitive tasks."
//        return text
//    }
//
//
    
//    static func getContactInfoShareText(countryCode: String?, phone:String?, email:String?) -> String {
//        var name = ""
//        let user = UserDefaultsCustom.getUserData()
//        if let user_name = user?.user_name {
//            name = user_name
//        } else if let n = user?.name {
//            name = n
//        }
//        var text = "\(name) shared contact info :"
//        if let phoneNO = phone {
//            if let country = countryCode {
//                text += "\n\(Str.phoneNumber)\n\(country)\(phoneNO)\n\n"
//            } else {
//                text += "\n\(Str.phoneNumber)\n\(phoneNO)\n\n"
//            }
//        }
//        if let email = email {
//            text += "\(Str.email)\n\(email)\n\n"
//        }
//        if let url = FirebaseDynamicLink.shared.myProfileUrl {
//            text += "\(name)'s profile link\n\(url)\n\n"
//        }
//        text += "MeetWise will save your time and money in your day-to-day activities. Reduce many hours of repetitive tasks."
//        return text
//    }
    
    
//    static func getWorkProfileShareText(workProfileData: MWWorkProfileData?) -> String {
//        let data = workProfileData?.work_profile
//
//        var name = ""
//        let user = UserDefaultsCustom.getUserData()
//        if let user_name = user?.user_name {
//            name = user_name
//        } else if let n = user?.name {
//            name = n
//        }
//        var text = "\(name) shared work profile info :\n"
//
//        if let business_name = data?.business_name {
//            text += "\(Str.businessName)\n\(business_name)\n\n"
//        }
//        if let business_email = data?.business_email {
//            text += "\(Str.businessDomain)\n\(business_email)\n\n"
//        }
//        let contact = workProfileData?.work_phone_nos?.first
//        if let phoneNO = contact?.phone_no {
//            if let country = contact?.country_code {
//                text += "\(Str.phoneNumber)\n\(country)\(phoneNO)\n\n"
//            } else {
//                text += "\(Str.phoneNumber)\n\(phoneNO)\n\n"
//            }
//        }
//        if let website_link = data?.website_link {
//            text += "\(Str.websiteLink)\n\(website_link)\n\n"
//        }
//        if let business_bio = data?.business_bio {
//            text += "\(Str.bio)\n\(business_bio)\n\n"
//        }
//        if let business_addresses = data?.business_addresses?.first {
//            text += Str.getShareAddress(data: business_addresses)
////            let address = business_addresses.map({$0.address ?? ""}).joined(separator: ", ")
////            text += "\(Str.address)\n\(address)\n\n"
//        }
//        if let url = FirebaseDynamicLink.shared.myProfileUrl {
//            text += "\(name)'s profile link\n\(url)\n\n"
//        }
//        text += "MeetWise will save your time and money in your day-to-day activities. Reduce many hours of repetitive tasks."
//        return text
//    }
    
//    static func getCustomDetailsShareText(data: CustomDetailDataModel) -> String {
//        var name = ""
//        let user = UserDefaultsCustom.getUserData()
//        if let user_name = user?.user_name {
//            name = user_name
//        } else if let n = user?.name {
//            name = n
//        }
//        var text = "\(name) shared custom details :\n"
//
//        if let title = data.title {
//            text += "\(Str.title)\n\(title)\n\n"
//        }
//        if let description = data.description {
//            text += "\(Str.description)\n\(description)\n\n"
//        }
//        if let media = data.media, media.count > 0 {
//            let mediaText = media.map({$0.urlStr ?? ""}).joined(separator: "\n")
//            text += "\(Str.media)\n\(mediaText)\n\n"
//        }
//
//        if let url = FirebaseDynamicLink.shared.myProfileUrl {
//            text += "\(name)'s profile link\n\(url)\n\n"
//        }
//        text += "MeetWise will save your time and money in your day-to-day activities. Reduce many hours of repetitive tasks."
//        return text
//    }
    
    static func getMeetWiseShareText(name:String, profile:String,  url:String) -> String {
        var text = "\(name) invited you to join MeetWise.\n\n"
        text += "World's 1st ever communication and collaboration tool for all age groups\n\n"
        text += "Designed and developed in India for the World\n\n"
        text += "Grab your unique username before someone takes it.\n\n"
        text += "initial Free-Launch for all.\n\n"
        text += "\(profile)'s profile link\n\(url)\n\n"
        text += "MeetWise will save your time and money in your day-to-day activities. Reduce many hours of repetitive tasks.\n\n"
        text += "Don't miss your unique username Install Now."
        return text
    }
    
    static func getProfileShareText(name: String, profile:String,  url:String) -> String {
        var text = ""//"\(name) invited you to join MeetWise.\n\n"
//        text += "World's 1st ever communication and collaboration tool for all age groups\n\n"
//        text += "Designed and developed in India for the World\n\n"
//        text += "Grab your unique username before someone takes it.\n\n"
//        text += "initial Free-Launch for all.\n\n"
//        text += "\(profile)'s profile link\n\(url)\n\n"
//        text += "MeetWise will save your time and money in your day-to-day activities. Reduce many hours of repetitive tasks.\n\n"
//        text += "Don't miss your unique username Install Now."
        
        text = "MeetWise Profile has been shared by \(name).\nPlease join by following link\n\(url)\n\nMeetWise will save your time and money in your day-to-day activities. Reduce many hours of repetitive tasks."
        return text
    }
    
}

//MARK:-
extension Str {
    static let lastSeen = "Last Seen"
}






struct Messages {
    static let enterEmail = "Please enter your Email ID"
    static let enterValidEmail = "Please enter valid Email ID"
    static let enterPassword = "Please enter your password"
    static let enterConPassword = "Please enter confirm password"
    static let conValidPassword = "Password should be 6 character long"
    static let bothPasswordNotSame = "Password and confirm password are not same"
    static let validPassword = "Password should be 6 characters long"
    static let enterValidPassword = "Please enter valid password"
    static let enterFirstName = "Enter your first name"
    static let enterLastName = "Enter your last name"
    static let enterPhone = "Enter your phone number"
    static let changePasswrodDesc = "Please enter the new password and confirm new password"
    
    
    static let mediaAddedSuccessfully = "Media added successfully"
    static let documentAddedSuccessfully = "Document added successfully"
    static let areYouSureYouWantToDeleteThisGroup = "Are you sure,\nYou want to delete this group?"
    static let areYouSureYouWantToDeleteThisComment = "Are you sure,\nYou want to delete this comment?"
    static let mediaNotAvailable = "Media not available!"
    static let feedsNotAvailable = "Feeds not available"
    static let noEventMeetingAreFound = "No Events & Meetings \nare found!"
    static let areYouSureYouWantToSubmitThisTask = "Are you sure you want to mark this task completed"
    static let areYouSureYouWantToClearAllNotifications = "Are you sure you want to clear all notifications"
    static let thisPollIsFinishedPleaseCheckResult = "This poll is finished, please check result."
    static let areYouSureYouWantToDeleteThisExpense = "Are you sure you want to delete this expense?"
    
    static let meetingMissedMesage = "Oops, You missed this Meeting!"
    static let eventMissedMesage = "Oops, You missed this Event!"
    static let pleaseAddYourWorkProfileBeforeSharing = "Please add your work profile before share."
    
    static let noDataFound = "No data found!"
    
    
    
//    static func youCanNotCreateAPostWithPastTime(type:POST_TYPE) -> String {
//        return "You can not create \(type.title.lowercased()) with past time"
//    }
//
    
//    static func getNotificationMessage(notification: NotificationData?) -> String {
//        let name = notification?.user_id?.user_name ?? ""
//        switch notification?.notification_type {
//        case .newMeeting :
//            return ""
//        case .newEvent :
//            return ""
//        case .eventStatus :
//            return ""
//        case .eventDelay :
//            return ""
//        case .meetingDelay :
//            return ""
//        case .meetingStatus :
//            return ""
//        case .newPoll :
//            return ""
//        case .newTask :
//            return ""
//        case .likeFeed :
//            return ""
//        case .commentFeed :
//            return ""
//        case .followUser :
//            return ""
//        case .viewProfile :
//            return ""
//        default: return ""
//        }
//    }
    
}

struct ErrorMessage {
    
    static let enterValidFirstName = "Enter valid first name."
    static let enterValidLastName = "Enter valid last name."
    static let enterValidMoblie = "Enter your mobile number."
    static let enterValidEmail = "Enter your valid email."
    static let enterValidPassword = "Enter valid password."
    static let enterValidOtp = "Enter valid OTP"
    static let enterPhoneNumber = "Enter your phone number"
    static let enterPasswordConfirmPasswordSame = "Enter password and confirm password same."
    static let wrongPaymentInformation = "Wrong payment information. Please try again."
    static let pleaseEnterYourOrdeId = "Please enter your order Id!"
    static let nameIsRequired = "Name is required"
    static let messageIsRequired = "Message is required"
    static let enterValidProfileName = "Enter valid profile name."
    static let selectProductToReturn = "Select product to return"
    static let selectAnyContactForInvite = "Please select at least one contact to Invite"
    static let wrongFileSize = "Accepted file size upto 20mb"
    static let selectLocationOnMap = "Please select location on map"
    static let enterQuestion = "Please ask a question..."
    static let selectStartDate = "Select start date"
    static let selectStartTime = "Select start time"
    static let selectEndTime = "Select end time"
    static let selectEndDate = "Select end date"
    static let enterTitle = "Please enter title"
    static let enterFullName = "Enter full name"
    static let enterEmailId = "Enter email"
    static let enterCorrectEmailId = "Enter correct email"
    static let enterDescription = "Enter description"
    static let addMoreOptions = "Please add more options"
    static let usernameNotAvailable = "Username not available"
    static let pleaseEnterEventTitle = "Please enter Event title"
    static let fileAlreadySaved = "File already saved."
    static let pdfSuccessfullySaved = "PDF successfully saved!"
    static let pdfCouldNotBeSaved = "Pdf could not be saved"
    static let businessDomainHaveWrongFormat = "Business Email ID wrong format"
    static let contactNoIsInvalid = "Contact no is invalid"
    static let websiteLinkHaveWrongFormat = "Website URL wrong format."
    static let pleaseEnterTaskTitle = "Please enter task title"
    static let userNameShouldContainMimum3Characters = "User name should contain minimum 3 characters"
}

extension Int {
    var toString: String {
        return "\(self)"
    }
}


//enum POP_IMAGE : UIImage {
//    case congratulations = raw
//}

//enum Filter: String {
//    case all = "All"
//    case meetwise = "MeetWise"
//}

enum INVITATION_TYPE {
    case inviteMember
    case inviteFriends
    case assignTask
    case shareWithFriends 
    
    var title: String {
        switch self {
        case .inviteMember:
            return "Invite Participants"
        case .inviteFriends:
            return "Invite Participants"
        case .assignTask:
            return "Assign task"
        case .shareWithFriends:
            return "Share with friends"
        }
    }
    
}

enum CountType: String {
    case share = "Share"
    case view = "View"
}


enum AnalyticsDataType: String, Codable {
    case totalHoursInMeeting = "totalHoursInMeeting"
    case totalMeetingCreated = "totalMeetingCreated"
    case totalMeetingAttended = "totalMeetingAttended"
    case totalHoursInEvent = "totalHoursInEvent"
    case totalEventsCreated = "totalEventsCreated"
    case totalEventsAttended = "totalEventsAttended"
    case totalImagesUploaded = "totalImagesUploaded"
    case totalVideosUploaded = "totalVideosUploaded"
    case totalPollsCreated = "totalPollsCreated"
    case totalPollsShared = "totalPollsShared"
    case totalTasksCreated = "totalTasksCreated"
    case totalTasksAssigned = "totalTasksAssigned"
    case totalContacts = "totalContacts"
    case totalFeeds = "totalFeeds"
    
}
    
extension AnalyticsDataType {
    var title: String {
        switch self {
        case .totalHoursInMeeting, .totalHoursInEvent: return "Hrs"
        case .totalMeetingCreated, .totalMeetingAttended : return "Meetings"
        case .totalEventsCreated, .totalEventsAttended: return "Events"
        case .totalPollsCreated, .totalPollsShared: return "Polls"
        case .totalTasksCreated, .totalTasksAssigned: return "Tasks"
        case .totalVideosUploaded: return "Videos"
        case .totalImagesUploaded: return "Images"
        case .totalContacts: return "Contacts"
        case .totalFeeds: return "Feeds"
        }
    }
    
    var description: String {
        switch self {
        case .totalHoursInMeeting: return "Total Hours Spend in Meeting"
        case .totalMeetingCreated: return "Total Numbers of Meeting Created"
        case .totalMeetingAttended: return "Total Number of Meeting Attended"
        case .totalHoursInEvent: return "Total Hours Spend in Event"
        case .totalEventsCreated: return "Total Numbers of Event Created"
        case .totalEventsAttended: return "Total Number of Event Attended"
        case .totalVideosUploaded: return "Total Number of Videos Uploaded"
        case .totalImagesUploaded: return "Total Images Uploaded"
        case .totalContacts: return "Total Contacts"
        case .totalFeeds: return "Total Feeds Sent"
        case .totalPollsCreated: return "Total Polls Created"
        case .totalPollsShared: return "Total Polls Shared"
        case .totalTasksCreated: return "Total Tasks Created"
        case .totalTasksAssigned: return "Total Tasks Assigned"
        }
    }
    
    var icon: UIImage {
        switch self {
        case .totalHoursInMeeting, .totalMeetingCreated, .totalMeetingAttended: return #imageLiteral(resourceName: "ic_meetings_analytics")
        case .totalHoursInEvent, .totalEventsCreated, .totalEventsAttended: return #imageLiteral(resourceName: "ic_event_analytics")
        case .totalVideosUploaded: return #imageLiteral(resourceName: "ic_video_analytics")
        case .totalImagesUploaded: return #imageLiteral(resourceName: "ic_image_analytics")
        case .totalContacts: return #imageLiteral(resourceName: "ic_contact_analytics")
        case .totalFeeds: return #imageLiteral(resourceName: "ic_feed_analytics")
        case .totalPollsCreated, .totalPollsShared: return #imageLiteral(resourceName: "ic_poll_analytics")
        case .totalTasksCreated, .totalTasksAssigned: return #imageLiteral(resourceName: "ic_task_analytics")
        }
    }
    
    var backgoundColor: UIColor {
        switch self {
        case .totalHoursInMeeting, .totalMeetingCreated, .totalMeetingAttended:
            return UIColor(hexString: "FC573B")
            
        case .totalHoursInEvent, .totalEventsCreated, .totalEventsAttended:
            return UIColor(hexString: "34C1A2")
            
        case .totalVideosUploaded:
            return  UIColor(hexString: "26C6DA")
            
        case .totalPollsCreated, .totalPollsShared:
            return UIColor(hexString: "26C6DA")
            
        case .totalImagesUploaded:
            return UIColor(hexString: "FFD54F")
            
        case .totalContacts:
            return UIColor(hexString: "D079FF")
            
        case .totalFeeds:
            return UIColor(hexString: "5974FE")
            
        case .totalTasksCreated, .totalTasksAssigned:
            return UIColor.ic_blueBlue
        }
    }
    
}
