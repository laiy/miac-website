Modern Internet Application Club（MIAC）Website
=======================

[Modern Internet Application Club（MIAC）website](http://sysumiac.com)

## Function Imagination
* Index:
	* Show club website latest infomations including articles, discussions, albums
* Publish Article:
	* Club members are capabile of publishing technology article
	* Others could comment as well as reply
	* Article classification: category
	* Search article
* Discussion Wall:
	* （Stackoverflow of SYSU version）
	* Publish a topic
	* Capable of commenting and discussing
	* Up or down
	* Search discussion
* Album:
	* Club members could upload club's photos
* Works Show:
	* Showing works form MIAC
* About Us:
	* Introdution of club
	* Appreciation
	* Donation
* Backstage(admin):
	* CRUD of articles, discussions, albums, etc.
	* Member management
	* ...

* * *
**Member Tactics**: Everyone could be a user of website，but some priority are only for club's member(publish article, upload photos, etc.)

**Member Classification**:

1. Tourist：(permission to read)
	* Browse articles
	* Browse discussions
	* Browse albums
2. User: (permission to read and write partly)
	* Browse and commemt articles, but not publish
	* Browse and comment discussions, but not publish
	* Browse and comment albums, but not upload
3. Club member: (permission to read and write)
	* Browse commemt, and publish articles
	* Browse commemt, and publish discussions
	* Browse commemt, and upload albums
4. Admin: (manager)
	* All authorities are available
	* Backstage manament

## Team construction
* Share and Discuss
	* github wiki
* Teamwork
	* github
* Assignment Management
	* github issues
* Document Management
	* github wiki
	* Markdown README

## Technical Architecture
* Version Management(git & github)
* Back-end
	* Language: Node.js
	* MVC Framework: [Express](http://expressjs.com/)
	* Database: Mongoose
    * Project Structuring Tools: Grunt, Npm, Mocha
* Front-end
	* [jQuery](http://www.jquery.com)
	* [Jade](http://jade-lang.com/)
    * [Sass](http://sass-lang.com/)
    * [CoffeeScript](http://coffeescript.org/)
    * MVVM Framework: [VueJS](http://vuejs.org/)

## License
[MIT](http://mutedsolutions.mit-license.org/)

## Powered By
[miac-website](https://github.com/laiy/miac-website)
