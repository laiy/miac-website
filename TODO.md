## TODO

### Current Mission

1. Finish front-end UI based on design chart by Yujie. (win7, Qinghui, Jiawei)
2. Front-back abutment. (win7, Qinghui, Jiawei)
3. Back-end work based on front-end requirement. (LY)

### Specific Illustration

> The basic front-back code is writen as you can see, but it's just a test by LY, don't code on account of that code, of course you can consider it as a reference.

1. Each jade directing only one css and js, and the name of file is the same, e.g. about.jade -> bin/css/about,css, bin/js/about.js.
2. Every source code should be writen in src, e,g. about,jade -> src/coffee/about.coffee, src/sass/about.sass.
3. All you should write is jade, coffee, sass, and I have writen a Gruntfile for you to code more fluently.

### How To Run

> Developing environment building in /server path, and on this environment, you should visit localhost:3000, all your change on file(coffee, sass) would compile to js and css, and the browser would reload automatically.

1. # sudo npm install (for the first time you run this environment)
2. # npm start
3. # grunt

### Basic Skill You Need

> You should learn jQuery, Coffeescript, Sass and jade, my suggestion is reading the doc from authority website.

1. jQuery
2. Coffeescript
3. Sass
4. Jade
4. VueJS (MVVM Framework, instead of DOM operation in jQuery)

### Teamwork

> We use github for team cooperation

1. Fork the source code from https://github.com/laiy/miac-website to your own reposity.
2. # git clone https://github.com/{your_github_name}/miac-website
3. Coding.
4. All of your work is on your own reposity, you can push to your own reposity for some stages.
5. When you finished, merge your code to souce code https://github.com/laiy/miac-website.

### Other Requirement

1. Code style: Google style
2. Code model: OOP
3. Write some annotations if neccessary, at least those of a class or a module.

### Demo

> I have writen a demo for you, you can consider it as a reference.

1. https://github.com/laiy/miac-website/blob/master/server/views/src/sass/header.sass
2. https://github.com/laiy/miac-website/blob/master/server/views/src/coffee/header.coffee
3. https://github.com/laiy/miac-website/blob/master/server/views/includes/header.jade

### Specific Work Division

> I would make a division recently, all your work now is to learn basic skill and configure the developing environment.

1. login + register + userInfo (win7)
2. article + childArticle + createArticle (Jiawei)
3. album + childAlbum + createAlbum (Jiawei)
4. discuss + childDiscuss + createDiscuss (win7)
5. index + about + works (Qinghui)
6. includes/ (LY coded as a demo)

