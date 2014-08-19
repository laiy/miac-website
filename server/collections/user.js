/*
 *user
 *{
 *    _id: ObjectID,
 *    identity: string,
 *    headPortrait: ObjectID,
 *    account: string,
 *    password: {
 *        identity: string, // = sha1(sha1(原始密码) + salt)
 *        salt: string
 *    }, 
 *    email: string,
 *    createdArticles: [ObjectID],
 *    createdShares: [ObjectID],
 *    createdDiscuss: [ObjectID],
 *    createdAlbums: [ObjectID],
 *    createdWorks: [ObjectID]
 *}
 */
