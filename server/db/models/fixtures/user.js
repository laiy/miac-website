var user = {
  _id: "user-id-1", // ObjectID
  username: "Shin", // string
  password: "xxxxx", // identity = sha1(sha1(原始密码) + username) string ,
  avatar: "/pictures/xxx", // string
  email: "bossonchan@gmail.com", // string
  isAdmin: "false", // Boolean
  createdArticles: [{
    lastAccessTime: "2014-01-01", // Date
    id: "article-id-1" // ObjectID 
  }],
  createdShares: [{
    lastAccessTime: "2014-02-02", // Date
    id: "share-id-1" // ObjextID
  }],
  createdDiscuss: [{
    lastAccessTime: "2014-02-02", // Date
    id: "discuss-id-1" // ObjectID
  }],
  createdAlbums: [{
    lastAccessTime: "2014-02-02", // Date
    id: "album-id-1" // ObjectID
  }],
  createdWorks: [{
    lastAccessTime: "2014-02-02", // Date
    id: "work-id-1" // ObjectID
  }]
};
