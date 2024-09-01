

abstract class SocialAppStates{}

class AppInitialState extends SocialAppStates{}

class AppChangeTabBarItemsState extends SocialAppStates{}

class ChangeLocalToArState extends SocialAppStates{}

class ChangeLocalToEnState extends SocialAppStates{}

class SocialGetUserLoadingState extends SocialAppStates{}

class SocialProfileImagePickedSuccessState extends SocialAppStates{}

class SocialProfileImagePickedErrorState extends SocialAppStates{}

class SocialCoverImagePickedSuccessState extends SocialAppStates{}

class SocialCoverImagePickedErrorState extends SocialAppStates{}

class SocialGetUserSuccessState extends SocialAppStates{}

class SocialGetUserErrorState extends SocialAppStates
{
  final String error;

  SocialGetUserErrorState(this.error);
}

class SocialUploadProfileImageSuccessState extends SocialAppStates{}

class SocialUploadProfileImageErrorState extends SocialAppStates{}

class SocialGetUploadedProfileImageErrorState extends SocialAppStates{}

class SocialUploadCoverImageSuccessState extends SocialAppStates{}

class SocialUploadCoverImageErrorState extends SocialAppStates{}

class SocialGetUploadedCoverImageErrorState extends SocialAppStates{}

class SocialUpdateUserLoadingState extends SocialAppStates{}

class SocialUpdateUserErrorState extends SocialAppStates{}

// create post

class SocialCreatePostLoadingState extends SocialAppStates{}

class SocialCreatePostSuccessState extends SocialAppStates{}

class SocialCreatePostErrorState extends SocialAppStates{}

class SocialPostImagePickedSuccessState extends SocialAppStates{}

class SocialPostImagePickedErrorState extends SocialAppStates{}

class SocialRemovePostImageState extends SocialAppStates{}

// Get Post

class SocialGetPostLoadingState extends SocialAppStates{}

class SocialGetPostSuccessState extends SocialAppStates{}

class SocialGetPostErrorState extends SocialAppStates
{
  final String error ;

  SocialGetPostErrorState(this.error);
}
// Change Like Icon
class SocialChangeLikeIconSuccessState extends SocialAppStates{}



// Post Likes

class SocialPostLikeSuccessState extends SocialAppStates{}

class SocialChangePostLikeState extends SocialAppStates{}

class SocialDeleteMySuccessState extends SocialAppStates{}

class SocialPostLikeErrorState extends SocialAppStates
{
  final String error ;

  SocialPostLikeErrorState(this.error);
}

// Post Comment

class SocialPostCommentLoadingState extends SocialAppStates{}

class SocialPostCommentSuccessState extends SocialAppStates{}

class SocialPostCommentErrorState extends SocialAppStates
{
  final String error ;

  SocialPostCommentErrorState(this.error);

}



class SocialGetCommentLoadingState extends SocialAppStates{}

class SocialGetCommentSuccessState extends SocialAppStates{}

class SocialGetCommentErrorState extends SocialAppStates
{
  final String error ;

  SocialGetCommentErrorState(this.error);

}

class SocialRemoveCommentsState extends SocialAppStates{}

class SocialGetAllUsersLoadingState extends SocialAppStates{}

class SocialGetAllUsersSuccessState extends SocialAppStates{}

class SocialGetAllUsersErrorState extends SocialAppStates{}

class SocialSendMessageSuccessState extends SocialAppStates{}

class SocialSendMessageErrorState extends SocialAppStates{}

class SocialGetAllMessagesSuccessState extends SocialAppStates{}

class SocialGetAllMessagesErrorState extends SocialAppStates{}






