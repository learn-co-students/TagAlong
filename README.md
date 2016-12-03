# ios-0916-team-carrotcoat
			
Brief: 

This app provides restaurant choices to a user based on preferences such as location, food choices, and budget.  The app is unique in that users “shake” their mobile device to switch between cuisine preferences and are given a number of restaurant options to related to their cuisine. Upon viewing these options, the user can then “swipe left/deny” or “swipe right/accept” on a restaurant choice. When the user has confirmed their choice of restaurant and their preferred time, the user will be matched with another user who has also chosen the same restaurant and time. The users will then be given the option to “accept” or “deny” dining together.  If both users “accept” then they are both directed to information about their chosen restaurant (map of location, menu, hours of operation).   

Use Case: 

Our app provides a quicker way to get a selection of food choices and gives users an option to meet a new person who shares their food preferences.  We want users to have a quick and convenient way to choose where and what they are eating that day as well as meet someone new!

User Access Rules

●	App is free.
●	The user will need to grant app permission to access their current location to receive food/restaurant choices.
●	Users preferences will be stored locally on a user’s device so no login form is required.
●	The user will be provided with a “block” option to block another matched user.

App Architecture

●	Login View (optional) - Users who want the option to network with new people will create a user profile.
●	Preferences View - User sets their preferences for cuisines, budget and location (proximity)
●	Restaurant Choices View - A custom interface with Restaurant represented as individual cards. (Think Tinder like interface) Each card would contain name, picture/image, and then a table with distance, cost, cuisine, and hours.
●	Matched Stranger View - User (who has opted into dining with strangers) will see the photo/profile of their matched stranger and have an option to “contact” or “cancel”.
●	Detail Restaurant View - A detail view of the selected restaurant with info (i.e. map of location)

Resources/Technologies 

●	Google Places API
●	Core Location
●	Core Motion
●	Database (Firebase)
●	Chat (Firebase)

