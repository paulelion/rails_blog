class CommentsController < ApplicationController
	before_action :find_comment, only: [:create, :destroy]    
    before_action :comment_auth, only: [:destroy]    


	def create
	  @post = Post.find(params[:post_id])
	  @comment = @post.comments.create(params[:comment].permit(:name, :body))
	  @comment.user_id = current_user.id if current_user
	  @comment.save

	  if @comment.save!
	    redirect_to post_path(@post)
	  else
	    render 'new'
	  end
	end  

    def destroy    
        @comment = @post.comments.find(params[:id]).destroy    
        redirect_to post_path(@post)   
    end    

    private    

	    def comment_params    
	        params.require(:comment).permit(:user_id, :name, :body)    
	    end   

	    def find_comment    
	        @post = Post.find(params[:post_id])    
	    end   

	    def comment_auth    
	        if current_user != @post.user    
	        redirect_to(root_path)   
	        end    
    	end
end    

